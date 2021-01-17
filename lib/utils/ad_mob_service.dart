class AdModService {
  final List<String> bannerAdIds = [
    'ca-app-pub-1774878275661991/7408321775',
    'ca-app-pub-1774878275661991/7936781296'
  ];

  String getAdMobAppId() {
    return 'ca-app-pub-1774878275661991~7544053143';
  }

  String getBannerAdId(int i) {
    return bannerAdIds[i];
  }
}
