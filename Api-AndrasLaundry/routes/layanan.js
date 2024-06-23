const router = require('express').Router()
const layananController = require('../controllers/layananController')
const uploadConfig = require('../uploadConfig')

router.post('/create', (req, res) => {
  // console.log(req.body)
  layananController.create(req.body)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.put('/edit/:id', (req, res) => {
  const data = req.body
  console.log(data)
  layananController.edit(req.params.id, data)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


router.get('/getalllayanan', (req, res) => {
  layananController.getData()
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.get('/getbyid/:id', (req, res) => {
  console.log(req.params.id)
  layananController.getById(req.params.id)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.delete('/delete/:id', (req, res) => {
  layananController.delete(req.params.id)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


module.exports = router