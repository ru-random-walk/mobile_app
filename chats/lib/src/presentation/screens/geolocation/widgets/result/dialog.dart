part of '../../page.dart';

class _ApplyLocationResultDialog extends StatefulWidget {
  @override
  State<_ApplyLocationResultDialog> createState() =>
      _ApplyLocationResultDialogState();
}

class _ApplyLocationResultDialogState
    extends State<_ApplyLocationResultDialog> {
  late Geolocation pickedGeolocation;
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pickedGeolocation =
        ModalRoute.of(context)!.settings.arguments as Geolocation;
    cityController.text = pickedGeolocation.city;
    streetController.text = pickedGeolocation.street;
    buildingController.text = pickedGeolocation.building ?? '';
    _initListeners();
  }

  void _cityListener() {
    pickedGeolocation = pickedGeolocation.copyWith(
      city: cityController.text,
    );
  }

  void _streetListener() {
    pickedGeolocation = pickedGeolocation.copyWith(
      street: streetController.text,
    );
  }

  void _buildingListener() {
    pickedGeolocation = pickedGeolocation.copyWith(
      building: buildingController.text,
    );
  }

  void _initListeners() {
    cityController.addListener(_cityListener);
    streetController.addListener(_streetListener);
    buildingController.addListener(_buildingListener);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      width: 387.toFigmaSize,
      height: 271.toFigmaSize,
      child: Padding(
        padding: EdgeInsets.all(8.toFigmaSize),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DialogPickerHeader(
                title: 'Aдрес',
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PickedAddressRow(
                    title: 'Город',
                    controller: cityController,
                  ),
                  _PickedAddressRow(
                    title: 'Улица',
                    controller: streetController,
                  ),
                  _PickedAddressRow(
                    title: 'Дом',
                    controller: buildingController,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.toFigmaSize,
                ),
                child: PickerConfirmButton(
                  onTap: () {
                    Navigator.pop(context, pickedGeolocation);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cityController.removeListener(_cityListener);
    streetController.removeListener(_streetListener);
    buildingController.removeListener(_buildingListener);
    cityController.dispose();
    streetController.dispose();
    buildingController.dispose();
  }
}
