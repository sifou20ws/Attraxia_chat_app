import 'firebase_options.dart';
import 'package:attraxia_chat_app/core/app_export.dart';


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 796),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'chat_app',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.homeScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
