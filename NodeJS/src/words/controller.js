const pool = require('../../db.js');
const queries = require('./queries.js');

const getWords = (req, res) => {
    pool.query(queries.getWords, (err, results) => {
        if (err) throw err;
        res.status(200).json(results.rows);
    });
};

const getRandomWords = (req, res) => {
    const { number } = req.body;
    pool.query(queries.getNRandomWords, [number], (err, results) => {
        if (err) throw err;
        res.status(200).json(results.rows);
    });
}

const getWordsById = (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.getWordsById, [id], (err, results) => {
        if (err) throw err;
        res.status(200).json(results.rows);
    });
}

const addWord = (req, res) => {
    const { eng, rus, add } = req.body;

    pool.query(queries.checkWordExists, [eng], (err, results) => {
        if (results.rows.length) {
            res.send("Word already exists");
        }

        pool.query(queries.addWord, [eng, rus, add], (err) => {
            if (err) throw err;
            res.status(201).send("Word created successfully");
        });
    });
}

const deleteWord = (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.getWordsById, [id], (err, results) => {
        if (!results.rows.length) {
            res.send("Word does not exist");
        }

        else {
            pool.query(queries.deleteWord, [id], (err) => {
                if (err) throw err;
                res.status(200).send("Word deleted successfully");
            });
        }
    });
}

const updateWord = (req, res) => {
    const id = parseInt(req.params.id);
    const { eng } = req.body;
    const { rus } = req.body;
    const { add } = req.body;

    pool.query(queries.getWordsById, [id], (err, results) => {
        if (!results.rows.length) {
            res.send("Word does not exist");
        }
        else {
            pool.query(queries.updateWord, [eng, rus, add, id], (err) => {
                if (err) throw err;
                res.status(200).send("Word updated successfully");
            });
        }
    });
}


module.exports = {
    getWords,
    getWordsById,
    addWord,
    deleteWord,
    updateWord,
    getRandomWords,
};