import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Screens/TripScreen.dart';
import '../Screens/ItenirerayDestailsScreen.dart';

class InharitedSheet extends InheritedWidget {
  const InharitedSheet(
      {Key key,
      @required Widget child,
      this.chosed,
      this.changeviewscreen,
      this.data})
      : assert(child != null),
        super(key: key, child: child);
  final data;
  static InharitedSheet of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InharitedSheet>();
  }

  final bool chosed;
  final Function changeviewscreen;

  @override
  bool updateShouldNotify(InharitedSheet old) {
    return chosed != old.chosed;
  }
}

class TripSheet extends StatefulWidget {
  final data;
  TripSheet({this.data});
  @override
  _TripSheetState createState() => _TripSheetState();
}

class _TripSheetState extends State<TripSheet> with TickerProviderStateMixin {
  bool chosed = false;
  Function changeviewscreen(bool b) {
    setState(() {
      chosed = b;
    });
  }

  double size = 300;
  int index = 0;
  Function changsize(double s) {
    setState(() {
      size = s;
    });
  }

  int stepindex = 0;
  Function changestep(int i) {
    setState(() {
      stepindex = i;
    });
  }

  TabController tab;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tab = TabController(
      vsync: this,
      length: 2,
    );
    tab.addListener(() {
      var size = MYINH.of(context).size;
      if (tab.index == 1) {
        index = 1;
        MYINH.of(context).changeheight(size.height * 0.01);
        changsize(450);
      } else if (tab.index == 0) {
        index = 0;
        MYINH.of(context).changeheight(size.height * 0.2);
        changsize(300);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tab.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InharitedSheet(
      data: widget.data,
      chosed: chosed,
      changeviewscreen: changeviewscreen,
      child: AnimatedSize(
        vsync: this,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
        child: Container(
          height: size,
          child: DefaultTabController(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white.withOpacity(0),
                titleSpacing: 0,
                toolbarHeight: 50,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                    physics: NeverScrollableScrollPhysics(),
                    isScrollable: false,
                    controller: tab,
                    indicatorColor: Colors.black45,
                    tabs: [
                      Tab(
                        child: TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              index == 0
                                  ? Icons.circle
                                  : Icons.panorama_fish_eye,
                              color: index == 0 ? Colors.black : Colors.black45,
                              size: 10,
                            ),
                            label: Text(
                              'ITINERARY',
                              style: TextStyle(
                                  color: index == 0
                                      ? Colors.black
                                      : Colors.black45),
                            )),
                        //     icon: Icon(
                        //   Icons.add,
                        //   color: Colors.black45,
                        // ),
                      ),
                      Tab(
                        child: TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              index == 1
                                  ? Icons.circle
                                  : Icons.panorama_fish_eye,
                              color: index == 1 ? Colors.black : Colors.black45,
                              size: 10,
                            ),
                            label: Text(
                              'REVIEW',
                              style: TextStyle(
                                  color: index == 1
                                      ? Colors.black
                                      : Colors.black45),
                            )),
                        //     icon: Icon(
                        //   Icons.add,
                        //   color: Colors.black45,
                        // ),
                      ),
                    ]),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tab,
                children: [
                  SingleChildScrollView(
                    child: ITINERARY(
                      changestep: changestep,
                      index: stepindex,
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, size) => SingleChildScrollView(
                      child: Review(
                        size: size,
                      ),
                    ),
                  )
                ],
              ),
            ),
            length: 2,
          ),
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  final BoxConstraints size;
  const Review({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Visibility(
        visible: !InharitedSheet.of(context).chosed,
        child: Column(children: [
          ...InharitedSheet.of(context)
              .data['reviews']
              .map((e) => ReviewCard(
                    data: e,
                  ))
              .toList()
        ]),
      ),
      Visibility(
        visible: InharitedSheet.of(context).chosed,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/46/30/97/4630973e2bb5d49d858bad4f657b2dcf.jpg'))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'ASSAM FAISSAL',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '15 july, 2019',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.star, color: Colors.yellow.shade600),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow.shade600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  'IT WAS AN AMAZING TRIP!',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Text(
                  '@aventurenthusiasts voyages voyageursdumonde travel globe trotteur globe trotter aventure aventurier backpackers découvrir le monde paysage du monde nature explorer backpack sac à dos @aventurenthusiasts voyages voyageursdumonde travel globe trotteur globe trotter aventure aventurier backpackers découvrir le monde paysage du monde nature explorer backpack sac à dos',
                  softWrap: true,
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: () {
                      InharitedSheet.of(context).changeviewscreen(false);
                    },
                    color: Colors.black87,
                    child: Text(
                      'BACK TO THE LIST',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }
}

class ITINERARY extends StatelessWidget {
  final index;
  final Function changestep;
  const ITINERARY({Key key, this.changestep, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stepper(
        onStepTapped: (i) {
          changestep(i);
        },
        currentStep: index,
        physics: ClampingScrollPhysics(),
        controlsBuilder: (BuildContext context,
                {VoidCallback onStepCancel, VoidCallback onStepContinue}) =>
            Container(
              height: 0,
              color: Colors.greenAccent,
            ),
        steps: [
          ...InharitedSheet.of(context)
              .data['trip']['itineraries']
              .map((e) => step(context, e))
              .toList()
        ]);
  }

  Step step(BuildContext context, data) {
    return Step(
        state: StepState.indexed,
        title: Text(
          data['title'],
          style: TextStyle(color: Colors.black),
        ),
        //  state: StepState.disabled,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(data['description']),
            TextButtonTheme(
              data: TextButtonThemeData(
                  style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)))),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ItineraryDetailsScreen.route);
                    },
                    icon: Icon(
                      Icons.add_circle_outlined,
                      color: Colors.black87,
                    ),
                    label: Text(
                      'View more informations',
                      style: TextStyle(color: Colors.black45, fontSize: 10),
                    )),
              ),
            ),
          ],
        ));
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        InharitedSheet.of(context).changeviewscreen(true);
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: Container(
          height: 100,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        blurRadius: 3,
                        offset: Offset(0.5, 0.5), // changes position of shadow
                      )
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data['imageUrl'])),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data['createdAt'],
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.black45,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow.shade600),
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade600,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade600,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade600,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.yellow.shade600,
                      ),
                    ],
                  ),
                  Text(
                    data['text'],
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
