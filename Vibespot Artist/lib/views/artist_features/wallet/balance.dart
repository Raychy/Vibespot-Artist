import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/constants/image_assets.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/artist_features/wallet/cubit/wallet_cubit.dart';
import 'package:vsartist/views/common/uidata.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/forms.dart';

class WalletBalance extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'wallet-balance';

  @override
  Widget get page => this;
  @override
  _WalletBalanceState createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  FormsWidget formsWidget = FormsWidget();
  late WalletCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = WalletCubit();
    Future.delayed(Duration(milliseconds: 500), () => _cubit.balance(context));
  }

  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.black,
        pinned: true,
        elevation: 10.0,
        forceElevated: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: UiData.kitGradients)),
          ),
          title: Row(children: <Widget>[
            Image.asset(UiData.logoMedium, width: 40),
            SizedBox(
              width: 10.0,
            ),

            //SizedBox(width: 10.0),
          ]),
        ),
      );

  body() => SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF242424),
                Color(0xFF242424),
                Color(0xFF111010),
                Colors.black
              ])),
              padding: EdgeInsets.all(13),
              child: BlocBuilder<WalletCubit, WalletState>(
                bloc: _cubit,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                          Spacer(),
                          // state.isLoading
                          //     ? CupertinoActivityIndicator()
                          //     : Text('\$ ${state.balance}',
                          //         style: Theme.of(context).textTheme.headline5)
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Image.asset(ImageAssets.LOGO, width: 80),
                          Spacer(),
                          // SizedBox(
                          //   // width: 80,
                          //   child: formsWidget.mediumButton(
                          //       'Withdraw', context, () {},
                          //       disable: true),
                          // )
                          state.isLoading
                              ? CupertinoActivityIndicator()
                              : Text('\$ ${state.balance}',
                                  style: Theme.of(context).textTheme.headline5)
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.PADDING_SMALL),
              child: formsWidget.wideButton('WITHDRAW', context, () {}),
            ),
            SizedBox(height: 50),
            // StreamBuilder<List<BalanceHistory>>(
            //   stream: walletBloc.history,
            //   builder: (context, snapshot) {
            //     return Expanded(
            //       child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: snapshot.hasData ? snapshot.data!.length : 0,
            //         itemBuilder: (context, index) {
            //           double oldBalance =
            //               double.parse(snapshot.data![index].oldBalance!);
            //           double newBalance =
            //               double.parse(snapshot.data![index].newBalance!);
            //           double balance = newBalance - oldBalance;
            //           return ListTile(
            //             title: Text(balance.toString(),
            //                 style: TextStyle(color: Colors.white)),
            //             subtitle: Text(
            //                 'From ${snapshot.data![index].oldBalance} to ${snapshot.data![index].newBalance}',
            //                 style: TextStyle(color: Colors.white)),
            //             trailing: Icon(Icons.keyboard_arrow_right,
            //                 color: snapshot.data![index].type == 'credit'
            //                     ? Colors.green
            //                     : Colors.red),
            //           );
            //         },
            //       ),
            //     );
            //   },
            // )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
      // scaffoldState: scaffoldState,
      appTitle: 'Balance',
      bodyData: body(),
      showDrawer: false,
    );
  }
}
