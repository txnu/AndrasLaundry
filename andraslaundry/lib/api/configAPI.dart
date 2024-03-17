String baseUrl = 'http://10.0.0.166:5001';
// String baseUrl = 'http://172.16.0.148:5001';

//Login dan Register
String urlLogin = '$baseUrl/user/login';
String urlRegister = '$baseUrl/user/register';
String urlUser = '$baseUrl/user/';
String urlEditUser = '$baseUrl/user/edit/';
String urlGetByIdUser = '$baseUrl/user/getbyid/';

//Paket Laundry
String urlGetAllPaket = '$baseUrl/paketlaundry/getall';
String urlGetbyIdPaket = '$baseUrl/paketlaundry/getbyid';
String urlCreatePaket = '$baseUrl/paketlaundry/create';
String urlEditPaket = '$baseUrl/paketlaundry/edit/:id';
String urlHapusPaket = '$baseUrl/paketlaundry/hapus';

//Layanan Laundry
String urlGetAllLayanan = '$baseUrl/layanan/getall';
String urlGetbyIdLayanan = '$baseUrl/layanan/getbyid';
String urlCreateLayanan = '$baseUrl/layanan/create';
String urlEditLayanan = '$baseUrl/layanan/edit';
String urlHapusLayanan = '$baseUrl/layanan/hapus';
