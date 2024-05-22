import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_hide_pass_word_state.dart';

class ShowHidePassWordCubit extends Cubit<ShowHidePassWordState> {
  ShowHidePassWordCubit() : super(HidePassWord());
  bool showPass = false;
  showAndhidePass() {
    if (showPass) {
      showPass = false;
      emit(HidePassWord());
    } else {
      showPass = true;
      emit(ShowPassWord());
    }
  }
}
