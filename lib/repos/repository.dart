import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc_api/models/user_model.dart';



class UserRepository {
  String endpoint = "https://firebasestorage.googleapis.com/v0/b/myapp-ad40e.appspot.com/o/JSON%20URL%2Fdata.json?alt=media&token=31cb55f8-2b54-4dc3-a3f9-1dbfe4a39164";
  Future<List<UserModel>> getUsers()async{
    Response response = await get(Uri.parse(endpoint));
    if(response.statusCode ==200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }

  }
}