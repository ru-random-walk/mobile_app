part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLogoutSuccess extends SettingsState {}

final class SettingsLogoutError extends SettingsState {}
