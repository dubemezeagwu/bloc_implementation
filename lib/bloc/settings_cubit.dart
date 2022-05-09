import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsInitial> {
  SettingsCubit() : super(SettingsInitial(
      emailNotifications: false, 
      appNotifications: false,
  ));
  
  void toggleAppNotifications (bool newValue) => emit(state.copyWith(newValue, null));
  void toggleEmailNotifications (bool newValue) => emit(state.copyWith(null, newValue));
}
