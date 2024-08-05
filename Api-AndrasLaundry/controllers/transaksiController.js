const transaksiModel = require('../models/transaksi')
const mongoose = require('mongoose')
const objectId = mongoose.Types.ObjectId
const multer = require('multer')
const path = require('path')

// Configuring multer for file uploads
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './static');
    },
    filename: function (req, file, cb) {
        cb(null, new Date().toISOString().replace(/:/g, '-') + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage, limits: { fileSize: 2000000 } }).single('buktiPembayaran');

// Create transaction
exports.create = (req, res) => {
    upload(req, res, function (err) {
        if (err) {
            return res.status(500).json({
                sukses: false,
                msg: 'Gagal upload bukti pembayaran',
                error: err.message
            });
        }

        const { idUser, idPaket, idLayanan, idPromo, status, idDriver } = req.body;
        const buktiPembayaran = req.file ? req.file.filename : null;

        const newTransaksi = new transaksiModel({
            idUser,
            idPaket,
            idLayanan,
            idPromo,
            idDriver,
            status,
            buktiPembayaran,
        });

        newTransaksi.save()
            .then(() => {
                res.status(201).json({
                    sukses: true,
                    msg: 'Berhasil Transaksi'
                });
            })
            .catch((error) => {
                res.status(500).json({
                    sukses: false,
                    msg: 'Gagal Transaksi',
                    error: error.message
                });
            });
    });
};

// Get all transactions
exports.getAllTransaksi = async (req, res) => {
    try {
        const transaksis = await transaksiModel.find()
            .populate('idUser', 'namalengkap alamat telepon')  // Populate idUser to get user details
            .populate('idPaket', 'namapaket harga')  // Populate idPaket to get paket details
            .populate('idLayanan', 'layanan')  // Populate idLayanan to get layanan details
            .populate('idPromo', 'promo keterangan potongan')
            .populate('idDriver', 'namalengkap alamat telepon');  // Populate idPromo to get promo details

        res.status(200).json({
            status: 200,
            msg: 'Berhasil Mengambil Data',
            data: transaksis
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            msg: 'Gagal Mengambil Data',
            data: [],
            error: error.message
        });
    }
};



exports.getTransaksiById = async (req, res) => {
    const { id } = req.params;
    
    try {
        const transaksi = await transaksiModel.findById(id)
            .populate('idUser', 'namalengkap alamat telepon')  // Populate idUser to get user details
            .populate('idPaket', 'namapaket harga')  // Populate idPaket to get paket details
            .populate('idLayanan', 'layanan')  // Populate idLayanan to get layanan details
            .populate('idPromo', 'promo keterangan potongan');  // Populate idPromo to get promo details

        if (!transaksi) {
            return res.status(404).json({
                status: 404,
                msg: 'Transaksi not found',
                data: null
            });
        }

        res.status(200).json({
            status: 200,
            msg: 'Berhasil Mengambil Data',
            data: transaksi
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            msg: 'Gagal Mengambil Data',
            data: null,
            error: error.message
        });
    }
};

// Fungsi untuk mengupdate berat, detail, dan status
exports.updateTransaksi = async (req, res) => {
    const { id } = req.params;
    const { berat, detail, status } = req.body;

    try {
        // Create the update object
        let updateData = {
            berat: berat,
            detail: detail,
            status: status
        };

        // Check if status is 10, then set idDriver to null
        if (status === 10) {
            updateData.idDriver = null;
        }
        const updatedTransaksi = await transaksiModel.findByIdAndUpdate(
            id,
            updateData,
            { new: true }
        ).populate('idUser', 'namalengkap alamat telepon')  // Populate idUser to get user details
        .populate('idPaket', 'namapaket harga')  // Populate idPaket to get paket details
        .populate('idLayanan', 'layanan')  // Populate idLayanan to get layanan details
        .populate('idPromo', 'promo keterangan potongan')
        .populate('idDriver', 'namalengkap alamat telepon');  // Populate idPromo to get promo details

        if (!updatedTransaksi) {
            return res.status(404).json({
                status: 404,
                msg: 'Transaksi not found',
                data: null
            });
        }

        res.status(200).json({
            status: 200,
            msg: 'Transaksi updated successfully',
            data: updatedTransaksi
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            msg: 'Failed to update Transaksi',
            data: null,
            error: error.message
        });
    }
};

exports.ambilOrderan = async (req, res) => {
    const { id } = req.params;
    const { idDriver } = req.body;

    try {
        const ambilOrderan = await transaksiModel.findByIdAndUpdate(
            id,
            {
                idDriver: idDriver
            },
            { new: true }
        ).populate('idUser', 'namalengkap alamat telepon')  // Populate idUser to get user details
        .populate('idPaket', 'namapaket harga')  // Populate idPaket to get paket details
        .populate('idLayanan', 'layanan')  // Populate idLayanan to get layanan details
        .populate('idPromo', 'promo keterangan potongan')
        .populate('idDriver', 'namalengkap alamat telepon');  // Populate idPromo to get promo details

        if (!ambilOrderan) {
            return res.status(404).json({
                status: 404,
                msg: 'Orderan Tidak ditemukan',
                data: null
            });
        }
        res.status(200).json({
            status: 200,
            msg: 'Berhasil Mengambil Orderan',
            data: ambilOrderan
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            msg: 'Gagal ambil orderan',
            data: null,
            error: error.message
        });
    }
};


exports.deleteTransaksi = async (req, res) => {
    const { id } = req.params;

    try {
        const deletedTransaksi = await transaksiModel.findByIdAndDelete(id);

        if (!deletedTransaksi) {
            return res.status(404).json({
                status: 404,
                msg: 'Transaksi tidak ditemukan',
                data: null
            });
        }

        res.status(200).json({
            status: 200,
            msg: 'Berhasil menghapus transaksi',
            data: deletedTransaksi
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            msg: 'Gagal menghapus transaksi',
            data: null,
            error: error.message
        });
    }
};

