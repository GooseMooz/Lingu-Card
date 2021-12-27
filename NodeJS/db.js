const Pool = require('pg').Pool;

const pool = new Pool({
    user: 'GooseMooz',
    host: 'localhost',
    database: 'plup43',
    password: '0_0',
    port: 5432,
});

module.exports = pool;