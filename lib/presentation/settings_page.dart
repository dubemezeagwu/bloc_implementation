import 'package:bloc_implementation/bloc/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<SettingsCubit, SettingsInitial>(
        listener: (context, state){
          final notificationsSnackBar = SnackBar(
            content: Text(
              "App" + state.appNotifications.toString().toUpperCase() +
                ", Email " +
                state.emailNotifications.toString().toUpperCase(),
            ),
            duration: const Duration(milliseconds: 700),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationsSnackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsInitial>(
          builder: (context,state){
            return Container(
              child: Column(
                children: [
                  SwitchListTile(
                      title: const Text("App Notifications"),
                      value: state.appNotifications, 
                      onChanged: (newValue) => context.read<SettingsCubit>().toggleAppNotifications(newValue)
                  ),
                  SwitchListTile(
                      title: const Text("Email Notifications"),
                      value: state.emailNotifications,
                      onChanged: (newValue) => context.read<SettingsCubit>().toggleEmailNotifications(newValue))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
