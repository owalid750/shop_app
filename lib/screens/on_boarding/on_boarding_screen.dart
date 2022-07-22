import 'package:flutter/material.dart';

import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;
  BoardingModel({this.image, this.title, this.body});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardingcontroller = PageController();
  bool isLast = false;
  final List<BoardingModel> list = [
    BoardingModel(
        image: "images/b1.png", title: "Board screan 1", body: "Body screan 1"),
    BoardingModel(
        image: "images/b002.png",
        title: "Board screan 2",
        body: "Body screan 2"),
    BoardingModel(
        image: "images/b3.png", title: "Board screan 3", body: "Body screan 3")
  ];
  void submit() {
    CacheHelper.saveDate(key: "onBoarding", value: true)?.then((value) {
    
        navigateAndFinish(context, LoginScreen());
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text("SKIP"))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingcontroller,
                itemCount: list.length,
                onPageChanged: (index) {
                  if (index == list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return buildboarding(list[index]);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingcontroller,
                  count: list.length,
                  axisDirection: Axis.horizontal,
                  effect: const ExpandingDotsEffect(
                      spacing: 8.0,
                      radius: 4.0,
                      dotWidth: 20.0,
                      dotHeight: 16.0,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: defaultcolor),
                ),
                const Spacer(),
                // FloatingActionButton(
                //   onPressed: () {
                //     isLast == false
                //         ? boardingcontroller.nextPage(
                //             duration: const Duration(milliseconds: 700),
                //             curve: Curves.fastLinearToSlowEaseIn)
                //         : Navigator.push(context,
                //             MaterialPageRoute(builder: (contex) {
                //             return  LoginScreen();
                //           }));
                //   },
                //   child: isLast == false
                //       ? const Icon(Icons.arrow_forward_ios)
                //       : const Icon(Icons.done),
                // )
                TextButton(
                    onPressed: () {
                      isLast == false
                          ? boardingcontroller.nextPage(
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.fastLinearToSlowEaseIn)
                          : submit();
                    },
                    child: isLast == false ? Text("NEXT") : Text("GOT IT")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildboarding(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset(
              "${model.image}",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "${model.title}",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${model.body}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
