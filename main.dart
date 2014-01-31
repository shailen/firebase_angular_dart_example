import 'package:angular/angular.dart';
import 'my_router.dart' show MyRouteInitializer;
import 'my_controller.dart' show MyController;

// Temporary, please follow https://github.com/angular/angular.dart/issues/476
@MirrorsUsed(
  targets: const ['my_controller', 'my_route_initializer'],
  override: '*')
import 'dart:mirrors';
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
