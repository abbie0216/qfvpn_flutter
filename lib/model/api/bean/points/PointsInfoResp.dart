class PointsInfoResp {
  Tasks tasks;
  int totalPoint;
  int usablePoint;

  PointsInfoResp(
      {required this.tasks,
      required this.totalPoint,
      required this.usablePoint});

  factory PointsInfoResp.fromJson(Map<String, dynamic> json) {
    return PointsInfoResp(
      tasks: Tasks.fromJson(json['tasks']),
      totalPoint: json['totalPoint'],
      usablePoint: json['usablePoint'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalPoint'] = totalPoint;
    data['usablePoint'] = usablePoint;
    data['tasks'] = tasks.toJson();

    return data;
  }
}

class Tasks {
  BindEmail bindEmail;
  Signin signin;

  Tasks({required this.bindEmail, required this.signin});

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      bindEmail: BindEmail.fromJson(json['bindEmail']),
      signin: Signin.fromJson(json['signin']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bindEmail'] = bindEmail.toJson();
    data['signin'] = signin.toJson();

    return data;
  }
}

class Signin {
  List<ByDay> byDays;
  bool isTodaySignin;
  int periodContinueDays;

  Signin(
      {required this.byDays,
      required this.isTodaySignin,
      required this.periodContinueDays});

  factory Signin.fromJson(Map<String, dynamic> json) {
    return Signin(
      byDays: (json['byDays'] as List).map((i) => ByDay.fromJson(i)).toList(),
      isTodaySignin: json['isTodaySignin'],
      periodContinueDays: json['periodContinueDays'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isTodaySignin'] = isTodaySignin;
    data['periodContinueDays'] = periodContinueDays;
    data['byDays'] = byDays.map((v) => v.toJson()).toList();
    return data;
  }
}

class ByDay {
  String day;
  String dayShort;
  bool isSignIn;
  bool isToday;
  int point;

  ByDay(
      {required this.day,
      required this.dayShort,
      required this.isSignIn,
      required this.isToday,
      required this.point});

  factory ByDay.fromJson(Map<String, dynamic> json) {
    return ByDay(
      day: json['day'],
      dayShort: json['dayShort'],
      isSignIn: json['isSignIn'],
      isToday: json['isToday'],
      point: json['point'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['dayShort'] = dayShort;
    data['isSignIn'] = isSignIn;
    data['isToday'] = isToday;
    data['point'] = point;
    return data;
  }
}

class BindEmail {
  bool isBind;
  int point;

  BindEmail({required this.isBind, required this.point});

  factory BindEmail.fromJson(Map<String, dynamic> json) {
    return BindEmail(
      isBind: json['isBind'],
      point: json['point'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isBind'] = isBind;
    data['point'] = point;
    return data;
  }
}
