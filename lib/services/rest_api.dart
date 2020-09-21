import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:baacstaff/models/RegisterModel.dart';

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

  // Read Employee Detail
  Future<RegisterModel> getEmployee(data) async {
      final response = await http.post(
        baseAPIURL+'register', 
        body: jsonEncode(data),
        headers: _setHeaders()
      );
      if(response.statusCode == 200){
        return registerModelFromJson(response.body);
      }else{
        return null;
      }
  }
  

}