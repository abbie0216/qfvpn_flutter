import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qfvpn/bloc/login/register_bloc.dart';
import 'package:qfvpn/routes.dart';

import 'bloc/home/home_bloc.dart';
import 'bloc/login/forgot_pw_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/me/me_bloc.dart';
import 'bloc/splash/splash_bloc.dart';
import 'model/api/api_repository.dart';
import 'model/config/config_data.dart';
import 'model/config/config_provider.dart';
import 'page/splash/splash_page.dart';


Future<void> main() async {
  var configProvider = ConfigProvider(
    data: ConfigData(flavor: 'dev', apiBaseUrl: 'qfvpn.com'),
    child: App(),
  );
  runApp(configProvider);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _configData = ConfigProvider.of(context)?.data;

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => ApiRepository(baseUrl: _configData?.apiBaseUrl ?? '')),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => SplashBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => LoginBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => RegisterBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),

              BlocProvider(
                  create: (context) => ForgotPwBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => HomeBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => MeBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
            ],
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.black,
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              initialRoute: (SplashPage).toString(),
              routes: routes,

            )));
  }
}