import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/modules/_common/widget/rating_widget.dart';
import '../../app/ui/appTheme.dart';
import '../../models/hotelListData.dart';
import '../../modules/hotelDetailes/roomBookingScreen.dart';

class UpcomingListView extends StatefulWidget {
  final AnimationController? animationController;

  const UpcomingListView({Key? key, this.animationController}) : super(key: key);
  @override
  _UpcomingListViewState createState() => _UpcomingListViewState();
}

class _UpcomingListViewState extends State<UpcomingListView> {
  var hotelList = HotelListData.hotelList;

  @override
  void initState() {
    widget.animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: hotelList.length,
        padding: EdgeInsets.only(top: 8,bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var count = hotelList.length > 10 ? 10 : hotelList.length;
          var animation = Tween(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: widget.animationController!, curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
          widget.animationController!.forward();
          return HotelListView(
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomBookingScreen(
                    hotelName: hotelList[index].titleTxt,
                  ),
                ),
              );
            },
            hotelData: hotelList[index],
            animation: animation,
            animationController: widget.animationController,
            isShowDate: true,
          );
        },
      ),
    );
  }
}

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation? animation;

  const HotelListView({Key? key, this.hotelData, this.animationController, this.animation, this.callback, this.isShowDate: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
              child: Column(
                children: <Widget>[
                  isShowDate
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(hotelData!.dateTxt + ', ' + hotelData!.roomSizeTxt),
                        )
                      : SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.getTheme().dividerColor,
                          offset: Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.asset(
                                  hotelData!.imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: AppTheme.getTheme().backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                hotelData!.titleTxt,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    hotelData!.subTxt,
                                                    style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.mapMarkerAlt,
                                                    size: 12,
                                                    color: AppTheme.getTheme().primaryColor,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${hotelData!.dist.toStringAsFixed(1)} km to city",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Row(
                                                  children: <Widget>[
                                                    RatingBarWidget(
                                                      rating: hotelData!.rating,
                                                      size: 20,
                                                      activeColor: AppTheme.getTheme().primaryColor,
                                                    ),
                                                    Text(
                                                      " ${hotelData!.reviews} Reviews",
                                                      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "\$${hotelData!.perNight}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            "/per night",
                                            style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: 0,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                onTap: () {
                                  try {
                                    callback!();
                                  } catch (e) {}
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(color: AppTheme.getTheme().backgroundColor, shape: BoxShape.circle),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: AppTheme.getTheme().primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
