import 'package:flutter/material.dart';

import '../models/profile.dart';
import 'db_helper.dart';

class Profiles extends ChangeNotifier {
  final List<Profile> _profiles = [];
  Stream<List<Map<String, dynamic>>>? _profilesStream;

  List<Profile> get profiles {
    if (_profilesStream == null) {
      DbHelper.fetchProfiles().then((value) {
        _profiles.clear();
        _profiles.addAll(value);
      });
      _profilesStream = DbHelper.profilesStream;
      _profilesStream!.listen(
        (event) => _updateProfile(event),
      );
    }
    return _profiles;
  }

  Profile? get own {
    final list =
        profiles.where((element) => element.id == DbHelper.currentUser!.id);
    if (list.isNotEmpty) {
      return list.first;
    } else {
      return null;
    }
  }

  _updateProfile(List<Map<String, dynamic>> data) {
    final List<Profile> profiles = data.map((e) => Profile.fromMap(e)).toList();

    _profiles.clear();
    _profiles.addAll(profiles);
    notifyListeners();
  }
}
