import 'package:http/http.dart' as http;

class AuthRepository {
  static Future authenticate(String? idProf) async {
    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/dados_prof.php"),
      body: {
        'idprof': idProf,
      },
    );
  }
}
