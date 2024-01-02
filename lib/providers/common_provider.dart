import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../constants/api.dart';

final authTokenProvider = StateProvider<String?>((ref) => null);
final logErrorProvider = Provider<bool>((ref) => true); // set true in order to log the errors in console

final apiProvider = Provider<API>(
  (ref) => API(
    client: Client(),
    authToken: ref.watch(authTokenProvider),
    logErrors: ref.watch(logErrorProvider),
  ),
);
