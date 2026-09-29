import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:al_mobdea/features/live_session/domain/use_cases/get_live_session_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'live_session_state.dart';

class LiveSessionCubit extends Cubit<LiveSessionState> {
  LiveSessionCubit({required this.getLiveSessionUseCase})
    : super(LiveSessionInitial());

  final GetLiveSessionUseCase getLiveSessionUseCase;

  bool _isClosing = false;

  bool get _canEmit => !_isClosing && !isClosed;

  Future<void> getLiveSession({required String gradeId}) async {
    if (!_canEmit) return;

    emit(LiveSessionLoading());

    final normalizedGradeId = gradeId.trim();
    final result = await getLiveSessionUseCase.getLiveSession(
      gradeId: normalizedGradeId,
    );

    if (!_canEmit) return;

    result.fold(
      (failure) {
        if (_canEmit) {
          emit(LiveSessionFailure(errorMessage: failure.message));
        }
      },
      (liveSession) {
        if (!_canEmit) return;

        final hasAvailableSession =
            liveSession.gradeId.trim() == normalizedGradeId &&
            liveSession.meetingUrl.trim().isNotEmpty;

        if (hasAvailableSession) {
          emit(LiveSessionSuccess(liveSessionEntity: liveSession));
        } else {
          emit(LiveSessionEmpty());
        }
      },
    );
  }

  @override
  Future<void> close() async {
    if (_isClosing || isClosed) return;

    _isClosing = true;
    await super.close();
  }
}
