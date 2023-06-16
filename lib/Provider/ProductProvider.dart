import 'package:flutter/widgets.dart';
import 'package:medic_petcare/Config/Enpoint.dart';

class ProductProvider with ChangeNotifier {
  List setProducts = [];
  Map setHome = {};
  List get getProducts => setProducts;
  Map get getHome => setHome;
  bool setIsLoading = true;
  bool get isLoading => setIsLoading;

  Future<Map<String, dynamic>> home() async {
    try {
      setIsLoading = true;
      var response = await EndPoint.urlHome();
      if (response['meta']['code'] == 200) {
        setHome = response['data'];
        setIsLoading = false;
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return {
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> products() async {
    try {
      setIsLoading = true;
      var response = await EndPoint.urlProduct();
      if (response['meta']['code'] == 200) {
        setProducts = response['data']['data'];
        setIsLoading = false;
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return {
        "message": e.toString(),
      };
    }
  }
}
