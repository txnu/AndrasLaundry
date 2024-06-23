const mongoose = require('mongoose')
const Schema = mongoose.Schema
const objectId = mongoose.Types.ObjectId

const transaksiSchema = new Schema({
    idUser: { type: mongoose.Schema.Types.ObjectId, ref: 'user' },
    idPaket: { type: mongoose.Schema.Types.ObjectId, ref: 'paketlaundry'},
    idLayanan: { type: mongoose.Schema.Types.ObjectId, ref: 'layanan' },
    idPromo: { type: mongoose.Schema.Types.ObjectId, ref: 'promo', default: null },
    status: { type: Number, default: 0 },
    buktiPembayaran: { type: String, default: null },
    berat: { type: Number , default: 0 },
    detail: { type: String, default: null },
    tanggal: {
        type: Date,
        default: new Date().toLocaleDateString(),  // format DD/MM/YYYY
    },
});


module.exports=mongoose.model('transaksi',transaksiSchema)