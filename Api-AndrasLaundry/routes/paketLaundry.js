const router = require('express').Router()
const paketLaundryController = require('../controllers/paketLaundryController')
const uploadConfig = require('../uploadConfig')

router.post('/create', (req, res) => {
  // console.log(req.body)
  paketLaundryController.create(req.body)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.put('/edit/:id', (req, res) => {
  console.log(data)
  paketLaundryController.edit(req.params.id, data)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


router.get('/getall', (req, res) => {
  paketLaundryController.getData()
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.get('/getbyid/:id', (req, res) => {
  console.log(req.params.id)
  paketLaundryController.getById(req.params.id)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.delete('/hapus/:id', (req, res) => {
  paketLaundryController.delete(req.params.id)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


module.exports = router