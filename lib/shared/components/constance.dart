import 'package:shop_app/shared/components/components.dart';
import '../../screens/login/login_screen.dart';
import '../network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token')?.then((value) {
    if (value == true) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String? token = "";
