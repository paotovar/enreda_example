import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enreda_example/src/ui/pages/home/home_controller.dart';
import 'package:enreda_example/src/data/firebase/firebase_service.dart';
import 'package:enreda_example/src/ui/pages/crud/create_page.dart';
import 'package:enreda_example/src/ui/pages/crud/edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text('Cerrar sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enreda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                // return Text(snapshot.data?[index]['name'] ?? '');
                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direccion) async {
                    bool result = false;

                    result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text(
                                  "¿Está seguro de eliminar a ${snapshot.data?[index]['name']} ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    return Navigator.pop(
                                      context,
                                      false,
                                    );
                                  },
                                  child: const Text("Cancelar",
                                      style: TextStyle(color: Colors.red)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    return Navigator.pop(
                                      context,
                                      true,
                                    );
                                  },
                                  child: const Text("Si,estoy seguro"),
                                )
                              ]);
                        });

                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(
                            data: {
                              "name": snapshot.data?[index]['name'] ?? '',
                              "uid": snapshot.data?[index]['uid'] ?? '',
                            },
                          ),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
