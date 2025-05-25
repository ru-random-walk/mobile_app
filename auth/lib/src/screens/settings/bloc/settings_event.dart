part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingsLogoutEvent extends SettingsEvent {}
