const mongoose = require('mongoose')
const Schema = mongoose.Schema

const paketLaundrySchema = new Schema({
    namapaket: {
        type: String
    },
    harga: {
        type: String
    }
})

module.exports = mongoose.model('paketlaundry', paketLaundrySchema)