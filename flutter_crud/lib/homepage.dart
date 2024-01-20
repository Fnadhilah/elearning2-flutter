import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/editdata.dart';
import 'package:flutter_crud/tambahdata.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(Uri.parse(
          'http://192.168.25.157/flutterapi/crudflutter/api/mahasiswa/read.php'));
      if (respone.statusCode == 200) {
        //print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _delete(String id) async {
    try {
      final respone = await http.post(
          Uri.parse(
              'http://192.168.25.157/flutterapi/crudflutter/api/mahasiswa/delete.php'),
          body: {
            "npm": id,
          });
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    //print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Mahasiswa"),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditData(
                              ListData: {
                                "id": _listdata[index]["id"],
                                "npm": _listdata[index]["npm"],
                                "nama": _listdata[index]["nama"],
                                "alamat": _listdata[index]["alamat"],
                              },
                            ),
                          ));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_listdata[index]['npm']),
                          Text(_listdata[index]['alamat']),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  content: Text("Hapus data ini?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _delete(_listdata[index]['npm'])
                                              .then((value) {
                                            if (value) {
                                              final snackBar = SnackBar(
                                                  content: const Text(
                                                      "Data Berhasil di Hapus"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                  content: const Text(
                                                      "Data Gagal di Hapus"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          });
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage(),
                                              ),
                                              (route) => false);
                                        },
                                        child: Text("Ya")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Tidak"))
                                  ],
                                );
                              }));
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahData(),
              ));
        },
      ),
    );
  }
}
