import { parse, Layout } from '@semiotic-labs/graph-tables';

export const DEFAULT_SUBGRAPH_API_ENDPOINT =
  'https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-arbitrum'; // mainnet subgraphs
//  'https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-arbitrum-sepolia'; // testnet subgraphs

interface ISubgraphQuery {
  readonly query: string;
  readonly variables: Record<string, unknown>;
  readonly operationName: string;
  readonly extensions: Record<string, unknown>;
}

const SEARCH_TEMPLATE: ISubgraphQuery = {
  query: `query SearchbyName($search: String!, $first: Int!) {
    metas:subgraphMetas(
      where: {and: [{or: [{displayName_contains: $search}, {description_contains: $search}]}, {subgraph_: {id_not: null}}]}
      first: $first
    ) {
      id
      displayName
      image
      description
      subgraph {
        id
        currentVersion {
          id
          version
          subgraphDeployment {
            id
            ipfsHash
            indexerAllocations(where: {activeForIndexer_not: null}) {
              activeForIndexer {
                id
              }
            }
            manifest {
              network
              schema {
                id
              }
            }
          }
        }
      }
    }
  }
    `,
  variables: { search: '', first: 20 },
  operationName: 'SearchbyName',
  extensions: {}
};

interface ISubgraphSearchResult {
  readonly data: {
    readonly metas: {
      readonly id: string;
      readonly displayName: string;
      readonly description: string;
      readonly image: string;
      readonly subgraph: {
        readonly id: string;
        readonly currentVersion: {
          readonly id: string;
          readonly subgraphDeployment: {
            readonly id: string;
            readonly ipfsHash: string;
            readonly indexerAllocations: {
              readonly activeForIndexer: {
                readonly id: string;
              };
            }[];
            readonly manifest: {
              readonly schema: {
                readonly id: string;
              };
              readonly network: string;
            };
          };
        };
      };
    }[];
  };
}

/*
 * Basic subgraph and current version/deployment information
 */
export interface ISubgraphInfo {
  readonly id: string;
  readonly displayName: string;
  readonly description: string;
  readonly image: string;
  readonly currentVersion: string;
  readonly deploymentId: string;
  readonly network: string;
  readonly deploymentSchemaId: string;
  readonly activeIndexerAllocations: number;
  readonly ipfsHash: string;
}

export function CheapCopy<T>(value: T): T {
  return JSON.parse(JSON.stringify(value));
}

async function callGraphQL<B, R>(
  body: B,
  endpoint?: string,
  abortSignal?: AbortSignal,
  authorization?: string
): Promise<R> {
  endpoint = endpoint || DEFAULT_SUBGRAPH_API_ENDPOINT;

  const response = await fetch(endpoint, {
    headers: {
      accept: 'application/graphql-response+json, application/json, multipart/mixed',
      'accept-language': 'en-US,en;q=0.5',
      'content-type': 'application/json',
      Authorization: authorization || ''
    },
    body: JSON.stringify(body),
    method: 'POST',
    signal: abortSignal
  });

  const json_response: any = await response.json();

  if (Object.hasOwn(json_response, 'errors')) {
    throw new Error(json_response.errors.map((e: any) => e.message).join('\n'));
  }

  //@ts-ignore
  const result: R = json_response as R;

  return result;
}

function convertToSubgraphInfo(response: ISubgraphSearchResult): ISubgraphInfo[] {
  return response.data.metas.map((meta) => {
    return {
      id: meta.subgraph.id,
      displayName: meta.displayName,
      description: meta.description,
      image: meta.image,
      currentVersion: meta.subgraph.currentVersion.id,
      deploymentId: meta.subgraph.currentVersion.subgraphDeployment.id,
      network: meta.subgraph.currentVersion.subgraphDeployment.manifest.network,
      deploymentSchemaId: meta.subgraph.currentVersion.subgraphDeployment.manifest.schema.id,
      ipfsHash: meta.subgraph.currentVersion.subgraphDeployment.ipfsHash,
      activeIndexerAllocations:
        meta.subgraph.currentVersion.subgraphDeployment.indexerAllocations.length
    };
  });
}

/**
 * Search for subgraphs by name or description from a graph network subgraph API endpoint
 * @param search text to search in both display name and description of the subgraph
 * @param endpoint url of the graph network subgraph API endpoint (ie: https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-arbitrum)
 * @param abortSignal signal to cancel the request
 * @returns a list of `ISubgraphInfo` matching the search criteria
 */
export async function searchSubgraph(
  search: string,
  endpoint?: string,
  abortSignal?: AbortSignal
): Promise<ISubgraphInfo[]> {
  const body = CheapCopy(SEARCH_TEMPLATE);

  body.variables.search = search;

  const json_response: ISubgraphSearchResult = await callGraphQL(body, endpoint, abortSignal);

  const result: ISubgraphInfo[] = convertToSubgraphInfo(json_response);

  return result;
}

const SCHEMA_QUERY_TEMPLATE: ISubgraphQuery = {
  query: `query GetLayout($deploymentSchemaId: ID!) {
		subgraphDeploymentSchema(id:$deploymentSchemaId) {
			schema
	  }
	}`,
  variables: { deploymentSchemaId: '' },
  operationName: 'GetLayout',
  extensions: {}
};

interface ISchemaResponse {
  readonly data: {
    readonly subgraphDeploymentSchema: {
      readonly schema: string;
    };
  };
}

/**
 * Gets the database layout of a subgraph deployment by parsing the graphql schema based
 * on graph-node implementation
 * @param deploymentSchemaId deployment schema id of the subgraph
 * @param endpoint url of the graph network subgraph API endpoint or use default. (ie: https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-arbitrum)
 * @param abortSignal signal to cancel the request
 * @returns database layout
 */
export async function getLayout(
  deploymentSchemaId: string,
  endpoint?: string,
  abortSignal?: AbortSignal
): Promise<Layout> {
  const body = CheapCopy(SCHEMA_QUERY_TEMPLATE);

  body.variables.deploymentSchemaId = deploymentSchemaId;

  const json_response: ISchemaResponse = await callGraphQL(body, endpoint, abortSignal);

  const result = parse(json_response.data.subgraphDeploymentSchema.schema);

  return result;
}
