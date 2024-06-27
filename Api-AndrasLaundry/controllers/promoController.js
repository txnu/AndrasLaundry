const promoModel = require('../models/promo')
const multer = require('multer')
const path = require('path')
const fs = require('fs')

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './static')
    },
    filename: function (req, file, cb) {
        cb(null, new Date().toISOString().replace(/:/g, '-') + path.extname(file.originalname))
    }
});

const upload = multer({ storage: storage, limits: { fileSize: 2000000 } });

exports.createPromo = [
    upload.single('image'),
    async (req,res) => {
        try {
            const { promo, keterangan, potongan } = req.body;
            const image = req.file.filename;

            const newPromo = new promoModel({ promo, keterangan, potongan, image});
            await newPromo.save();

            res.status(201).json({ message: 'Promo created successfully' });
        } catch (error) {
            res.status(500).json({ message: 'Internal server error' });
        }
    }
];

// Read all promos
exports.getAllPromos = async (req, res) => {
    try {
        const promos = await promoModel.find();
        res.status(200).json({
            status: 200,
            msg: 'Berhasil Mengambil Data',
            data: promos
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

// Read promo by ID
exports.getPromoById = async (req, res) => {
    try {
        const promo = await promoModel.findById(req.params.id);
        if (!promo) {
            return res.status(404).json({
                status: 404,
                msg: 'Promo tidak ditemukan',
                data: null
            });
        }
        res.status(200).json({
            status: 200,
            msg: 'Berhasil Mengambil Data',
            data: promo
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

// Update promo by ID
exports.updatePromo = async (req, res) => {
    upload.single('image')(req, res, async (err) => {
        if (err instanceof multer.MulterError) {
            return res.status(400).json({ message: 'Multer error', error: err.message });
        } else if (err) {
            return res.status(500).json({ message: 'Unknown error', error: err.message });
        }

        const { id } = req.params;
        const { promo, keterangan } = req.body;
        let image = req.file ? req.file.filename : null; // Ambil nama file jika ada file yang diupload

        try {
            let existingPromo = await promoModel.findById(id);
            if (!existingPromo) {
                return res.status(404).json({
                    status: 404,
                    msg: 'Promo not found',
                    data: null
                });
            }

            // Handle image upload if there's a new image
            if (req.file) {
                const imagePath = path.join(__dirname, '../static', existingPromo.image);
                // Delete existing image if it exists
                if (fs.existsSync(imagePath)) {
                    fs.unlinkSync(imagePath);
                }
                // Update image path in database
                image = req.file.filename;
            } else {
                // If no new image, keep the existing one
                image = existingPromo.image;
            }

            // Update promo data
            existingPromo.promo = promo;
            existingPromo.keterangan = keterangan;
            existingPromo.image = image;

            // Save updated promo data
            const updatedPromo = await existingPromo.save();

            res.status(200).json({
                status: 200,
                msg: 'Promo updated successfully',
                data: updatedPromo
            });
        } catch (error) {
            console.error('Failed to update promo:', error);
            res.status(500).json({
                status: 500,
                msg: 'Failed to update promo',
                data: null,
                error: error.message
            });
        }
    });
};
exports.deletePromo = async (req, res) => {
    try {
        // Cari promo berdasarkan ID
        const deletedPromo = await promoModel.findByIdAndDelete(req.params.id);
        if (!deletedPromo) {
            return res.status(404).json({
                status: 404,
                msg: 'Promo tidak ditemukan',
                data: null
            });
        }

        // Dapatkan path gambar dari promo yang dihapus
        const imagePath = path.join(__dirname, '..', 'static', deletedPromo.image);

        // Hapus file gambar jika ada
        fs.unlink(imagePath, (err) => {
            if (err) {
                return res.status(500).json({
                    status: 500,
                    msg: 'Gagal Menghapus Gambar',
                    data: null,
                    error: err.message
                });
            }
            // Berhasil menghapus promo dan gambar
            res.status(200).json({
                status: 200,
                msg: 'Berhasil Menghapus Data dan Gambar',
                data: deletedPromo
            });
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            msg: 'Gagal Menghapus Data',
            data: null,
            error: error.message
        });
    }
};



