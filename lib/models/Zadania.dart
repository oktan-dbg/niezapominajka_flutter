class Zadania{
  int? id;
  String? dataDodania;
  String? nazwa;
  String? opis;
  String? projekt;
  String? dataDeadline;
  String? godzinaDeadline;
  int? dlugosc;
  String? priorytet;
  String? rodzaj;
  int? okresWykonania;
  int? wykonane;



  Zadania({
    this.id,
    this.dataDodania,
    this.nazwa,
    this.opis,
    this.projekt,
    this.dataDeadline,
    this.godzinaDeadline,
    this.dlugosc,
    this.priorytet,
    this.rodzaj,
    this.okresWykonania,
    this.wykonane,
  });

  Zadania.fromJson(Map<String, dynamic> json){
    id = json['id'];
    dataDodania = json['dataDodania'];
    nazwa = json['nazwa'];
    opis = json['opis'];
    projekt = json['projekt'];
    dataDeadline = json['dataDeadline'];
    godzinaDeadline = json['godzinaDeadline'];
    dlugosc = json['dlugosc'];
    priorytet = json['priorytet'];
    rodzaj = json['rodzaj'];
    okresWykonania = json['okresWykonania'];
    wykonane = json['wykonane'];
  }

  //get color => null;

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dataDodania'] = this.dataDodania;
    data['nazwa'] = this.nazwa;
    data['opis'] = this.opis;
    data['projekt'] = this.projekt;
    data['dataDeadline'] = this.dataDeadline;
    data['godzinaDeadline'] = this.godzinaDeadline;
    data['dlugosc'] = this.dlugosc;
    data['priorytet'] = this.priorytet;
    data['rodzaj'] = this.rodzaj;
    data['okresWykonania'] = this.okresWykonania;
    data['wykonane'] = this.wykonane;
    return data;
  }
}