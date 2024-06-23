const mongoose = require('mongoose')
const Schema = mongoose.Schema

const promoSchema = new Schema({
    promo: {
        type: String,
        
    },
    keterangan: {
        type: String,
        
    },
    potongan: {
        type: Number,
    },
    image: {
        type: String,
        
    }
});

module.exports = mongoose.model('promo', promoSchema)