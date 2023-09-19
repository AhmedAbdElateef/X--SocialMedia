import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//-----------------------------------------------------------
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/functions/hive_init.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/modules/settings/view_models/settings_notifier.dart';
//-------------------------------------------------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHiveDb();

  runApp(const ProviderScope(child: SocialX()));
}

class SocialX extends ConsumerWidget {
  const SocialX({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watcher = ref.watch(settingsProvider);
    return MaterialApp(
      theme: watcher.appTheme,
      locale: watcher.appLocale,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      navigatorKey: Sailor.navigatorKey,
      initialRoute: AppRoutes().initialRoute,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => context.localizations.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
