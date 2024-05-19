import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixlit/main.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/client_home/upper_catagory_header.dart';
import 'package:fixlit/widgets/client_home/main_header.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int activeIndex = 0;
  final images = [
    'assets/imgs/plumb.webp',
    'assets/imgs/clean1.jpg',
    'assets/imgs/driver1.jpg',
    'assets/imgs/elect.jpeg',
    'assets/imgs/lawn1.webp',
    'assets/imgs/paint1.jpg',
    'assets/imgs/lawn.jpeg',
  ];

  @override
  void initState() {
    Services.clientProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClientCustomAppBar(
            btn: false,
            isSearch: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const UpperCatagoryHeader(),
              const SizedBox(
                height: 18,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      "Popular Services",
                      style: TextStyle(
                        fontSize: 20,
                        color: darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    final path = images[index];
                    return buildImage(path, index);
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    height: MediaQuery.of(context).size.height * .38,
                    onPageChanged: (index, reason) => setState(() {
                      activeIndex = index;
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildIndicator()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
          dotWidth: 15,
          dotHeight: 6,
          activeDotColor: darkColor,
        ),
        activeIndex: activeIndex,
        count: images.length,
      );
  Widget buildImage(String path, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: darkColor.withOpacity(.35), width: 4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
