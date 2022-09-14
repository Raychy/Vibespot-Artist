import 'package:vsartist/views/account/account-lander.dart';
import 'package:vsartist/views/account/forgot_password.dart';
import 'package:vsartist/views/account/login.dart';
import 'package:vsartist/views/account/profile_screen.dart';
import 'package:vsartist/views/account/signup.dart';
import 'package:vsartist/views/add_artist/approve_recordlabel.dart';
import 'package:vsartist/views/artist_features/music/music-home.dart';
import 'package:vsartist/views/services/services_page.dart';
import 'package:vsartist/views/artist_features/uploads/singles-upload.dart';
import 'package:vsartist/views/artist_features/wallet/balance.dart';
import 'package:vsartist/views/dashboard.dart';
import 'package:vsartist/views/onboarding/onboarding.dart';
import 'package:vsartist/views/artist_features/wallet/withdraw.dart';
import 'package:vsartist/views/statistics/album/album_screen.dart';
import 'package:vsartist/views/statistics/playlist/playlist_screen.dart';
import 'package:vsartist/views/statistics/playlist/search/search_screen.dart';
import 'package:vsartist/views/statistics/release/release_screen.dart';
import 'package:vsartist/views/statistics/statistics_screen.dart';
import 'package:vsartist/views/statistics/track/track_screen.dart';
import 'package:vsartist/views/upload/album-upload-instruction.dart';
import 'package:vsartist/views/upload/create_album.dart';
import 'package:vsartist/views/upload/create_release.dart';
import 'package:vsartist/views/upload/singles-upload-instruction.dart';

import 'app_route.dart';

class Routes {
  static final all = <AppRoute>[
    AccountLander(),
    AlbumScreen(),
    CreateAlbum(),
    CreateRelease(),
    AlbumUploadInstruction(),
    ApproveRecordLabel(),
    Dashboard(),
    ForgotPassword(),
    Login(),
    MusicHome(),
    Onboarding(),
    ProfileScreen(),
    StatisticsScreen(),
    ServicesHome(),
    SignUp(),
    SinglesUpload(),
    SinglesUploadInstruction(),
    WalletBalance(),
    PlaylistScreen(),
    ReleaseScreen(),
    TrackScreen(),
    Withdraw(),
    SearchScreen()
  ];
}
