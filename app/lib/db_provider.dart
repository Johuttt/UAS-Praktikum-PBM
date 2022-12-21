// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:app/database_helper.dart';
import 'package:app/kontak.dart';

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;
  List<Kontak> _kontaks = [];
  List<Kontak> get kontaks => _kontaks;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllKontaks();
  }

  void _getAllKontaks() async {
    _kontaks = await _dbHelper.getKontaks();
    notifyListeners();
  }

  Future<void> addKontak(Kontak kontak) async {
    await _dbHelper.insertKontak(kontak);
    _getAllKontaks();
  }

  Future<void> delKontak(Kontak kontak, int position) async {
    await _dbHelper.deleteKontak(kontak.id!);
    print(kontak.nomor);
    _getAllKontaks();
  }

  Future<void> upKontak(Kontak kontak) async {
    await _dbHelper.updateKontak(kontak);
    _getAllKontaks();
  }
}
