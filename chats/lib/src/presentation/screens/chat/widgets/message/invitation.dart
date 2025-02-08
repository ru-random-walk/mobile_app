part of '../../page.dart';

class _ChatInvitationMessageWidget extends StatelessWidget {
  final InvitationMessageEntity invitation;

  const _ChatInvitationMessageWidget({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 8.toFigmaSize);
    return _BaseChatMessageWidget(
      maxWidth: 285.toFigmaSize,
      isMy: invitation.isMy,
      timestamp: invitation.timestamp,
      isTimeUnder: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _InvitationMessageHeaderWidget(),
          spacer,
          _InvitationDataRowWidget(
            iconPath: 'packages/chats/assets/icons/calendar.svg',
            title: 'Дата',
            value:
                DateFormat('dd.MM.yyyy').format(invitation.planDateOfMeeting),
          ),
          spacer,
          _InvitationDataRowWidget(
            iconPath: 'packages/chats/assets/icons/time.svg',
            title: 'Время',
            value: invitation.planTimeOfMeeting.format(context),
          ),
          spacer,
          _InvitationDataRowWidget(
            iconPath: 'packages/chats/assets/icons/place.svg',
            title: 'Место',
            value: invitation.place.toString(),
          ),
          spacer,
          _InvitationMessageBottomWidget(
            invitation: invitation,
          ),
        ],
      ),
    );
  }
}

class _InvitationMessageBottomWidget extends StatelessWidget {
  final InvitationMessageEntity invitation;

  const _InvitationMessageBottomWidget({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    return invitation.showControlButtons
        ? const _InvitationActionButtonsWidget()
        : _InvitationChatInfoWidget(
            status: invitation.status,
          );
  }
}

class _InvitationActionButtonsWidget extends StatelessWidget {
  const _InvitationActionButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _InvitationMessageActionButton(
          text: 'Принять',
          color: ButtonColor.green,
        ),
        SizedBox(width: 8.toFigmaSize),
        const _InvitationMessageActionButton(
          text: 'Отказаться',
          color: ButtonColor.grey,
        )
      ],
    );
  }
}

class _InvitationChatInfoWidget extends StatelessWidget {
  final InvitationStatus status;

  const _InvitationChatInfoWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return _getChild(context);
  }

  Widget _getChild(BuildContext context) => switch (status) {
        InvitationStatus.pending => Text(
            'Ожидает ответа',
            style: context.textTheme.bodyMMedium.copyWith(
              color: context.colors.base_50,
            ),
          ),
        InvitationStatus.accepted => Text(
            'Принято',
            style: context.textTheme.bodyMMedium.copyWith(
              color: context.colors.main_70,
            ),
          ),
        InvitationStatus.rejected => Text(
            'Отклонено',
            style: context.textTheme.bodyMMedium.copyWith(
              color: context.colors.base_80,
            ),
          )
      };
}

class _InvitationMessageActionButton extends StatelessWidget {
  final String text;
  final ButtonColor color;
  final VoidCallback? onPressed;

  const _InvitationMessageActionButton({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112.toFigmaSize,
      child: CustomButton(
        padding: EdgeInsets.symmetric(
          vertical: 8.toFigmaSize,
        ),
        text: text,
        onPressed: onPressed,
        type: ButtonType.primary,
        size: ButtonSize.S,
        color: color,
        isMaxWidth: true,
      ),
    );
  }
}

class _InvitationDataRowWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;

  const _InvitationDataRowWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(width: 8.toFigmaSize);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.toFigmaSize,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 16.toFigmaSize,
                  child: SvgPicture.asset(iconPath),
                ),
                spacer,
                Text(
                  '$title:',
                  style: context.textTheme.bodyMRegularBase90,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 128,
            child: Text(
              value,
              style: context.textTheme.bodyMMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _InvitationMessageHeaderWidget extends StatelessWidget {
  const _InvitationMessageHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(width: 8.toFigmaSize);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.toFigmaSize,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: 24.toFigmaSize,
            child: SvgPicture.asset(
              'packages/chats/assets/icons/logo.svg',
              colorFilter: ColorFilter.mode(
                context.colors.main_90,
                BlendMode.srcIn,
              ),
            ),
          ),
          spacer,
          Flexible(
            child: Text(
              'Приглашение на встречу',
              style: context.textTheme.bodyMMedium.copyWith(
                color: context.colors.main_80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
