part of '../page.dart';

class _MeetingInfoMenuWidget extends StatelessWidget {
  final double dY;
  final VoidCallback closeMenu;
  final void Function(AvailableTimeModifyEntity modify) onModify;

  const _MeetingInfoMenuWidget({
    required this.dY,
    required this.closeMenu,
    required this.onModify,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingInfoBloc, MeetingInfoState>(
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          child: CustomSingleChildLayout(
            delegate: _MenuLayoutDelegate(dY),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(
                  0xF2EAEAEA,
                ),
                borderRadius: BorderRadius.circular(6.toFigmaSize),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: state is AvailableTimeInfo,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _ActionMenuRowWidget(
                                text: 'Изменить',
                                imagePath: 'assets/icons/edit.svg',
                                onTap: () async {
                                  closeMenu();
                                  final res = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => Provider.value(
                                        value:
                                            context.read<PersonRepositoryI>(),
                                        child: AvailableTimePage(
                                          pageMode: AvailableTimePageModeUpdate(
                                            (state as AvailableTimeInfo)
                                                .availableTime,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  if (res is AvailableTimeModifyEntity) {
                                    onModify(res);
                                  }
                                },
                              ),
                              SizedBox(
                                width: 200.toFigmaSize,
                                height: 1.toFigmaSize,
                                child: ColoredBox(
                                  color: context.colors.base_10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _ActionMenuRowWidget(
                          text: 'Удалить',
                          imagePath: 'assets/icons/delete.svg',
                          onTap: () {
                            context
                                .read<MeetingInfoBloc>()
                                .add(DeleteMeeting());
                            closeMenu();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuLayoutDelegate extends SingleChildLayoutDelegate {
  final double dY;

  const _MenuLayoutDelegate(this.dY);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
        Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = size.width - 10.toFigmaSize - childSize.width;
    return Offset(dx, dY);
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;
}
