import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:niezapominajka_flutter/controllers/ZadaniaController.dart';
import 'package:niezapominajka_flutter/models/Zadania.dart';
import 'package:niezapominajka_flutter/widgets/InputField.dart';
import 'package:niezapominajka_flutter/widgets/TaskButton.dart';
import '../themes/theme.dart';

class ZadaniaDodaj extends StatefulWidget {
  const ZadaniaDodaj({Key? key}) : super(key: key);
  

  @override
  _ZadaniaDodajState createState() => _ZadaniaDodajState();
}

class _ZadaniaDodajState extends State<ZadaniaDodaj> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  final ZadaniaController _zadaniaController = Get.put(ZadaniaController());

  final TextEditingController _nazwaController = TextEditingController();
  final TextEditingController _opisController = TextEditingController();
  final TextEditingController _projektController = TextEditingController();
  final TextEditingController _rodzajController = TextEditingController();
  final TextEditingController _priorytetController = TextEditingController();
  final TextEditingController _godzinaController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _dlugoscController = TextEditingController();
  final TextEditingController _czasController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime="9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList=[
    5,
    10,
    15,
    20
  ];

  int _selectedDlugosc = 1;
  List<int> dlugoscList=[
    1,
    2,
    3,
    4
  ];

  String _selectedProject = "Wybierz swój projekt";
  List<String> projectList=[
    "Brak",
    "Aplikacja Mobilna",
    "Test",
    "Szkoła"
  ];

  String _selectedRepeat = "None";
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly"
  ];

  String _selectedPriorytet = "Zwykłe";
  List<String> priorytetList=[
    "Ważne",
    "Mniej",
    "Zwykłe"
  ];

  String _selectedRodzaj = "None";
  List<String> rodzajList=[
    "sprawdzian",
    "kartkowka",
    "praca domowa",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 1,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("Dodaj Zadanie", style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),),
              ),
              MyInputField(title: "Nazwa", hint: "Wpisz nazwę zadania", controller: _nazwaController,),
              MyInputField(title: "Opis", hint: "Opisz swoje zadanie", controller: _opisController,),
              MyInputField(title: "Projekt", hint: "$_selectedProject", controller: _projektController,
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedProject = newValue!;
                    });
                  },
                  items: projectList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!, style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(title: "Rodzaj", hint: "$_selectedRodzaj", controller: _rodzajController,
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRodzaj = newValue!;
                    });
                  },
                  items: rodzajList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!, style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(title: "Priorytet", hint: "$_selectedPriorytet", controller: _priorytetController,
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedPriorytet = newValue!;
                    });
                  },
                  items: priorytetList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!, style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Godzina", 
                      hint: _startTime,
                      controller: _godzinaController,
                      widget: IconButton(
                        icon: Icon(
                          Icons.access_time_rounded, 
                          color: Colors.grey,),
                        onPressed: (){
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    )
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(title: "Deadline", hint: DateFormat.yMd().format(_selectedDate), controller: _deadlineController,
                      widget: IconButton(
                        icon:Icon(Icons.calendar_today_outlined, color: Colors.grey,),
                        onPressed: () { 
                          _getDateFromUser();
                        }, 
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(title: "Dlugość w godzinach", hint: "$_selectedDlugosc ", controller: _dlugoscController,
                      widget: DropdownButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(height: 0),
                        onChanged: (String? newValue){
                          setState(() {
                            _selectedDlugosc = int.parse(newValue!);
                          });
                        },
                        items: dlugoscList.map<DropdownMenuItem<String>>((int value){
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(title: "Czas na wykonanie", hint: "Wpisz nazwę zadania", controller: _czasController,),
                  )
                ],
              ),
              
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25,),
                  MyTaskButton(label: "Stwórz Zadanie", onTap: () => _validateDate())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: titleStyle,),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
            3,
              (int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor=index;
                      print("$index");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?primaryClr:index==1?pinkClr:yellowClr,
                      child: _selectedColor==index?Icon(Icons.done,
                        color: Colors.white,
                        size: 16,
                      ):Container(),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  _validateDate(){
    if(_nazwaController.text.isNotEmpty&&_opisController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }else if(_nazwaController.text.isEmpty&&_opisController.text.isEmpty){
      Get.snackbar("Reuired", "All fields are reuired !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning_amber_rounded,
        color: Colors.red,
        )
      );
    }
  }

  _addTaskToDb() async{
    int value = await _zadaniaController.addTask(
      zadania: Zadania(
        dataDodania: DateTime.now().toString(),
        nazwa: _nazwaController.text,
        opis: _opisController.text,
        projekt: _selectedProject,
        dataDeadline: DateFormat.yMd().format(_selectedDate),
        godzinaDeadline: _startTime,
        dlugosc: _selectedDlugosc,
        priorytet: _selectedPriorytet,
        rodzaj: _selectedRodzaj,
        okresWykonania: int.parse(_czasController.text),
        wykonane: 0
      )
    );
    print("My id is "+"$value");
    //print(_startTime);
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), //get today's date
      firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101)
    );

    if(pickedDate!=null){
      setState(() {
        _selectedDate = pickedDate;
        print(_selectedDate);
      });
    }else{
      print("Its not null");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime=await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time Canceld");
    }else if(isStartTime==true){
      _startTime=_formatedTime;
    }else if(isStartTime==false){
      _endTime=_formatedTime;
    } 
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context, 
      initialTime: TimeOfDay(
        hour: 9, 
        minute: 10
      )
    );
  }
}