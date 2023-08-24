import 'package:botbridge_green/View/ExistedPatientView.dart';
import 'package:botbridge_green/View/SplashView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'View/SearchReferralView.dart';
import 'ViewModel/AppointmentListVM.dart';
import 'ViewModel/BookedServiceVM.dart';
import 'ViewModel/CollectedSamplesVM.dart';
import 'ViewModel/ExistPatientVM.dart';
import 'ViewModel/HistoryVM.dart';
import 'ViewModel/NewRequestVM.dart';
import 'ViewModel/PatientDetailsVM.dart';
import 'ViewModel/ReferalDataVM.dart';
import 'ViewModel/SampleWiseServiceVM.dart';
import 'ViewModel/ServiceDetailsVM.dart';
import 'ViewModel/SignInVM.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  print(FlutterError.onError);
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<SignInVM>(create: (_) => SignInVM()),
            ChangeNotifierProvider<AppointmentListVM>(create: (_) => AppointmentListVM()),
            ChangeNotifierProvider<NewRequestVM>(create: (_) => NewRequestVM()),
            ChangeNotifierProvider<CollectedSampleVM>(create: (_) => CollectedSampleVM()),
            ChangeNotifierProvider<HistoryVM>(create: (_) => HistoryVM()),
            ChangeNotifierProvider<PatientDetailsVM>(create: (_) => PatientDetailsVM()),
            ChangeNotifierProvider<ReferalDataVM>(create: (_) => ReferalDataVM()),
            ChangeNotifierProvider<ServiceDetailsVM>(create: (_) => ServiceDetailsVM()),
            ChangeNotifierProvider<BookedServiceVM>(create: (_) => BookedServiceVM()),
            ChangeNotifierProvider<SampleWiseServiceDataVM>(create: (_) => SampleWiseServiceDataVM()),
            ChangeNotifierProvider<ExistingPatientVM>(create: (_) => ExistingPatientVM()),
          ],
          child: const MyApp()
      ));
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bot Bridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SourceSans',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        // When navigating to the "homeScreen" route, build the HomeScreen widget.
        'ExistedPatient': (context) => const ExistedPatientView(),
        'SearchClientReferral': (context) =>  const SearchReferralView(type: '', searchType: 'CLI',),
        'SearchDoctorReferral': (context) =>  const SearchReferralView(type: 'DOCTOR', searchType: 'DR',),

        // When navigating to the "secondScreen" route, build the SecondScreen widget.
      },
      home: const SplashView(),
    );
  }
}
