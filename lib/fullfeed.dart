import 'package:flutter/material.dart';
import 'global.dart' as g;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
class FullFeed extends StatefulWidget {
  FullFeed({Key key, this.data}) : super(key: key);

  final List<String> data;

  @override
  _FullFeedState createState() => _FullFeedState(data: data);
}

class _FullFeedState extends State<FullFeed> {
  final List<String> data;
  _FullFeedState({this.data});
  bool _alertopen = false, tick = false;
  String url = g.preurl + "gProofs/";
  List dat=[];
  List profile_img=['https://cdn.business2community.com/wp-content/uploads/2014/04/profile-picture-300x300.jpg','https://www.attractivepartners.co.uk/wp-content/uploads/2017/06/profile.jpg','https://organicthemes.com/demo/profile/files/2018/05/profile-pic.jpg','https://www.irreverentgent.com/wp-content/uploads/2018/03/Awesome-Profile-Pictures-for-Guys-look-away2.jpg','https://view.factsmgt.com/ch-me/staff186_2.jpg'];

  Future<String> getproof() async {
    final response = await http.post(url, body: {"grievance_id": data[0]});

    setState(() {
      dat = json.decode(response.body);
      print(dat);
    });
    return "Success!";
  }

  @override
  void initState() {
    setState(() {
      _alertopen = false;
      tick = false;
      g.alert = 0;
      g.loc_alert = 0;
      g.vote_alert = 0;
    });
    getproof();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: 
      new Stack(
        children: [
          AbsorbPointer(
            absorbing: _alertopen,
            child: new Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey[700],
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      backgroundImage: NetworkImage(profile_img[int.parse(data[0])%5]),
                                    ),
                                    new Text(
                                      "  "+data[5],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.017,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )),
                            new Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Icon(Icons.location_on,
                                      color: Colors.green[700],
                                      size: MediaQuery.of(context).size.width *
                                          0.024),
                                  new Text(
                                    data[6] + " , " + data[7],
                                    style: TextStyle(
                                        color: Colors.green[500],
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.017,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                new Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: (data[10]=='posted')?Colors.greenAccent[700]:Colors.orangeAccent[700],
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(20))),
                                ),
                                new Container(
                                  margin: EdgeInsets.fromLTRB(10,0 , 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text("status:  "),
                                ),
                                new Container(
                                  margin: EdgeInsets.fromLTRB(0,0 , 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text((data[10]=='posted')?'Posted':'Resolved', style:TextStyle(color: (data[10]=='posted')?Colors.greenAccent[700]:Colors.orangeAccent[700])),
                                ),
                              ],
                            ),
                            new Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: new RichText(
                                text: TextSpan(
                                  text: data[1],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            new Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    data[2],
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                              child: new RichText(
                                text: TextSpan(
                                  text: "Proofs",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            if(dat.isNotEmpty)Container(
                              height: 200,
                              width: double.infinity,
                              child:new Swiper(
                                itemBuilder: (BuildContext context,int index){
                                  return new Image.network(dat[index]["proofs"],fit: BoxFit.fill,filterQuality: FilterQuality.low,);
                                },
                                itemCount: dat.length,
                                pagination: new SwiperPagination(),
                                control: new SwiperControl(),
                              ),
                            ),
                            /*new Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: dat == null ? 0 : dat.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        new Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          decoration: new BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  dat[index]["proofs"]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                                  }),
                            ),*/
                          ],
                        ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new InkWell(
                        child: Column(
                          children: [
                            new Icon(
                              Icons.thumb_up_outlined,
                              color: Colors.blue[700],
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),
                            new Text(
                              data[3],
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 12),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            g.alert = 1;
                            g.loc_alert = 0;
                            g.vote_alert = 0;
                            _alertopen = true;
                          });
                        },
                      ),
                      new InkWell(
                        child: Column(
                          children: [
                            new Icon(
                              Icons.thumb_down_outlined,
                              color: Colors.blue,
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),
                            new Text(
                              data[4],
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 12),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            g.alert = 1;
                            g.loc_alert = 0;
                            g.vote_alert = 1;
                            _alertopen = true;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}