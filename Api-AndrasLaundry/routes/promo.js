const router = require('express').Router()
const promoController = require('../controllers/promoController');
const multer = require('multer');
const path = require('path');

router.post('/create', promoController.createPromo);
router.get('/getallpromos', promoController.getAllPromos);
router.get('/getbyid/:id', promoController.getPromoById);
router.put('/update/:id', promoController.updatePromo);
router.delete('/delete/:id', promoController.deletePromo);

module.exports = router;