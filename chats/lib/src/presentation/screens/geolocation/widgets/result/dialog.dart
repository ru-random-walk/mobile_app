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
                child: PickerConfirmButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
