String baseUrl = 'http://192.168.18.41:5001';
// String baseUrl = 'http://172.16.0.148:5001';

//Login dan Register
String urlLogin = '$baseUrl/user/login';
String urlRegister = '$baseUrl/user/register';
String urlUser = '$baseUrl/user/';
String urlEditUser = '$baseUrl/user/edit/';
String urlGetByIdUser = '$baseUrl/user/getbyid/';

//Paket Laundry
String urlGetAllPaket = '$baseUrl/paket/getallpaket';
String urlGetbyIdPaket = '$baseUrl/paket/getbyid/:id';
// String urlCreatePaket = '$baseUrl/paket/create';
// String urlEditPaket = '$baseUrl/paket/edit/:id';
// String urlHapusPaket = '$baseUrl/paket/hapus';

//Layanan Laundry
String urlGetAllLayanan = '$baseUrl/layanan/getalllayanan';
String urlGetbyIdLayanan = '$baseUrl/layanan/getbyid/:id';
// String urlCreateLayanan = '$baseUrl/layanan/create';
// String urlEditLayanan = '$baseUrl/layanan/edit';
// String urlHapusLayanan = '$baseUrl/layanan/hapus';
