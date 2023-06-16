import 'package:medic_petcare/Config/Network.dart';

class EndPoint {
  static urlLogin({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      endPoint: 'login',
      body: body,
      useToken: false,
    );
  }

  static urlRegister({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      endPoint: 'register',
      body: body,
      useToken: false,
    );
  }

  static urlUser() async {
    return Network().get(
      endPoint: 'user',
    );
  }

  static updateUser({
    required Map<String, dynamic> body,
    required bool isImage,
  }) async {
    return Network().post(
      endPoint: 'user',
      header: {},
      isImage: isImage,
      body: body,
      keyFile: 'avatar',
    );
  }

  static urlProduct() async {
    return Network().get(
      endPoint: 'products',
    );
  }

  static urlHome() async {
    return Network().get(
      endPoint: 'home',
    );
  }
}
