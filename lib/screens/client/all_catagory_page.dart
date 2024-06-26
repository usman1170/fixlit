import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/screens/client/catagory_card_result.dart';
import 'package:fixlit/widgets/client_home/main_header.dart';
import 'package:flutter/material.dart';

class SeeAllCatagoryScreen extends StatefulWidget {
  const SeeAllCatagoryScreen({super.key});

  @override
  State<SeeAllCatagoryScreen> createState() => _SeeAllCatagoryScreenState();
}

class _SeeAllCatagoryScreenState extends State<SeeAllCatagoryScreen> {
  List<ServiceProvider> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClientCustomAppBar(
            btn: true,
            isSearch: true,
          ),
          Expanded(
              child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AllCatagoryCard(
                    title: 'Plumbing',
                    image: 'assets/imgs/plumb1.jpg',
                    list: list,
                  ),
                  AllCatagoryCard(
                    title: 'Electrition',
                    image: 'assets/imgs/elect.jpeg',
                    list: list,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AllCatagoryCard(
                    title: 'Driver',
                    image: 'assets/imgs/driver.jpg',
                    list: list,
                  ),
                  AllCatagoryCard(
                    title: 'Painting',
                    image: 'assets/imgs/paint.jpg',
                    list: list,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AllCatagoryCard(
                    title: 'Cleaning',
                    image: 'assets/imgs/clean.jpeg',
                    list: list,
                  ),
                  AllCatagoryCard(
                    title: 'Lawn Mowing',
                    image: 'assets/imgs/lawn.jpeg',
                    list: list,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AllCatagoryCard(
                    title: 'AC Service',
                    image: 'assets/imgs/ac.webp',
                    list: list,
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class AllCatagoryCard extends StatelessWidget {
  const AllCatagoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.list,
  });
  final String title;
  final String image;
  final List<ServiceProvider> list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchedCatagory(
                catagory: title,
              ),
            ),
          );
        },
        child: Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .185,
                  width: MediaQuery.of(context).size.width * .4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
