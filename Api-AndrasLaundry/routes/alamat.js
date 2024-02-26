const router = require('express').Router()
const alamatController = require('../controllers/alamatController')

router.post('/create', (req, res) => {
  // console.log(req.body)
  alamatController.create(req.body)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.put('/edit/:id', (req, res) => {
  console.log(data)
  alamatController.edit(req.params.id, data)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


router.get('/getall', (req, res) => {
  alamatController.getData()
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.get('/getbyid/:id', (req, res) => {
  console.log(req.params.id)
  alamatController.getById(req.params.id)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})

router.delete('/hapus/:id', (req, res) => {
  alamatController.delete(req.params.id)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


module.exports = router