library my_controller;

import 'dart:html' show window;
import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart';

class Link {
  String text, description, url;
  Link([this.text, this.description, this.url]);
  asMap() => {"text": text, "description": description, "url": url};
}

@NgController(
    selector: '[my-controller]',
    publishAs: 'ctrl'
)
class MyController implements NgDetachAware {
  static const String BASE = 'https://sizzling-fire-9552.firebaseio.com/links';
  Firebase fb = new Firebase(BASE);
  RouteHandle route;
  String linkId;
  List links = [];
  Map<String, String> newLink = new Link().asMap();

  MyController(RouteProvider router) {
    linkId = router.parameters['linkId'];
    route = router.route.newHandle();
    // _loadData();
    fetchData();
  }

  // Seed data.  Call this from the constructor if all the records have been
  // destroyed and you want new ones.
  _loadData() {
    var links = [
      new Link('Dart samples', 'Short bits of Dart code',
          'https://www.dartlang.org/samples/').asMap(),
      new Link('Angular Dart', 'Dart port of AngularJS',
          'https://github.com/angular/angular.dart').asMap(),
      new Link('Dart Up and Running', 'Introductory Dart book',
          'https://www.dartlang.org/docs/dart-up-and-running/').asMap()
    ];

    for (var link in links) {
      var newPushRef  = fb.push();
      newPushRef.set(link);
    }
  }

  fetchData() {
    fb.onChildAdded.listen((e) {
      var data = e.snapshot.val();
      data['_id'] = e.snapshot.name();
      links.add(data);
    });
  }

  get current {
    if (linkId == null) {
      return newLink;
    }
    return links.firstWhere((link) => link['_id'] == linkId);
  }

  detach() {
    route.discard();
  }

  saveOrUpdate() {
    if (linkId == null) {
      _save();
    }  else {
      _update();
    }
  }

  _save() {
    fb.push().set(current).then((_) {
      showList();
    });
  }

  _update() {
    new Firebase(BASE + '/' + current['_id']).set(current).then((_) {
      showList();
    });
  }

  showList() {
    window.location.replace('#/list');
  }

  destroy() {
    new Firebase(BASE + '/' + current['_id']).remove().then((_) {
      showList();
    });
  }
}