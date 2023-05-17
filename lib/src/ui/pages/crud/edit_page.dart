import 'package:flutter/material.dart';
import 'package:enreda_example/src/data/firebase/firebase_service.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditPage({Key? key, required this.data}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    nameController.text = widget.data['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la modificación',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //Navigator.pop(context);

                await updatePeople(widget.data['uid'], nameController.text)
                    .then((_) => Navigator.pop(context));
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
