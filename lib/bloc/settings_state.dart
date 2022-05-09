part of 'settings_cubit.dart';

class SettingsInitial extends Equatable {
  final bool appNotifications;
  final bool emailNotifications;

  SettingsInitial ({
    required this.appNotifications,
    required this.emailNotifications,
  });

  SettingsInitial copyWith(
   bool? appNotifications, bool? emailNotifications,
) {
    return SettingsInitial(
        appNotifications: appNotifications ?? this.appNotifications,
        emailNotifications: emailNotifications ?? this.emailNotifications);
  }

  @override
  List<Object> get props => [appNotifications,emailNotifications];
}
