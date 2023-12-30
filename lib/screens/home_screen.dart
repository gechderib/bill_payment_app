import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
            height: 151,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XFF2AA5E8), Color(0XFFF07AAC)]),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 31,
                        height: 31,
                        margin: EdgeInsets.only(left: 12, top: 13),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Builder(
                          builder: (ctx) => IconButton(
                            onPressed: () {
                              Scaffold.of(ctx).openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 31,
                            height: 31,
                            margin: EdgeInsets.only(top: 13),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notifications_active),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          const SizedBox(width: 11),
                          Container(
                            height: 34,
                            width: 34,
                            margin: EdgeInsets.only(top: 13, right: 13),
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage("assets/images/prof.png")),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: const Text(
                      "Welcome Rahul",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Mulish",
                        shadows: [
                          Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          suffixIcon: Icon(Icons.search_outlined),
                          contentPadding: EdgeInsets.only(
                            left: 16,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          hintText: "Search Topics"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}


















      //     CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       expandedHeight: 56.0,
      //       pinned: true,
      //       leading: IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back_ios, // Use your custom icon here
      //           color: Colors.white, // Customize the icon color
      //         ),
      //         onPressed: () {
      //           // Handle the back button press
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //       flexibleSpace: FlexibleSpaceBar(
      //         centerTitle: true,
      //         title: const Text(
      //           'Your Bill Bayment',
      //           style: TextStyle(fontSize: 20),
      //         ),
      //         background: Container(
      //           decoration: const BoxDecoration(
      //             gradient: LinearGradient(
      //               colors: [Colors.blue, Colors.green],
      //               begin: Alignment.topLeft,
      //               end: Alignment.bottomRight,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),