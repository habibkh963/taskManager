part of 'show_hide_pass_word_cubit.dart';

@immutable
sealed class ShowHidePassWordState {}

final class ShowPassWord extends ShowHidePassWordState {}

final class HidePassWord extends ShowHidePassWordState {}
