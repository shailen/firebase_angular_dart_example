library my_router;

import 'package:angular/angular.dart';

class MyRouteInitializer implements RouteInitializer {
  init(Router router, ViewFactory view) {
    router.root
      ..addRoute(
        name: 'list',
        path: '/list',
        defaultRoute: true,
        enter: view('list.html'))
      ..addRoute(
        name: 'new',
        path: '/new',
        enter: view('detail.html'))
      ..addRoute(
          name: 'link',
          path: '/link/:linkId',
          mount: (Route route) => route
          ..addRoute(
              name: 'edit',
              path: '/edit',
              enter: view('detail.html')));
    }
}
