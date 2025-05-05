enum MeetingStatus {
  /// В поиске
  searching,
  /// Запрошена (данный статус назначается при создании встречи из чата)
  requested,
  /// Найдена
  find,
  /// В процессе
  inProcess,
  /// Завершена
  done,
  /// Отменена
  canceled;
}
