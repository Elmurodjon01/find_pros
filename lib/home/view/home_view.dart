// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:scroll_indicator/scroll_indicator.dart';

import 'package:find_pros/shared/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<int> adScrollIndex = ValueNotifier(1);

  final urlImages1 = [
    'https://i.imgur.com/Y3UejT0.jpg',
    'https://i.imgur.com/KNFL3qd.jpg',
    'https://i.imgur.com/fxAH9HY.jpg',
    'https://i.imgur.com/9GkgdKx.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return [
              innerBoxScrolled
                  ? const SliverAppBar(
                      expandedHeight: 200.0,
                      backgroundColor: Colors.white,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.symmetric(horizontal: 10),
                        centerTitle: true,
                        title: TextField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(MyColors.primaryColor))),
                              prefixIcon: Icon(Icons.search),
                              hintText: '어떤 서비스가 필요하세요?'),
                        ),
                      ),
                    )
                  : SliverAppBar(
                      expandedHeight: 10.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: PreferredSize(
                        preferredSize: Size.fromHeight(100.0),
                        child: AppBar(
                          backgroundColor: Colors.white,
                          leadingWidth: 110,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: SvgPicture.asset(
                              'assets/logos/logo.svg',
                            ),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_outline,
                                size: 40,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 15, left: 10),
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(MyColors.primaryColor),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Center(
                                child: Text(
                                  '고수 가입',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '어떤 서비스가 필요하세요?',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 91, 91, 91),
                          fontSize: 20,
                        ),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                        ),
                      ),
                    ),
                  ),
                  const Gap(15),
                  ScrollableIconRows(scrollController),
                  ScrollIndicator(
                    scrollController: scrollController,
                    width: 20,
                    height: 3,
                    indicatorWidth: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]),
                    indicatorDecoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Gap(30),
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, reason) =>
                              adScrollIndex.value = index + 1,
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          height: 100.0,
                        ),
                        items: urlImages1.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(i),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 70),
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ValueListenableBuilder(
                              valueListenable: adScrollIndex,
                              builder: (context, value, child) => Text(
                                '$value/${urlImages1.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: fourIcons
                        .map(
                          (iconInfo) => buildIconContainer(
                              iconInfo: iconInfo,
                              margin:
                                  const EdgeInsets.only(left: 13, right: 13)),
                        )
                        .toList(),
                  ),
                  const Gap(20),
                  partTitle(title: '숨고 인기 서비스'),
                  const Gap(12),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: dummyPopularServiceList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int idx) {
                        return popularServices(dummyPopularServiceList[idx]);
                      },
                    ),
                  ),
                  const Gap(35),
                  partTitle(
                      title: '숨은 고수를 발견했어요',
                      trailing: const Icon(Icons.ads_click)),
                  const Gap(10),
                  Column(
                    children: reviews
                        .map((review) =>
                            reviewBox(context: context, review: review))
                        .toList(),
                  ),
                  const Gap(40),
                  partTitle(
                    title: '숨은고수 포트폴리오',
                    trailing: const Text(
                      '전체보기 >',
                      style: TextStyle(
                        color: Color(MyColors.primaryColor),
                      ),
                    ),
                  ),
                  const Gap(15),
                  //portfolio
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: portfolios.length,
                        itemBuilder: (context, int idx) =>
                            portfolioBox(portfolios[idx])),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ),
        ));
  }

  Column portfolioBox(PortfolioModel portfolio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    portfolio.portfolioImg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Positioned(
              bottom: 10, // Position from the bottom
              left: 10, // Position from the left
              child: SizedBox(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      portfolio.title,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      portfolio.subcontent,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  portfolio.profImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(7),
            Text(
              portfolio.username,
            ),
          ],
        )
      ],
    );
  }

  Container reviewBox({
    required BuildContext context,
    required ReviewModel review,
  }) {
    return Container(
      height: 255,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        review.profileImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.username),
                      Text(
                        review.jobTitle,
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Colors.grey,
              ),
            ],
          ),
          const Gap(8),
          Divider(
            color: Colors.grey.withOpacity(0.4),
          ),
          const Gap(5),
          const RatingStars(
            valueLabelTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 10.0,
            ),
            starSize: 15,
            value: 5,
            starColor: Color.fromARGB(255, 246, 190, 105),
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width / 1.7,
                child: Text(
                  review.comment,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
              if (review.reviewImg != null)
                Image.network(
                  review.reviewImg!,
                  height: 70,
                  width: 70,
                )
              else
                const SizedBox(),
            ],
          ),
          Text(
            '${review.commenter}고객님의 후기',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget partTitle({required String title, Widget? trailing}) {
    return trailing == null
        ? Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing,
            ],
          );
  }

  Widget popularServices(PopularServicesModel service) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(service.imgUrl), fit: BoxFit.cover),
            ),
          ),
          const Gap(7),
          Text(service.serviceName),
          Text(
            '✉️ ${service.requestCount}명 요청',
            style: const TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 110, 109, 109)),
          ),
        ],
      ),
    );
  }
}

