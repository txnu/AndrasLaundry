String baseUrl = 'http://10.0.2.2:5001';
// String baseUrl = 'http://172.16.0.148:5001';

//Login dan Register
String urlLogin = '$baseUrl/user/login';
String urlRegister = '$baseUrl/user/register';
String urlUser = '$baseUrl/user/';
String urlEditUser = '$baseUrl/user/edit/';
String urlGetByIdUser = '$baseUrl/user/getbyid/';

// Transaksi
String urlCreateTransaksi = '$baseUrl/transaksi/create';
String urlGetbyIdTransaksi = '$baseUrl/transaksi/getTransaksiById/';

//Promo
String urlGetAllPromo = '$baseUrl/promo/getAllPromos';

//Paket Laundry
String urlGetAllPaket = '$baseUrl/paket/getallpaket';
String urlGetbyIdPaket = '$baseUrl/paket/getbyid/:id';

//Layanan Laundry
String urlGetAllLayanan = '$baseUrl/layanan/getalllayanan';
String urlGetbyIdLayanan = '$baseUrl/layanan/getbyid/:id';
