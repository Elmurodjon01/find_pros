import 'package:find_pros/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          ScrollableIconRows(),
        ],
      ),
    );
  }
}

class ScrollableIconRows extends StatefulWidget {
  @override
  State<ScrollableIconRows> createState() => _ScrollableIconRowsState();
}

class _ScrollableIconRowsState extends State<ScrollableIconRows> {
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
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        minThumbLength: 20, // Adjust the minimum thumb length
        thumbColor:
            MaterialStateProperty.all(Colors.blue), // Customize color if needed
      ),
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        controller: scrollController,
        thickness: 2, // Adjust scrollbar thickness
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
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
        ),
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
