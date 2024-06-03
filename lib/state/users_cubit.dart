import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/user_data.dart';

class UsersCubit extends Cubit<List<UserData>> {
  UsersCubit() : super([]) {
    FirebaseFirestore.instance //
        .collection('users')
        .snapshots()
        .listen(
      (data) {
        final users = data.docs.map((d) => UserData.fromMap(d.data())).toList();
        emit(users);
      },
    );
  }
}
