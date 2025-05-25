part of 'widget.dart';

class _SuffixButton extends StatefulWidget {
  final VoidCallback? onSend;
  final VoidCallback? onLogoTap;
  final TextEditingController controller;

  const _SuffixButton({
    this.onSend,
    this.onLogoTap,
    required this.controller,
  });

  @override
  State<_SuffixButton> createState() => _SuffixButtonState();
}

class _SuffixButtonState extends State<_SuffixButton> {
  late bool isSend;

  @override
  void initState() {
    super.initState();
    initListener();
    isSend = widget.controller.text.isNotEmpty;
  }

  void buttonSwitcherListener() {
    final newIsSend = widget.controller.text.isNotEmpty;
    if (isSend == newIsSend) return;
    setState(() {
      isSend = newIsSend;
    });
  }

  void initListener() {
    widget.controller.addListener(buttonSwitcherListener);
  }

  @override
  void didUpdateWidget(_SuffixButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(buttonSwitcherListener);
      widget.controller.addListener(buttonSwitcherListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isSend
        ? _SendButton(onPressed: widget.onSend)
        : _LogoButton(onPressed: widget.onLogoTap);
  }

  @override
  void dispose() {
    widget.controller.removeListener(buttonSwitcherListener);
    super.dispose();
  }
}
