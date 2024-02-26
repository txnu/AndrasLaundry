const mongoose = require('mongoose')
const Schema = mongoose.Schema

const alamatSchema = new Schema({
    alamat: {
        type: String
    },
    alamatTambahan: {
        type: String
    },
    rtrw: {
        type: String
    },
    kodepos: {
        type: String
    }
})

module.exports = mongoose.model('alamat', alamatSchema)