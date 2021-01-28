class Aurizon_Systems{
  String system_Types;
  String system_Code;
  String id_Copy;

  Aurizon_Systems({this.system_Types,this.system_Code,this.id_Copy});

  //This Map function will convert the Object into Json
  Map<String,dynamic> toJson()=>{
    'system_Types':system_Types,
    'system_Code':system_Code,
    'id_Copy':id_Copy,
  };

//  This funciton will convert json to Object

  Aurizon_Systems.fromJson(Map<String,dynamic> json):
        system_Types = json['system_Types'],system_Code = json['system_Code'],id_Copy = json['ID_Copy'];

}
