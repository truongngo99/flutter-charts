import 'package:flutter/material.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class MaterialAppChange extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  //final Widget home;
  final Map<String, WidgetBuilder> routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Color? color;
  final Locale? locale;
  final bool debugShowMaterialGrid;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final num width;
  final num height;

  static late BuildContext appContext;
  final bool enableConfigView;

  MaterialAppChange(
      {Key? key,
      this.enableConfigView = false,
      this.navigatorKey,
      //this.home =null,
      this.routes = const <String, WidgetBuilder>{},
      this.initialRoute,
      this.onGenerateRoute,
      this.onGenerateInitialRoutes,
      this.onUnknownRoute,
      this.navigatorObservers = const <NavigatorObserver>[],
      this.builder,
      this.title = '',
      this.onGenerateTitle,
      this.color,
      this.theme,
      this.darkTheme,
      this.themeMode = ThemeMode.system,
      this.locale,
      this.localizationsDelegates,
      this.localeListResolutionCallback,
      this.localeResolutionCallback,
      this.supportedLocales = const <Locale>[Locale('en', 'US')],
      this.debugShowMaterialGrid = false,
      this.showPerformanceOverlay = false,
      this.checkerboardRasterCacheImages = false,
      this.checkerboardOffscreenLayers = false,
      this.showSemanticsDebugger = false,
      this.debugShowCheckedModeBanner = true,
      this.shortcuts,
      this.actions,
      required this.width,
      required this.height})
      : super(key: key) {
    TeqNetwork.enableLoggingView = enableConfigView;
  }

  @override
  Widget build(BuildContext context) {
    int preTapTime = 0;
    int count = 0;
    Widget widget;
    if (enableConfigView) {
      widget = GestureDetector(
        child: _buildCoreApp(),
        onTap: () {
          int now = DateTime.now().millisecondsSinceEpoch;
          if (preTapTime == 0) {
            preTapTime = now;
          }
          int diff = now - preTapTime;
          if (count < 5) {
            if (diff < 200) {
              count++;
            } else {
              count = 1;
            }
            if (count == 5) {
              print('open network logging view');
              // transferToNewScreen(
              //   // appContext,
              //   context,
              //   NetworkLoggingWidget(),
              // );
              count = 0;
            }
          } else {
            count = 0;
          }
          preTapTime = now;
        },
      );
    } else {
      widget = _buildCoreApp();
    }
    return widget;
  }

  MaterialApp _buildCoreApp() {
    return MaterialApp(
      // home: Builder(
      //   builder: (context) {
      //     appContext = context;
      //     ScreenUtil.init(context, width: width, height: height);
      //     return home;
      //   },
      // ),
      navigatorKey: navigatorKey,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers,
      title: title,
      builder: builder,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
    );
  }
}
