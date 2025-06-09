part of '../not_member_page.dart';

class JoinRequirements extends StatefulWidget {
  final List<Map<String, dynamic>> approvements;
  final String clubId;
  final String userId;
  final int membersCount;
  final ClubApiService clubApiService;

  const JoinRequirements({
    super.key,
    required this.approvements,
    required this.clubId,
    required this.userId,
    required this.membersCount,
    required this.clubApiService,
  });

   @override
  State<JoinRequirements> createState() => _JoinRequirementsState();
}

class _JoinRequirementsState extends State<JoinRequirements> {
  Map<String, String> answerStatusByApprovementId = {};
  Map<String, Map<int, List<int>>> savedAnswersByApprovementId = {};
  String answerId = '';

  @override
  void initState() {
    super.initState();
    fetchUserAnswers();
  }

  Future<void> fetchUserAnswers() async {
    try{
      final result = await getUserAnswers(
        userId: widget.userId,
        page: 0,
        size: 20,
        apiService: widget.clubApiService,
      );

      if (!mounted) return;
      if (handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при загрузке условий вступления в группу')) return;

      final Map<String, String> answers = {};
      final Map<String, Map<int, List<int>>> answersData = {};

      for (final answer in result?['data']?['getUserAnswers'] ?? []) {
        final approvement = answer['approvement'];
        final club = approvement?['club'];
        if (club?['id'] == widget.clubId) {
          answerId = answer['id'];
          final approvementId = approvement['id'];
          final status = answer['status'];
          answers[approvementId] = status;
          
          final data = answer['data'];
          if (data != null && data['questionAnswers'] != null) {
            final questionAnswers = data['questionAnswers'] as List<dynamic>;
            final Map<int, List<int>> questionAnswerMap = {};

            for (int i = 0; i < questionAnswers.length; i++) {
              final optionNumbers = questionAnswers[i]['optionNumbers'] as List<dynamic>? ?? [];
              questionAnswerMap[i] = optionNumbers.map((e) => e as int).toList();
            }

            answersData[approvementId] = questionAnswerMap;
          }
        }
      }

      if (mounted) {
        setState(() {
          answerStatusByApprovementId = answers;
          savedAnswersByApprovementId = answersData;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (context.mounted) {
        showErrorSnackbar(context, 'Произошла ошибка');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.toFigmaSize),
        Text(
          'Тесты для вступления',
          style: context.textTheme.bodyLMedium.copyWith(
            color: context.colors.base_90,
          ),
        ),
        SizedBox(height: 4.toFigmaSize),
        ...widget.approvements.map((approvement) {
          final isTest = approvement['type'] == 'FORM';
          final approvementId = approvement['id'];
          final answerStatus = answerStatusByApprovementId[approvementId];
          final bool hasAnswer = answerStatus != null;
          
          String buttonText;
          if (isTest) {
            buttonText = !hasAnswer ? 'Пройти' : 'Продолжить';
          } else {
            if (hasAnswer) {
              buttonText = 'Отправлено';
            } else {
              buttonText = 'Отправить';
            }
          }
            
          final bool disableButton = (answerStatus == 'SENT' || answerStatus == 'PASSED' || answerStatus == 'FAILED' || answerStatus == 'IN_REVIEW');

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      isTest ? 'Тест' : 'Запрос на вступление',
                      style: context.textTheme.bodyLRegular.copyWith(
                        color: context.colors.base_90,
                      ),
                    ),
                  ),
                  CustomButton(
                    text: buttonText,
                    customWidth: 140.toFigmaSize,
                    customHeight: 44.toFigmaSize,
                    padding: EdgeInsets.all(4.toFigmaSize),
                    customColor: disableButton ? context.colors.base_20 : null,
                    onPressed: disableButton
                      ? () { 
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Вы не можете повторно пройти тест'),
                            ),
                          );
                        }
                      : () async {
                      if (isTest) {
                        final savedAnswers = savedAnswersByApprovementId[approvementId];
                        final result = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) => TestFormScreen(
                              clubId: widget.clubId, 
                              userId: widget.userId, 
                              answerId: answerId,
                              savedAnswers: savedAnswers,
                            ),
                          ),
                        );

                        if (context.mounted && result != null ) {
                          final shouldReplace = await Navigator.of(context).push<bool>(
                            MaterialPageRoute(
                              builder: (_) => TestResultScreen(result: result),
                            ),
                          );
                          if (context.mounted && shouldReplace == true) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => MemberPage(
                                  clubId: widget.clubId,
                                  currentId: widget.userId,
                                  membersCount: widget.membersCount,
                                ),
                              ),
                            );
                          }
                        }
                      } else {
                        try {
                          final response = await createApprovementAnswerMembersConfirm(
                            approvementId: approvement['id'],
                            apiService: widget.clubApiService,
                          );
                          if (context.mounted && handleGraphQLErrors(context, response, fallbackMessage: 'Ошибка при создании запроса')) return;

                          String answerId = response?['data']?['createApprovementAnswerMembersConfirm']?['id'];
                          String? status;
                          final result = await sendAnswers(
                            answerId: answerId,
                            apiService: widget.clubApiService,
                          );
                          if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка отправки запроса')) return;
                        
                          status = result?['data']['setAnswerStatusToSent']?['status'];
                          if (context.mounted && status == 'SENT'){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Запрос отправлен'),
                                backgroundColor: context.colors.main_50,
                              ),
                            );
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print('$e');
                          }
                          if (context.mounted) {
                            showErrorSnackbar(context, 'Произошла ошибка');
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.toFigmaSize),
            ],
          );
        }),
      ],
    );
  }
}
