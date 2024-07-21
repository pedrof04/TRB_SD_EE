// Import necessary modules
const fs = require("fs");
const path = require("path");
const { Client } = require("pg");

const dbConfig = {
  host: "bl-db",
  port: 5432,
  user: "sd",
  database: "sd",
  password: "sd",
};

// HelloWorld module
const HelloWorld = {
  say: function () {
    console.log("Hello, World!!");
  },
};

// JSONObserver module
const JSONObserver = {
  list: function () {
    console.log("Listing all available JSON files!");
    try {
      const files = fs.readdirSync("/data");
      files.filter((file) => file.endsWith(".json")).forEach(this.processFile);
    } catch (error) {
      console.log(`Error accessing /data: ${error}`);
    }
  },

  processFile: function (fileName) {
    console.log(`Processing file: ${fileName}`);
    const filePath = path.join("/data", fileName);
    const content = fs.readFileSync(filePath, "utf8");
    JSONObserver.parse(content);
  },

  parse: function (content) {
    console.log(`JSON Content of the file: \n${content}`);
    try {
      const pokemons = JSON.parse(content).map((pokemon) => ({
        num: pokemon.num,
        name: pokemon.name,
        img: pokemon.img,
        type: pokemon.type,
        height: pokemon.height,
        weight: pokemon.weight,
        candy: pokemon.candy,
        candy_count: pokemon.candy_count,
        egg: pokemon.egg,
        spawn_chance: pokemon.spawn_chance,
        avg_spawns: pokemon.avg_spawns,
        spawn_time: pokemon.spawn_time,
        weaknesses: pokemon.weaknesses,
      }));

      await = this.insertToDatabase(pokemons);
    } catch (err) {
      console.error(`Error parsing JSON: ${err}`);
      return;
    }
  },
  // Inserir pokemons na base de dados
  insertToDatabase: async function (pokemons) {
    const client = new Client(dbConfig);
    console.log("Os pokemons que foram recebidos" + JSON.stringify(pokemons));

    try {
      await client.connect();
      console.log("Connected to the database.");
      //     const deleteData = `
      //     DELETE FROM " ";
      //     DELETE FROM " ";
      //     DELETE FROM " ";
      // `;
      // try {
      //     await client.query(deleteData);
      //     console.log(`All data deleted in Movies, Casts and Genres`);
      // } catch (err) {
      //     console.error(`Error delete=ing data: ${err}`);
      // }

      for (const pokemon of pokemons) {
        let typeId = await this.getOrInsertTypeId(client, pokemon.type);
        let weaknessesId = await this.getOrInsertWeaknessesId(
          client,
          pokemon.weaknesses
        );

        const query = `
                    INSERT INTO "Pokemons" 
                    (num, name, img, height, weight, candy, candy_count, egg, spawn_chance, avg_spawns, spawn_time, typeid, weaknessesid) 
                    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
                `;

        const values = [
          pokemon.num,
          pokemon.name,
          pokemon.img,
          pokemon.height,
          pokemon.weight,
          pokemon.candy,
          pokemon.candy_count,
          pokemon.egg,
          pokemon.spawn_chance,
          pokemon.avg_spawns,
          pokemon.spawn_time,
          typeId,
          weaknessesId,
        ];

        try {
          await client.query(query, values);
          console.log(`Inserted: ${JSON.stringify(pokemon)}`);
        } catch (err) {
          console.error(`Error inserting data: ${err}`);
        }
      }
    } catch (err) {
      console.error(`Database connection error: ${err}`);
    } finally {
      await client.end();
      console.log("Disconnected from the database.");
    }
  },

  getOrInsertTypeId: async function (client, typeName) {
    if (!typeName) return null;

    try {
      const res = await client.query(
        'SELECT typeid FROM "Type" WHERE name = $1',
        [typeName]
      );
      if (res.rows.length > 0) {
        return res.rows[0].typeid;
      } else {
        const insertRes = await client.query(
          'INSERT INTO "Type" (name) VALUES ($1) RETURNING typeid',
          [typeName]
        );
        return insertRes.rows[0].typeid;
      }
    } catch (err) {
      console.error(`Error getting/inserting the pokemon type: ${err}`);
      return null;
    }
  },

  getOrInsertWeaknessesId: async function (client, weaknessesName) {
    if (!weaknessesName) return null;

    try {
      const res = await client.query(
        'SELECT weaknessesid FROM "Weaknesses" WHERE name = $1',
        [weaknessesName]
      );
      if (res.rows.length > 0) {
        return res.rows[0].weaknessesid;
      } else {
        const insertRes = await client.query(
          'INSERT INTO "Weaknesses" (name) VALUES ($1) RETURNING weaknessesid',
          [weaknessesName]
        );
        return insertRes.rows[0].weaknessesid;
      }
    } catch (err) {
      console.error(`Error getting/inserting the pokemon weakness: ${err}`);
      return null;
    }
  },
};

// Application Module
const ImporterApplication = {
  start: function () {
    HelloWorld.say();
    JSONObserver.list();

    // Start a minimal supervision tree (Simulated as there's no real equivalent in Node.js)
    console.log("Application started");
  },
};

// Start the application
ImporterApplication.start();
