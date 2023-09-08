
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:niezapominajka_flutter/api/notificationApi.dart';
import 'package:niezapominajka_flutter/pages/ZadaniaMain.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/ZadaniaController.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin{
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  final _zadaniaController = Get.put(ZadaniaController());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  double opacity_main = 1;
  String name = "Tomasz";
  int all_imp = 0;
  int undo_imp = 0;
  int all_today = 0;
  int undo_today = 0;
  int procent_szkola = 0;
  int all_szkola = 0;
  int procent_sport = 0;
  int all_sport = 0;
  int procent_praca = 0;
  int all_praca = 0;
  int procent_codziennosc = 0;
  int all_codziennosc = 0;
  bool _chowanie_ustawienia = false;
  bool _chowanie_stokrotka = true;
  bool _chowanie_kategorie= true;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller, 
    curve: Curves.linearToEaseOut
  );

  

  @override
  void initState(){
    super.initState();
    _controller.stop();
    LocalNotification.initilaize(flutterLocalNotificationsPlugin);
    
  }

  
  
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String date = "${today.day}-${today.month}-${today.year}";
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 1,
        ),
        body: Container(
          color: Colors.white,
          child:Opacity(
            opacity: opacity_main,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF4C430),
                    borderRadius: BorderRadius.circular(-12), 
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 5.0,),
                            child:Text("Hej, $name!", style: TextStyle(color: Colors.white, fontSize: 40)),
                          ),
                          const Padding(
                            padding:  EdgeInsets.only(left: 5.0,),
                            child: Text("Jaki plan na dziś?", style: TextStyle(color: Colors.white, fontSize: 25)),
                          ),
                          
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 70)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      color: Color(0xFFF4C430),
                      child: Container(
                        //color: Colors.white,
                        //height: double.infinity,
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Linia ważnych danych
                                InkWell(
                                  onTap: ()async{
                                    await Get.to(()=>ZadaniaMain());
                                    _zadaniaController.getTasks();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.reddit, size: 45,),
                                      Column( 
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:  EdgeInsets.only(left: 10.0,),
                                            child: Text(
                                              "Zadania",
                                              style: TextStyle(
                                                fontSize: 25
                                              )
                                            )
                                          ),
                                          //const Text("Ważne", style: TextStyle(fontSize: 25)),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:  const EdgeInsets.only(left: 10.0),
                                                child: Text("Ilość powiadomień: $all_imp"),
                                              ),
                                              Padding(
                                                padding:  const EdgeInsets.only(left: 10.0),
                                                child: Text("W tym niewykonane: $undo_imp"),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                //Linia dzisiejszych danych
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child:Icon(Icons.face, size: 45,),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding:  EdgeInsets.only(left: 10.0,top: 10.0),
                                          child: Text(
                                            "Wszystkie",
                                            style: TextStyle(
                                              fontSize: 25
                                            )
                                          )
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:  const EdgeInsets.only(left: 10.0),
                                              child: Text("Ilość powiadomień: $all_today"),
                                            ),
                                            Padding(
                                              padding:  const EdgeInsets.only(left: 10.0),
                                              child: Text("W tym niewykonane: $undo_today"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: _chowanie_kategorie,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text("Kategorie:", style: TextStyle(fontSize: 30),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(right: 20.0, top: 20),
                                                padding: EdgeInsets.all(16.0),
                                                decoration:BoxDecoration(
                                                  color: Color(0xFFF89CFF0),
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(15),
                                                      margin: const EdgeInsets.only(bottom: 10.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 4.0, color: const Color(0xFFFFFFFF)),
                                                        borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      child: Text("$procent_szkola%", style: const TextStyle(color: Colors.white, fontSize: 20),),
                                                    ),
                                                    //Text("$procent_szkola%", style: const TextStyle(color: Colors.white, fontSize: 20),),
                                                    const Text("Szkoła", style: TextStyle(color: Colors.white, fontSize: 15),),
                                                    Text("$all_szkola powiadomień na dziś", style: const TextStyle(color: Colors.white, fontSize: 9),)  
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(left: 20.0, top: 20),
                                                padding: EdgeInsets.all(16.0),
                                                decoration:BoxDecoration(
                                                  color: Color(0xFFFFF69B4),
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(15),
                                                      margin: const EdgeInsets.only(bottom: 10.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 4.0, color: const Color(0xFFFFFFFF)),
                                                        borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      child: Text("$procent_sport%", style: const TextStyle(color: Colors.white, fontSize: 20),),
                                                    ),
                                                    const Text("Ważne", style: TextStyle(color: Colors.white, fontSize: 15),),
                                                    Text("$all_sport powiadomień na dziś", style: const TextStyle(color: Colors.white, fontSize: 9),)  
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(right: 20.0, top: 20),
                                                padding: EdgeInsets.all(16.0),
                                                decoration:BoxDecoration(
                                                  color: Color(0xFFFB2FF7E),
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(15),
                                                      margin: const EdgeInsets.only(bottom: 10.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 4.0, color: const Color(0xFFFFFFFF)),
                                                        borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      child: Text("$procent_praca%", style: const TextStyle(color: Colors.white, fontSize: 20),),
                                                    ),
                                                    //Text("$procent_szkola%", style: const TextStyle(color: Colors.white, fontSize: 20),),
                                                    const Text("Praca", style: TextStyle(color: Colors.white, fontSize: 15),),
                                                    Text("$all_praca powiadomień na dziś", style: const TextStyle(color: Colors.white, fontSize: 9),)  
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(left: 20.0, top: 20),
                                                padding: EdgeInsets.all(16.0),
                                                decoration:BoxDecoration(
                                                  color: Color(0xFFFE8CD76),
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(15),
                                                      margin: const EdgeInsets.only(bottom: 10.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 4.0, color: const Color(0xFFFFFFFF)),
                                                        borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      child: Text("$procent_codziennosc%", style: const TextStyle(color: Colors.white, fontSize: 20),),
                                                    ),
                                                    const Text("Codzienność", style: TextStyle(color: Colors.white, fontSize: 15),),
                                                    Text("$all_codziennosc powiadomień na dziś", style: const TextStyle(color: Colors.white, fontSize: 9),)  
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    )
                                    
                                  ],
                                ),
                              ],
                            ),
                          ],    
                        ),
                      ),
                    ),   
                  ],
                ),
                
                Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child:Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFfdde6c),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                        ),
                        child:Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 65.0,
                              width: 95.0,
                              child: RotationTransition(
                                turns: _animation,
                                child:IconButton(
                                  icon: Image.asset("images/stokrotka.png"),
                                  onPressed: ()=> {
                                    _controller.repeat(),
                                    Future.delayed(
                                      Duration(milliseconds: 800), () { // <-- Delay here
                                        setState(() {
                                          _showBottomSheet();
                                          _controller.reactive();
                                          _controller.stop(); // <-- Code run after delay
                                        });
                                      }),
                                    
                                  }
                                ),
                              )
                            )
                          ],
                        ) ,
                      )
                    ),
                ),
              ],      
            ),
          )  
        )
    );
  }
  _showBottomSheet(){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[600]
              ),
            ),
            const Padding(
              padding:  EdgeInsets.only(left: 15.0,top: 10),
              child:Text("Szybki wybór", style: TextStyle(color: Colors.black, fontSize: 25)),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      LocalNotification.showBigTextNotification(
                        title: "test", 
                        body: "Your long test body", 
                        fln: flutterLocalNotificationsPlugin
                      );
                    } 
                  ),                 
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () async {
                      PermissionStatus notifiationStatus =await Permission.notification.request();
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
              ]
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
              ]
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
              ]
            ),
            const Padding(
              padding:  EdgeInsets.only(left: 15.0,top: 5.0),
              child:Text("Ustawienia", style: TextStyle(color: Colors.black, fontSize: 25)),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                    setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                      setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
              ]
            ),
            Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                    setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                    setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                    setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                    setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child:IconButton(
                    icon: Image.asset("images/white_circle.png"),
                    onPressed: () {
                    setState(() {
                        _chowanie_ustawienia = !_chowanie_ustawienia;
                        _chowanie_stokrotka = !_chowanie_stokrotka;
                        _chowanie_kategorie = !_chowanie_kategorie;
                      });
                    }
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder( // <-- SEE HERE
        borderRadius: BorderRadius.only( 
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Color(0xFFFfdde6c),
    );
  }
}