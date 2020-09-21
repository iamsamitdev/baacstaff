import 'dart:convert';

import 'package:http/http.dart' as http;

class CallAPI {

  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept': 'application/json'
  };
  
  final String baseAPIURL = 'https://www.itgenius.co.th/sandbox_api/baacstaffapi/public/api/';

  // Register API
  postData(data, apiURL) async {
    var fullURL = baseAPIURL + apiURL;
    return await http.post(
      fullURL,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }
  

}