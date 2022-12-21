import 'package:flutter/material.dart';
import 'package:app/db_provider.dart';
import 'package:app/kontak.dart';
import 'package:provider/provider.dart';

class FormUpdatePage extends StatefulWidget {
  final Kontak? kontak;

  const FormUpdatePage({Key? key, this.kontak}) : super(key: key);

  @override
  State<FormUpdatePage> createState() => _FormUpdatePageState();
}

class _FormUpdatePageState extends State<FormUpdatePage> {
  TextEditingController? nama;
  TextEditingController? nomor;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.nama);
    nomor = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.nomor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: nama,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),
            TextField(
              controller: nomor,
              decoration: const InputDecoration(
                labelText: 'Nomor',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Simpan'),
                onPressed: () async {
                  final kontak = Kontak(
                    id: widget.kontak!.id!,
                    nama: nama!.text,
                    nomor: nomor!.text,
                  );
                  Provider.of<DbProvider>(context, listen: false)
                      .upKontak(kontak);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nama!.dispose();
    nomor!.dispose();
    super.dispose();
  }
}
