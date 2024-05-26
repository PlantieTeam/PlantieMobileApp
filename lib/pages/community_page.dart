import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CommunityPage> {
  List<String> posts = [
    'Post 1',
    'Post 2',
    'Post 3',
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE6E6E6)),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.notifications_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.more_vert),
                ],
              )),
          Divider(
            color: Colors.grey.shade300,
          ),

          /// posts
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.98,
                margin: const EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                    itemCount: posts.length > 4 ? 4 : posts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Column(children: [
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      backgroundImage: NetworkImage(FirebaseAuth
                                          .instance.currentUser!.photoURL!)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(FirebaseAuth
                                          .instance.currentUser!.displayName!),
                                      const Row(
                                        children: [
                                          Text(
                                            "1 d   •   ",
                                            style: TextStyle(
                                                color: Color(0xff777777),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Image(
                                            image: AssetImage(
                                                "assets/icons/tomato.png"),
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(
                                            " Tomato",
                                            style: TextStyle(
                                                color: Color(0xff777777),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: const Text(
                                "Hello! my corn condition is like this. What is the disease and how to deal with it? ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/images/test2.png"),
                              fit: BoxFit.cover,
                            )),
                          ),
                          const SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF0EFEF),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton.icon(
                                          style: TextButton.styleFrom(
                                            foregroundColor: const Color(0xff00796A),

                                              shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(50),
                                                topLeft: Radius.circular(50)),
                                          )),
                                            onPressed: () {},
                                            icon: const Icon(Icons.favorite),
                                            label: const Text("5")),
                                        Container(
                                          // margin:
                                          // const EdgeInsets.only(left: 10),
                                          width: 1,
                                          // height: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          color: const Color(0xffDADADA),
                                        ),
                                        TextButton.icon(
                                          style: TextButton.styleFrom(
                                            foregroundColor: const Color(0xff00796A),
                                              shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(50),
                                                topRight: Radius.circular(50)),
                                          )),
                                          onPressed: () {},
                                          label: const Icon(Icons.heart_broken),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Spacer(),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xff00796A),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(Icons.message),
                                    label: const Text("5"),
                                  )
                                ],
                              ))
                        ])),
                      );
                    })),
          )
        ],
      ),
    ));
  }
}
