import 'package:fixlit/main.dart';
import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/widgets/animated_text_and_method.dart';
import 'package:flutter/material.dart';

class UpperContainerDetails extends StatelessWidget {
  const UpperContainerDetails({super.key, required this.user});
  final ServiceProvider user;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: mq.width,
      height: mq.height * .32,
      decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(.7),
              blurRadius: 12,
            )
          ]),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            width: mq.width * .4,
            height: mq.height * .26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Colors.amber,
            ),
            child: ImageViewerClip(
              urlImage: user.image,
              width: mq.width * .4,
              height: mq.height * .26,
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
              SizedBox(height: 3),
              VerticalSpacer(),
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const DotWidget(),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .31,
                    child: Text(
                      user.name.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const DotWidget(),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    user.city,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const DotWidget(),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    user.catagory,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const DotWidget(),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Text(
                      user.available ? "Available" : "Not Available Right now",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const DotWidget(),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Text(
                      user.timings,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
