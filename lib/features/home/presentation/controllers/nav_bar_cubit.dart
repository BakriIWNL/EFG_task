import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(converterIndex);

  static const int converterIndex = 0;
  static const int historyIndex = 1;

  void setIndex(int index) => emit(index);
}
