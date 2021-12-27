const getWords = "SELECT * FROM words";
const getWordsById = "SELECT * FROM words WHERE id = $1";
const checkWordExists = "SELECT s FROM words s WHERE s.eng = $1";
const addWord = "INSERT INTO words (eng, rus, add) VALUES ($1, $2, $3)";
const deleteWord = "DELETE FROM words WHERE id = $1";
const updateWord = "UPDATE words SET eng = $1, rus = $2, add = $3 WHERE id = $4;"
const getNRandomWords = "SELECT * FROM words ORDER BY RANDOM() LIMIT $1"

module.exports = {
    getWords,
    getWordsById,
    checkWordExists,
    addWord,
    deleteWord,
    getNRandomWords,
    updateWord
};