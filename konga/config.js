module.exports = {
    // Configuration options for Konga
    // Modify these according to your setup
    NODE_ENV: 'development',
    DB_ADAPTER: 'postgres',
    DB_HOST: 'konga-postgresql',
    DB_PORT: '5432',
    DB_USER: process.env.POSTGRESQL_USER,
    DB_PASSWORD: process.env.POSTGRESQL_PASSWORD,
    DB_DATABASE: process.env.POSTGRESQL_DATABASE,
    TOKEN_SECRET: 'YOUR_TOKEN_SECRET_HERE',
  };
  