const mongoose = require('mongoose')
const Schema = mongoose.Schema

const userSchema = new Schema({
    namalengkap: {
        type: String
    },
    telepon: {
        type: String
    },
    username: {
        type: String
    },
    password: {
        type: String
    },
    alamat: {
        type: String,
        default: ''
    },
    role: {
        type: Number,
        default: 1 // 1 user biasa 2 admin
    },
    status: {
        type: Number,
        default: 0 // 0 tidak ready 1 ready
    }
})

module.exports = mongoose.model('user', userSchema)