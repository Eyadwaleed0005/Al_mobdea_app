part of 'live_session_cubit.dart';

sealed class LiveSessionState extends Equatable {
  const LiveSessionState();

  @override
  List<Object> get props => const [];
}

final class LiveSessionInitial extends LiveSessionState {}

final class LiveSessionLoading extends LiveSessionState {}

final class LiveSessionEmpty extends LiveSessionState {}

final class LiveSessionSuccess extends LiveSessionState {
  const LiveSessionSuccess({required this.liveSessionEntity});

  final LiveSessionEntity liveSessionEntity;

  @override
  List<Object> get props => [liveSessionEntity];
}

final class LiveSessionFailure extends LiveSessionState {
  const LiveSessionFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
