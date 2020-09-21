import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    final String code;
    final String status;
    final String message;
    final Data data;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.empid,
        this.cizid,
        this.imei,
        this.passcode,
        this.prename,
        this.firstname,
        this.lastname,
        this.position,
        this.department,
        this.salary,
        this.birthdate,
        this.status,
    });

    final String id;
    final String empid;
    final String cizid;
    final String imei;
    final String passcode;
    final String prename;
    final String firstname;
    final String lastname;
    final String position;
    final String department;
    final String salary;
    final DateTime birthdate;
    final String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        empid: json["empid"] == null ? null : json["empid"],
        cizid: json["cizid"] == null ? null : json["cizid"],
        imei: json["imei"] == null ? null : json["imei"],
        passcode: json["passcode"] == null ? null : json["passcode"],
        prename: json["prename"] == null ? null : json["prename"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        position: json["position"] == null ? null : json["position"],
        department: json["department"] == null ? null : json["department"],
        salary: json["salary"] == null ? null : json["salary"],
        birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "empid": empid == null ? null : empid,
        "cizid": cizid == null ? null : cizid,
        "imei": imei == null ? null : imei,
        "passcode": passcode == null ? null : passcode,
        "prename": prename == null ? null : prename,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "position": position == null ? null : position,
        "department": department == null ? null : department,
        "salary": salary == null ? null : salary,
        "birthdate": birthdate == null ? null : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
    };
}