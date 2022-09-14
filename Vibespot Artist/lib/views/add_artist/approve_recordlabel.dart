// import 'package:condition/condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vsartist/core/router/app_route.dart';
// import 'package:vsartist/views/account/user.dart';
import 'package:vsartist/views/artist_features/artist_global/functions.dart';
import 'package:vsartist/views/artist_features/artist_global/networks.dart';
import 'package:vsartist/views/artist_features/uploads/upload-common.dart';
import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/forms.dart';

class ApproveRecordLabel extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'approve-record-label';

  @override
  Widget get page => this;
  final int? pages;
  final int? pager;
  final String? releaseName;
  final UploadAlbum? uploadAlbum;

  ApproveRecordLabel(
      {this.pages, this.pager, this.releaseName, this.uploadAlbum});
  @override
  _ApproveRecordLabelState createState() => _ApproveRecordLabelState();
}

class _ApproveRecordLabelState extends State<ApproveRecordLabel>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  FormsWidget formsWidget = FormsWidget();
  Functions functions = Functions();
  UploadCommon uploadCommon = UploadCommon();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Music musicUpload = new Music();
  UploadAlbum? uploadAlbum;
  NetworkRequest network = NetworkRequest();
  // List<ArtistModel> artists = [];
  // ArtistModel? artist;
  String? _artistValue;
  bool? isRecordLabelAvailable;
  dynamic recordLabelConfirmModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functions.checkInternet(scaffoldState);
    getRecordLabelDetails();
  }

  void getRecordLabelDetails() async {
    dynamic data = await network.getRecordLabelDetails(context: context);
    if (data["data"] != null && data["status"] != false) {
      setState(() {
        isRecordLabelAvailable = true;
        recordLabelConfirmModel = data["data"];
        print(recordLabelConfirmModel);
      });
    } else {
      setState(() {
        isRecordLabelAvailable = false;
        network.showToast(data['message'], context);
      });
    }
  }

  void _rejectSubmit() async {
    networkBloc.approveRecordLabel({
      "record_label_id": recordLabelConfirmModel["user_id"].toString(),
      "status": "0"
    }, context);
    networkBloc.snacksBar.listen((data) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          duration: Duration(seconds: 50), content: new Text(data)));
    });
  }

  void _approveSubmit() async {
    networkBloc.approveRecordLabel({
      "record_label_id": recordLabelConfirmModel["user_id"].toString(),
      "status": "1"
    }, context);
    networkBloc.snacksBar.listen((data) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          duration: Duration(seconds: 50), content: new Text(data)));
    });
  }

  rejectRecordLabelButton() {
    return StreamBuilder<bool>(
        stream: networkBloc.showProgress,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data!) {
            return new Center(child: CircularProgressIndicator());
          } else {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: formsWidget.rejectMediumButton(
                    'Reject  Record Label', context, _rejectSubmit));
          }
        });
  }

  confirmRecordLabelButton() {
    return StreamBuilder<bool>(
        stream: networkBloc.showProgress,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data!) {
            return new Center(child: CircularProgressIndicator());
          } else {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: formsWidget.mediumButton(
                    'Confirm Record Label', context, _approveSubmit));
          }
        });
  }

  body() => SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // SizedBox(height: 4),
          // Padding(
          //     padding: EdgeInsets.all(15),
          //     child: Container(
          //       child: Column(
          //         children: [
          //           formsWidget.fieldSpace(),
                //     // Conditioned(
                //     //   cases: [
                //     //     Case(
                //     //       isRecordLabelAvailable == true,
                //     //       builder: () => Column(
                //     //         mainAxisAlignment: MainAxisAlignment.center,
                //     //         // crossAxisAlignment: CrossAxisAlignment.center,
                //     //         children: [
                //     //           formsWidget.fieldSpace(),
                //     //           formsWidget.fieldSpace(),
                //     //           formsWidget.fieldSpace(),
                //     //           Text(
                //     //             "Record Label Name:",
                //     //             style: TextStyle(
                //     //                 fontSize: 16.0,
                //     //                 fontWeight: FontWeight.w400,
                //     //                 color: Colors.amber),
                //     //           ),
                //     //           SizedBox(
                //     //             height: 10.0,
                //     //           ),
                //     //           Text(
                //     //             recordLabelConfirmModel['record_label_name'],
                //     //             style: TextStyle(
                //     //                 fontSize: 20.0,
                //     //                 fontWeight: FontWeight.w500,
                //     //                 color: Colors.amber),
                //     //             textAlign: TextAlign.center,
                //     //           ),
                //     //           formsWidget.fieldSpace(),
                //     //           // SizedBox(height: 20),
                //     //           Row(
                //     //             mainAxisAlignment:
                //     //                 MainAxisAlignment.spaceEvenly,
                //     //             children: [
                //     //               confirmRecordLabelButton(),
                //     //               rejectRecordLabelButton(),
                //     //             ],
                //     //           )
                //     //         ],
                //     //       ),
                //     //     ),
                //     //     Case(
                //     //       isRecordLabelAvailable == false,
                //     //       builder: () => Center(
                //     //         child: Text(
                //     //           "No RecordLabel Found",
                //     //           style: TextStyle(
                //     //               fontSize: 18.0,
                //     //               fontWeight: FontWeight.w500,
                //     //               color: Colors.amber),
                //     //         ),
                //     //       ),
                //     //     ),
                //       ],
                //       defaultBuilder: () => Text(
                //         "No RecordLabel Found",
                //         style: TextStyle(
                //             fontSize: 18.0,
                //             fontWeight: FontWeight.w500,
                //             color: Colors.amber),
                //       ),
                //     ),
                //   ],
                // ),
              // ))
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
      // scaffoldState: scaffoldState,
      appTitle: '',
      bodyData: body(),
      showDrawer: false,
    );
  }
}
