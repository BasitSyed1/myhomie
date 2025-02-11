import 'package:flutter/foundation.dart';

class SearchFilterProvider extends ChangeNotifier{
   bool _isSelected = false;

  bool get isSelected => _isSelected;

 void SearchFilterToggle(){
   _isSelected = !_isSelected;
   notifyListeners();
 }

}