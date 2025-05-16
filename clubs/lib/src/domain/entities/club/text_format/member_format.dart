String formatMemberCount(int count) {
    final mod10 = count % 10;
    final mod100 = count % 100;

    String suffix;
    if (mod100 >= 11 && mod100 <= 14) {
      suffix = 'участников';
    } else if (mod10 == 1) {
      suffix = 'участник';
    } else if (mod10 >= 2 && mod10 <= 4) {
      suffix = 'участника';
    } else {
      suffix = 'участников';
    }

    return '$count $suffix';
  }