const { Client } = require("pg");

const client = new Client({
    connectionString: "postgresql://postgres:Strawberrymysql.0824@localhost:5432/postgres",
});

client.connect();

module.exports = client;
