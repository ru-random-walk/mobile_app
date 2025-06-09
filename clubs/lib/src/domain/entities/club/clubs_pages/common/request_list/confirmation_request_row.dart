import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/request_list/request_list_screen.dart';

class ConfirmationRequestRow extends StatefulWidget {
  final ClubApiService apiService;
  final String clubId;
  final String approverId;

  const ConfirmationRequestRow({
    super.key,
    required this.apiService,
    required this.clubId,
    required this.approverId,
  });

  @override
  State<ConfirmationRequestRow> createState() => _ConfirmationRequestRowState();
}

class _ConfirmationRequestRowState extends State<ConfirmationRequestRow> {
  int newRequests = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNewRequests();
  }

  Future<void> _loadNewRequests() async {
    try {
      final response = await getApproverWaitingConfirmations(
        approverId: widget.approverId,
        page: 0,
        size: 20,
        apiService: widget.apiService,
      );

      final items = response?['data']?['getApproverWaitingConfirmations'] as List<dynamic>?;

      if (items != null) {
        final filtered = items.where((e) =>
            e['answer']?['approvement']?['club']?['id'] == widget.clubId &&
            e['status'] == 'WAITING');
        setState(() {
          newRequests = filtered.length;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (kDebugMode) {
        print('Ошибка загрузки количества заявок: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestListScreen(
              apiService: widget.apiService,
              clubId: widget.clubId,
              approverId: widget.approverId,
            ),
          ),
        );
        _loadNewRequests();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Запрос на вступление',
                style: context.textTheme.bodyLRegular.copyWith(
                  color: context.colors.base_80,
                ),
              ),
              SizedBox(width: 8.toFigmaSize),
              Icon(
                Icons.arrow_forward_ios,
                size: 24.toFigmaSize,
                color: context.colors.base_50,
              ),
            ],
          ),
          if (!isLoading && newRequests > 0)
            Container(
              width: 24.toFigmaSize,
              height: 24.toFigmaSize,
              decoration: BoxDecoration(
                color: context.colors.main_50,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$newRequests',
                  style: context.textTheme.bodyMMedium.copyWith(
                    color: context.colors.base_0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