List<IconInfo> fourIcons = [
  IconInfo(icon: Icons.newspaper, label: '고수 찾기'),
  IconInfo(icon: Icons.people, label: '커뮤니티'),
  IconInfo(icon: Icons.shop, label: '마켓'),
  IconInfo(icon: Icons.image, label: '포트폴리오'),
];

class ScrollableIconRows extends StatelessWidget {
  ScrollableIconRows(this._scrollController);
  final ScrollController _scrollController;

  final List<IconInfo> iconInfo = [
    IconInfo(icon: Icons.home, label: '전체보기'),
    IconInfo(icon: Icons.person, label: '이사/청소'),
    IconInfo(icon: Icons.settings, label: '설치/수리'),
    IconInfo(icon: Icons.email, label: '인테리어'),
    IconInfo(icon: Icons.phone, label: '외주'),
    IconInfo(icon: Icons.camera, label: '취업/직무'),
    IconInfo(icon: Icons.music_note, label: '괴외'),
    IconInfo(icon: Icons.favorite, label: '취미/자기계발'),
    IconInfo(icon: Icons.lock, label: '자동차'),
    IconInfo(icon: Icons.cloud, label: '법률/금융'),
    IconInfo(icon: Icons.star, label: '이벤트/뷰티'),
    IconInfo(icon: Icons.alarm, label: '기타')
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: iconInfo
                .sublist(0, 6)
                .map((icon) => buildIconContainer(iconInfo: icon))
                .toList(),
          ),
          Row(
            children: iconInfo
                .sublist(0, 6)
                .map((icon) => buildIconContainer(iconInfo: icon))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class IconInfo {
  IconData icon;
  String label;
  IconInfo({
    required this.icon,
    required this.label,
  });
}

Widget buildIconContainer(
    {required IconInfo iconInfo, EdgeInsetsGeometry? margin}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 23),
    child: Column(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: margin ?? const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            iconInfo.icon,
            size: 30,
          ),
        ),
        Text(
          iconInfo.label,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 91, 91, 91),
          ),
        )
      ],
    ),
  );
}

class PopularServicesModel {
  final String imgUrl;
  final String serviceName;
  final String requestCount;
  PopularServicesModel({
    required this.imgUrl,
    required this.serviceName,
    required this.requestCount,
  });
}

List<PopularServicesModel> dummyPopularServiceList = [
  PopularServicesModel(
    imgUrl:
        'https://usa.yamaha.com/files/Main_Banner_1920px2_c2f932ffadba28e17dd0d1f6ca29dc83.jpg',
    serviceName: '파이노/키보드 레슨',
    requestCount: '231,345',
  ),
  PopularServicesModel(
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWLxMay2Z9Az8iytJqgknp-De6SGJMGPgwyA&s',
    serviceName: '바이올린 레슨',
    requestCount: '125,467',
  ),
  PopularServicesModel(
    imgUrl:
        'https://www.novakid.co.kr/blog/wp-content/uploads/2022/06/unnamed-2.jpeg',
    serviceName: '기타 레슨',
    requestCount: '478,928',
  ),
  PopularServicesModel(
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZL5U2peCqQIjIdZkMkJXmj8Geio3IwyXqvw&s',
    serviceName: '드럼 레슨',
    requestCount: '189,765',
  ),
];

