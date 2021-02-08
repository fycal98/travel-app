import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const route = 'ProfileScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'MY ACCOUNT',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ready to travel the world as a pro ? of course you are!\n'
                      'Our trip styles cater to pretty much to every one\n'
                      'So all you have to do is choose the style best sweets you',
                      style: TextStyle(color: Colors.black45, fontSize: 8),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                    ),
                    Text(
                      'Faissal',
                      style: TextStyle(color: Colors.black87),
                    ),
                    Text(
                      '@fycal98',
                      style: TextStyle(color: Colors.grey, fontSize: 9),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                UpComingTrip(
                    title: ' YOUR UP COMING TRIP',
                    widget: ListTile(
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent.shade700,
                        size: 30,
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '20 DAYS / COUNTRIES',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'STAR CITY, ROME',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'END CITY, LONDON',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      title: Text(
                        'SCENIC SUMMER',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/greece.jpg'),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                PreviousTrip(
                  title: 'YOUR PREVIOUS TRIPS',
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(Icons.dehaze), onPressed: () {}))
        ]),
      ),
    );
  }
}

class UpComingTrip extends StatelessWidget {
  final String title;
  final Widget widget;
  const UpComingTrip({Key key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: widget,
          ),
        )
      ],
    );
  }
}

class PreviousTrip extends StatelessWidget {
  final String title;
  final Widget widget;
  const PreviousTrip({Key key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.white.withOpacity(0.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListTile(
              trailing: Icon(
                Icons.check_circle,
                color: Colors.grey,
                size: 30,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '20 DAYS / COUNTRIES',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'STAR CITY, ROME',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'END CITY, LONDON',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              title: Text(
                'SCENIC SUMMER',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/sailing.jpg'),
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white.withOpacity(0.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListTile(
              trailing: Icon(
                Icons.check_circle,
                color: Colors.grey,
                size: 30,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '20 DAYS / COUNTRIES',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'STAR CITY, ROME',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'END CITY, LONDON',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              title: Text(
                'SCENIC SUMMER',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/camping.jpg'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
