import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:niezapominajka_flutter/controllers/ZadaniaController.dart';
import 'package:niezapominajka_flutter/models/Zadania.dart';
import 'package:niezapominajka_flutter/pages/ZadaniaDodaj.dart';
import 'package:niezapominajka_flutter/themes/theme.dart';
import 'package:niezapominajka_flutter/widgets/TaskButton.dart';
import 'package:niezapominajka_flutter/widgets/TaskTile.dart';

class ZadaniaMain extends StatefulWidget{
  const ZadaniaMain({Key? key}) : super(key: key);

  @override
  _ZadaniaMain createState() => _ZadaniaMain();
}

class _ZadaniaMain extends State<ZadaniaMain> {
  DateTime _selectedDate = DateTime.now();
  final _zadaniaController = Get.put(ZadaniaController());
  String _dayText = "Dzisiaj";
  int dni = 0;

  @override
  void initState(){
    super.initState();
    _zadaniaController.getTasks();
    setState(() {
      print("I am here");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build method called");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 1,
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 12,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks(){
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _zadaniaController.taskList.length,
          itemBuilder: (context,index){
            print(_zadaniaController.taskList.length);
            return AnimationConfiguration.staggeredList(
              position: index, 
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          _showBottomSheet(context, _zadaniaController.taskList[index]);
                        },
                        child: TaskTile(_zadaniaController.taskList[index]),
                      )
                    ]
                  ),
                ),
              )
            );
          });
      })
    );
  }

  _showBottomSheet(BuildContext context, Zadania zadania){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: zadania.wykonane==1?
        //height: true?
        MediaQuery.of(context).size.height*0.24:
        MediaQuery.of(context).size.height*0.32,
        color: white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[600]
              ),
            ),
            Spacer(),
            //false
            zadania.wykonane==1
            ?Container()
              : _bottomSheetButton(
                  label: "Gotowe",
                  onTap: (){
                    _zadaniaController.markTaskCompleted(zadania.id!);
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context
                ),
                _bottomSheetButton(
                  label: "Usuń Zadanie",
                  onTap: (){
                    _zadaniaController.delete(zadania);
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context: context
                ),
                SizedBox(
                  height: 20,
                ),
                _bottomSheetButton(
                  label: "Zamknij",
                  onTap: (){
                    _zadaniaController.getTasks();
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  isClose: true,
                  context: context
                ),
                SizedBox(
                  height: 10,
                ),
          ],
        ),
      )
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar(){
    return Container(
        margin: const EdgeInsets.only(top: 20, left: 20),
        child: DatePicker(
          DateTime.now(), 
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: Color(0xFFFfdde6c),
          selectedTextColor: Color.fromRGBO(255, 255, 255, 1),
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            )
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            )
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            )
          ),
          onDateChange: (date){
            _selectedDate = date;
            dni = daysBetween(date, DateTime.now());
            print(dni);
            if(dni==0){
              setState(() {
                _dayText="Dzisiaj";
              });
              //_dayText="Dzisiaj";
              print(_dayText);
            }else if(dni==-1){
              setState(() {
                _dayText="Jutro";
              });
              //_dayText="Jutro";
              print(_dayText);
            }else if(dni==1){
              setState(() {
                _dayText="Wczoraj";
              });
              //_dayText="Wczoraj";
              print(_dayText);
            }else{
              setState(() {
                _dayText=" ";
              });
              //_dayText=" ";
            }
          },
        ),
    );
  }

  _addTaskBar(){
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 10, top: 10),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat("dd MMM yyyy").format(DateTime.now()),
                  style: subHeadingStyle
                  //style: SubH,
                  ),
                  Text("${_dayText}",
                  style: headingStyle,
                  )
                ],
              ),
            ),
            MyTaskButton(label: "+ Dodaj Zadanie", onTap: ()async{
              await Get.to(()=>ZadaniaDodaj());
              _zadaniaController.getTasks();
            })
          ],
        ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
  }
}
