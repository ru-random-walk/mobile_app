sealed class DialogType {}

class Recieved extends DialogType {
  final int amount;

  Recieved(this.amount);
}

class Sended extends DialogType {}

class Readed extends DialogType {}
