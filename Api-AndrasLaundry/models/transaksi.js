const mongoose = require('mongoose')
const Schema = mongoose.Schema
const objectId = mongoose.Types.ObjectId

const transaksiSchema = new Schema({
    idUser:{
        type:objectId
    },
    namaPelanggan:{
        type:String
    },
    noTelepon:{
        type:Number
    },
    idPaket:{
        type:objectId
    },
    idLayanan:{
        type:objectId
    },
    status:{
        type:Number,
        default:0
    },
    buktiPembayaran:{
        type:String
    },
    tanggal:{
        type:Date,
        default:new Date().toLocaleDateString()
    }
})


module.exports=mongoose.model('transaksi',transaksiSchema)