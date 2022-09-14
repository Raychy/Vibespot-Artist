import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

class ServicesHome extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'services-home';

  @override
  Widget get page => this;

  @override
  Widget build(BuildContext context) {
    Widget services() => Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ListView(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                Text(
                  "Vibespot Music World",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.orange.shade700,
                  ),
                ),
                SizedBox(height: 17.0),
                Text(
                  "We offer Digital Stores Promotions.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.orange.shade700,
                  ),
                ),
                SizedBox(height: 30.0),

                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'iTunes and 13 other international streaming platforms.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Spotify Promotions and other Digital stores Promotion.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),

                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Music Video Animation.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),

                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Lyrics Video.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Twitter Trend.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Radio and TV Promo.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Sponsored Ads (IG, FB, YouTube).',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Callertunes.',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: MyBullet(),
                  title: Text(
                    'Youtube, YouTube Promotions (Views and Subscribers).',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                // SizedBox(20),
                Text("Contact: 08060857859",
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                Text(
                  "Email: ifedee4sure@gmail.com",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ],
            ),
          ),
        );

    return ScaffoldCommon(
      appTitle: 'Services',
      bodyData: services(),
      showDrawer: false,
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: Colors.orange.shade700,
        shape: BoxShape.circle,
      ),
    );
  }
}
