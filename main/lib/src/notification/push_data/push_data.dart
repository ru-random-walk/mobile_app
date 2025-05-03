/// Ключ для id комментария
const _commentIdKey = 'comment_id';

/// Ключ для id пакета (типа данных, касательно которых нам пришло уведомление)
///
/// Подробнее см. [PushDataType]
///
const _typeKey = 'packet_type';

/// Модель данных приходящих в уведомлении от сервера
///
class PushData {
  /// Тип данных пуша
  final PushDataType type;

  /// Идентификатор объекта
  final int id;

  /// Идентификатор комментария
  final int? commentId;

  PushData({
    required this.type,
    required this.id,
    this.commentId,
  });

  /// Метод для обработки поля мапы, приходящей с сервера
  static int? _parseIdFromMapValue(dynamic value) {
    final idString = value as String?;
    final id = int.tryParse(idString ?? '');
    return id;
  }

  factory PushData.fromMap(Map<String, dynamic> data) {
    try {
      final typeId = _parseIdFromMapValue(data[_typeKey]);
      final type = PushDataType.fromId(typeId ?? 0);
      final id = _parseIdFromMapValue(data[type.idKey]);
      final commentId = _parseIdFromMapValue(data[_commentIdKey]);
      return PushData(
        type: type,
        id: id ?? 0,
        commentId: commentId,
      );
    } catch (e) {
      return PushData(
        type: PushDataType.unknown,
        id: 0,
      );
    }
  }
}

enum PushDataType {
  meeting('0'),
  unknown('1');

  final String idKey;

  const PushDataType(this.idKey);

  static PushDataType fromId(int id) {
    switch (id) {
      case 1:
        return PushDataType.meeting;
      default:
        return PushDataType.unknown;
    }
  }
}
