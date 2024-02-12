import 'package:flutter/cupertino.dart';
import 'package:food_app/model/searchData/search_data.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/utils/Utils.dart';

class SearchApiController extends ChangeNotifier{
  ApiProvider _apiProvider = ApiProvider();
  SearchData ? _search;
  var isLoading = false;
  SearchData get search=>_search!;
  List<Data>  _searchData = [];
  List<Data>  get searchData =>_searchData;



  searchHttp(search_location_or_kitchen, customer_latitude, customer_longitude)async{
    isLoading = true;
    notifyListeners();

     _apiProvider.searchHttp(
       search_location_or_kitchen,//customer_latitude,customer_longitude,
          "72.5192373",
          "23.0512878",
    ).then((value){
      if(value!.data!=null){
        _searchData = value.data!.toList();

        isLoading = false;
        notifyListeners();
      }else{
        isLoading = false;
        notifyListeners();
        Utils.showToast('something went wrong');
      }
    });
  }
  clearSearchHttp()async{
    isLoading = true;
    notifyListeners();
    _apiProvider.clearSearchHttp(
    ).then((value){
      if(value!.data!=null){
        Utils.showToast('Recent search cleared');
        isLoading = false;
        notifyListeners();
        _searchData.clear();
        notifyListeners();
        searchData.clear();
        notifyListeners();
      }else{
        isLoading = false;
        notifyListeners();
        Utils.showToast('something went wrong');
      }
    });
  }
}