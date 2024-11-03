import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_pros/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:scroll_indicator/scroll_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<int> adScrollIndex = ValueNotifier(0);

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
      appBar: AppBar(
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
            margin: const EdgeInsets.only(right: 15, left: 10),
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(MyColors.primaryColor),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Center(
              child: Text(
                '고수 가입',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Gap(10),
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 17),
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
          const Gap(20),
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
          const Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged: (index, reason) =>
                        adScrollIndex.value = index,
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
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      color: Colors.blueGrey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: adScrollIndex,
                        builder: (context, value, child) => Text(
                          '$value/${urlImages1.length}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            children: iconInfo
                .sublist(0, 6)
                .map((icon) => _buildIconContainer(iconInfo: icon))
                .toList(),
          ),
          Row(
            children: iconInfo
                .sublist(6)
                .map((icon) => _buildIconContainer(iconInfo: icon))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer({required IconInfo iconInfo}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 23),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(
                15,
              ),
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
}

class IconInfo {
  IconData icon;
  String label;
  IconInfo({
    required this.icon,
    required this.label,
  });
}