List<ReviewModel> reviews = [
  ReviewModel(
    username: '김태용',
    jobTitle: '디자이너',
    starCount: 5,
    comment:
        "Updated the app and I no longer have the group feature that I need to use to organize my list of friends. Very inconvenient of the company to get rid of that feature. I am also not getting notifications. I won't see anything under my notification drop downs, no alarm, no number appearing on the app itself on the home screen. Please fix both problems ASAP!!!",
    commenter: '허***가',
    profileImg:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXKI9RF1UHEfMoKfWDTl5LVrbNdpbAo-DAjw&s',
    reviewImg:
        'https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/65/78ce0081ad11e681d7bb31b0a632ef/starry-night.jpg',
  ),
  ReviewModel(
    username: '보일로캐슬',
    jobTitle: '보일러 설치',
    starCount: 5,
    comment:
        "주말에 고장나 급히 일정잡았구요.\n다음날 바로 해주셨습니다.\n친철한 상담과 꼼꼼한 작업에 100% 만족합니다!!!",
    commenter: '김***',
    profileImg:
        'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
  ),
];

class ReviewModel {
  final String username;
  final String jobTitle;
  final int starCount;
  final String comment;
  final String commenter;
  final String profileImg;
  String? reviewImg;
  ReviewModel({
    required this.username,
    required this.jobTitle,
    required this.starCount,
    required this.comment,
    required this.commenter,
    required this.profileImg,
    this.reviewImg,
  });
}

class PortfolioModel {
  final String title;
  final String subcontent;
  final String username;
  final String portfolioImg;
  final String profImg;
  PortfolioModel({
    required this.title,
    required this.subcontent,
    required this.username,
    required this.portfolioImg,
    required this.profImg,
  });
}

List<PortfolioModel> portfolios = [
  PortfolioModel(
    title: '내가 작업한 모델 포트폴리오',
    subcontent: '부분 피팅모델 알바',
    username: '남서연',
    portfolioImg:
        'https://media.istockphoto.com/id/1280410981/photo/brown-eyed-woman-is-looking-tenderly-at-viewer-make-up-hairdressing-and-emotions.jpg?s=612x612&w=0&k=20&c=S5w3dRnbzeN7vo43UaXTmouqVnyXajdTiX4JOW8hNxI=',
    profImg:
        'https://media.istockphoto.com/id/1265032285/photo/portrait-of-young-girl-with-clean-skin-and-soft-makeup.jpg?s=612x612&w=0&k=20&c=GcrInK2xkdxcInX0quxPrdFGkv8DXXDPShUia2T1pv4=',
  ),
  PortfolioModel(
    title: '촬영 모델 포트폴리오',
    subcontent: '패션 촬영 및 룩북 모델',
    username: '김하은',
    portfolioImg:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR49WSRUBI3RRuWtX6FN9r2IGfzsiEoLZ8r7w&s',
    profImg:
        'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
  ),
  PortfolioModel(
    title: '뷰티 & 메이크업 포트폴리오',
    subcontent: '뷰티 화보 및 제품 모델',
    username: '이지은',
    portfolioImg:
        'https://tlz.ae/wp-content/uploads/2023/02/TZ_flower-shop-online.png',
    profImg:
        'https://www.georgetown.edu/wp-content/uploads/2022/02/Jkramerheadshot-scaled-e1645036825432-1050x1050-c-default.jpg',
  ),
  PortfolioModel(
    title: '광고 촬영 포트폴리오',
    subcontent: '생활용품 및 가전제품 모델',
    username: '박민정',
    portfolioImg:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEpI-eDQtsrTOrH2vWjUtYxOzoEsBjJdpT5Q&s',
    profImg:
        'https://austinmonthly.wppcdn.com/wp-content/uploads/2023/10/ALICIA-ROTH-WEIGEL-Author-Photo_credit-Tanialee-Gonzalez-1-e1697746464391.jpg',
  ),
];
