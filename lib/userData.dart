import 'dart:math';

class User {
  List<UserInfo> userInfo = [];

  void initData(int size) {
    userInfo.clear();
    Random random = Random();
    for (int i = 0; i < size; i++) {
      int newInt=random.nextInt(100);
      bool status=random.nextBool();
      String statusStr=status.toString();
      userInfo.add(UserInfo(
          //"User_$i", random.nextBool(), '+001 9999 9$newInt', '2019-01-01', 'N/A'));
          "User_$i", statusStr, '+001 9999 9$newInt', '2019-01-01', 'N/A'));
    }
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    userInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
      int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(String isAscending) {
    userInfo.sort((a, b) {
      if (a.status == b.status) {
        int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
        int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
        return (aId - bId);
      } else if (a.status=='true') {
        return isAscending=='true' ? 1 : -1;
      } else {
        return isAscending=='false' ? -1 : 1;
      }
    });
  }
}

class UserInfo {
  String name;
  String status;
  String phone;
  String registerDate;
  String terminationDate;

  UserInfo(this.name, this.status, this.phone, this.registerDate,
      this.terminationDate);

  dynamic get(String fieldName) {
    if (fieldName == 'Name') {
      return name;
    } else if (fieldName == 'Status') {
      return status;
    } else if (fieldName == 'Phone') {
      return phone;
    } else if (fieldName == 'Register') {
      return registerDate;
    } else if (fieldName == 'Termination') {
      return terminationDate;
    }
    throw Exception('Invalid field name');
  }
}

class UserColumnInfo {
  final String name;
  final double width;
  const UserColumnInfo(this.name, this.width);
}