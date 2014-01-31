import 'package:angular/angular.dart';
import 'my_router.dart' show MyRouteInitializer;
import 'my_controller.dart' show MyController;


class MyAppModule extends Module {
  MyAppModule() {
    type(RouteInitializer, implementedBy: MyRouteInitializer);
    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));
    type(MyController);
  }
}

main() {
  ngBootstrap(module: new MyAppModule());
}
