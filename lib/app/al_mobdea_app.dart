import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/app/routes/screen_routes/app_routes.dart';
import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/connection/cubit/network_status_cubit.dart';
import 'package:al_mobdea/core/services/device_preview_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlMobdeaApp extends StatelessWidget {
  const AlMobdeaApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkStatusCubit>(
          create: (_) {
            return getIt<NetworkStatusCubit>()..startMonitoring();
          },
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'المبدع',
            debugShowCheckedModeBanner: false,
            locale: DevicePreviewService.locale(context),
            theme: ThemeData(),
            initialRoute: RouteNames.liveSessionScreen,
            onGenerateRoute: AppRoutes.generateRoute,
            builder: _buildApp,
          );
        },
      ),
    );
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    return DevicePreviewService.appBuilder(context, child);
  }
}
