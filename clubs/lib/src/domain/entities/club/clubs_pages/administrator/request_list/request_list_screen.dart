import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:auth/auth.dart';
import 'package:core/src/network/page_query/page_query.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/create_club_page.dart';
import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/row_menu.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/overlay_menu_position.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/alert_dialogs.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/administrator/request_list/request_model.dart';

part 'request_widget.dart';
part 'request_list_empty.dart';

class RequestListScreen extends StatefulWidget  {
  final String approverId;
  final String clubId;
  final ClubApiService apiService;

  const RequestListScreen({
    super.key,
    required this.approverId,
    required this.clubId,
    required this.apiService,
  });

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<RequestUser> requestUsers = [];
  bool isLoading = true;
  int currentPage = 0;
  int size = 20;
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers({bool isRefresh = false}) async {
    if (isLoadingMore || (isRefresh == false && !hasMore)) return;

    setState(() {
      if (isRefresh) {
        isLoading = true;
        currentPage = 0;
        hasMore = true;
        requestUsers.clear();
      }
      isLoadingMore = true;
    });

    try {
      final response = await getApproverWaitingConfirmations(
        approverId: widget.approverId,
        page: currentPage,
        size: size,
        apiService: widget.apiService,
      );
      if (handleGraphQLErrors(context, response, fallbackMessage: 'Ошибка при загрузке списка заявок на вступление')) return;

      final items = response?['data']?['getApproverWaitingConfirmations'] as List<dynamic>?;
      if (items == null || items.isEmpty){
          hasMore = false;
      } else {
        final filtered = items.where((e) =>
                e['answer']?['approvement']?['club']?['id'] == widget.clubId)
            .toList();
          
        if (filtered.isNotEmpty){
          final ids = filtered.map((e) => e['userId'] as String).toList() ?? [];
          final result = await UsersDataSource().getUsers(
            PageQueryModel(page: 0, size: ids.length),
            ids,
          );
          final usersMap = {
            for (var u in result.content) u.id: u.toDomain(),
          };

          final newRequests = filtered.map((e) => RequestUser(
            user: usersMap[e['userId']]!,
            confirmationId: e['id'],
          ));

          setState(() {
            requestUsers.addAll(newRequests);
            currentPage++;
          });
          if (items.length < size) hasMore = false;
        }
      }
    } catch (e) {
      print('Ошибка загрузки пользователей: $e');
      showErrorSnackbar(context, 'Произошла ошибка');
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const ClubPageAppBar(
            title: 'Запросы на вступление',
            ),
          body: RefreshIndicator(
            onRefresh: () => _loadUsers(isRefresh: true),
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoadingMore &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {
                  _loadUsers();
                }
                return false;
              },
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : requestUsers.isEmpty
                    ? const RequestListEmpty()
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.toFigmaSize,
                          vertical: 4.toFigmaSize,
                        ),
                        itemCount: requestUsers.length + (hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          final requestUser = requestUsers[index];
                          return RequestWidget(
                            name: requestUser.user.fullName,
                            avatarPath: requestUser.user.avatar,
                            confirmationId: requestUser.confirmationId,
                            apiService: widget.apiService,
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 4.toFigmaSize,
                          thickness: 1.toFigmaSize,
                          color: context.colors.base_20,
                        ),
                      ),
            )
          ),
        ),
      ),
    );
  }
}
