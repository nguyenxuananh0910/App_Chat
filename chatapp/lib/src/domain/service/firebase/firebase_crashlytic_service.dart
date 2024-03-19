import 'dart:async';

abstract class FirebaseCrashlyticsService {
  // static final String tag = {
  //   AppCore.instance.appName,
  //   "FirebaseCrashlyticsService",
  // }.join("_");

  // static FirebaseCrashlyticsService findInstance() =>
  //     Get.find<FirebaseCrashlyticsService>(
  //       tag: FirebaseCrashlyticsService.tag,
  //     );

  Future<void> disableCollectionEnabledOnDebugMode();

  Future<void> recordError(
    Object exception,
    StackTrace? stackTrace, {
    bool fatal = true,
  });

  FutureOr<dynamic> callBackWrapper(
    FutureOr<dynamic> function,
  );
}
