import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
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
          CustomAppBar(
            btn: false,
            isSearch: true,
          ),
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  const UpperCatagoryHeader(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          "Populer Services :",
                          style: TextStyle(
                            fontSize: 20,
                            color: Clrs.mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) {
                        final path = images[index];
                        return buildImage(path, index);
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        height: MediaQuery.of(context).size.height * .28,
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
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotWidth: 15,
          dotHeight: 6,
          activeDotColor: Clrs.mainColor,
        ),
        activeIndex: activeIndex,
        count: images.length,
      );
  Widget buildImage(String path, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // border: Border.all(color: Clrs.mainColor),
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
