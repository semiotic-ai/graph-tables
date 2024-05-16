import readline from 'node:readline';
import { searchSubgraph, getLayout } from './service';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('What is the name of the subgraph? ', async (search) => {
  const subgraphs = await searchSubgraph(search);

  if (subgraphs.length === 0) {
    console.log('No subgraph found');
    rl.close();
  } else {
    console.log('First 20 subgraphs found: ');
    subgraphs.forEach((subgraph, index) => {
      console.log(`${index + 1}. ${subgraph.displayName}`);
    });

    rl.question('Enter subgraph index to view the database layout: ', async (index) => {
      const selectedSubgraph = subgraphs[parseInt(index, 10) - 1];
      console.log(`Selected subgraph: ${selectedSubgraph.displayName}`);
      console.log(`Fetching layout... %s`, selectedSubgraph.deploymentSchemaId);
      const layout = await getLayout(selectedSubgraph.deploymentSchemaId);
      console.log('Database layout: ');
      console.log('\tEnums:');
      [...layout.enums.entries()].forEach(([name, values]) => {
        console.log(`\t\t${name}: ${values.join(',')}`);
      });

      console.log('\tTables:');
      [...layout.tables.entries()].forEach(([name, table]) => {
        console.log(`\t\t${name}`);
        [...table.columns.entries()].forEach(([name, column]) => {
          console.log(`\t\t\t${name}`);
        });
      });

      rl.close();
    });
  }
});
