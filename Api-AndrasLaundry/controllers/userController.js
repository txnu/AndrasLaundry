const userModel = require('../models/user')
const bcrypt = require('bcrypt')

exports.register = (data) =>
    new Promise((resolve, reject) => {
        userModel.findOne({
            username: data.username
        }).then(user => {
            if (user) {
                reject({
                    sukses: false,
                    msg: 'Username Telah Terdaftar'
                })
            } else {
                bcrypt.hash(data.password, 10, (err, hash) => {
                    data.password = hash
                    userModel.create(data)
                    .then(() => resolve({
                        sukses: true,
                        msg: 'Berhasil Registrasi'
                    })).catch(() => reject({
                        sukses: false,
                        msg: 'Gagal Registrasi'
                    }))
                })
            }
        })
    })

exports.login = (data) =>
    new Promise((resolve, reject) => {
        userModel.findOne({
            username: data.username
        }).then(user => {
            if (user) {
                if (bcrypt.compareSync(data.password, user.password)) {
                    resolve({
                        sukses: true,
                        msg: 'Berhasil Login',
                        data: user
                    })
                } else {
                    reject({
                        sukses: false,
                        msg: 'Password Anda Salah'
                    })
                }
            } else {
                reject({
                    sukses: false,
                    msg: 'Username Tidak Terdaftar'
                })
            }
        })
    })

exports.edit = (id, data) =>
    new Promise(async (resolve, reject) => {
      try {
        // Cek jika password diubah
        if (data.password) {
          // Encrypt password
          data.password = await bcrypt.hash(data.password, 10);
        } else {
          // Jika password tidak diubah, maka gunakan password lama
          data.password = (await userModel.findOne({
            _id: id
          }))?.password;
        }
  
        userModel.updateOne({
          _id: id
        }, data).then(() => resolve({
          sukses: true,
          msg: 'Berhasil Edit Data'
        })).catch(() => reject({
          sukses: false,
          msg: 'Gagal Edit Data'
        }));
      } catch (err) {
        reject({
          sukses: false,
          msg: err.message
        });
      }
    });


exports.getById = (id) =>
  new Promise((resolve, reject) => {
    userModel.findOne({
      _id: id
    })
      .then(res => {
        resolve({
          sukses: true,
          msg: 'Berhasil Mengambil Data',
          data: res
        })
      }).catch(() => reject({
        sukses: false,
        msg: 'Gagal Mengmabil Data',
        data: {}
      }))
  })