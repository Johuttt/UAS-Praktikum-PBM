// ignore_for_file: prefer_const_constructors

import 'package:app/form_create.dart';
import 'package:app/form_update.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:app/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? username = '';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('usernameUser') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hallo! $username'),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove("usernameUser");
                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final kontaks = provider.kontaks;

          return ListView.builder(
            itemCount: kontaks.length,
            itemBuilder: (context, index) {
              final kontak = kontaks[index];
              return Dismissible(
                key: Key(kontak.id.toString()),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  // ignore: todo
                  // TODO : Kode untuk menghapus note
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                    title: Text(kontak.nama),
                    subtitle: Text(kontak.nomor),
                    onTap: () async {
                      // ignore: todo
                      // TODO : Kode untuk mendapatkan note yang dipilih dan dikirimkan ke NoteAddUpdatePage
                    },
                    trailing: FittedBox(
                      fit: BoxFit.fill,
                      child: Row(
                        children: [
                          //Button Edit
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormUpdatePage(kontak: kontak)));
                              },
                              icon: const Icon(Icons.edit)),
                          //Button Hapus
                          IconButton(
                              onPressed: () {
                                //Dialog Konformasi Hapus
                                AlertDialog hapus = AlertDialog(
                                  title: const Text("Informasi"),
                                  content: SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Text(
                                            "Anda yakin ingin menghapus data ${kontak.nama}")
                                      ],
                                    ),
                                  ),
                                  //terdapat 2 button
                                  //jika ya maka dijalankan _deleteKontak() dan tutup dialog
                                  //jika tidak maka dialog di tutup
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Provider.of<DbProvider>(context,
                                                  listen: false)
                                              .delKontak(kontak, index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ya")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Tidak"))
                                  ],
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) => hapus);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormCreatePage()));
        },
      ),
    );
  }
}
