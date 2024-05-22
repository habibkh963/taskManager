import 'errors/failures.dart';

String base_url = 'https://dummyjson.com';

String mapFailuresToStrings(Failures failures) {
  switch (failures.runtimeType) {
    case ServiceFailure:
      return "Service Not available";
    default:
      return "Unkown Problem";
  }
}
