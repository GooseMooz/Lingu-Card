const { Router } = require('express');
const controller = require('./controller');

const router = Router();

router.get('/', controller.getWords);
router.post('/random', controller.getRandomWords);
router.post('/', controller.addWord);
router.get('/:id', controller.getWordsById);
router.delete('/:id', controller.deleteWord);
router.put('/:id', controller.updateWord);

module.exports = router;