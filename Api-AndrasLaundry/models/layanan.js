const mongoose = require('mongoose')
const Schema = mongoose.Schema

const layananSchema = new Schema({
    layanan: {
        type: String
    },
})

module.exports = mongoose.model('layanan', layananSchema)