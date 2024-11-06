// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../main.dart';
import '../sql_helper.dart';
import '../model/computadora.dart';

class MyHomePageState extends State<MyHomePage> {
  //Initialize the text fields for the operations
  int id = 0;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _procesadorController = TextEditingController();
  final TextEditingController _discoDuroController = TextEditingController();
  final TextEditingController _ramController = TextEditingController();

  List<Computadora> _journals = []; // Save the Computadoras data
  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshComputadoraLists() async {
    final data = await SQLHelper.getAllComputadoras();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  // Loading the data when the app starts
  @override
  void initState() {
    super.initState();
    _refreshComputadoraLists(); // Loading the data when the app starts
  }

//Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _listTitle(), _ComputadoraList()],
        ),
      ),
    );
  }

  //other state properties and Start Form filling
  final _formKey = GlobalKey<FormState>();

  _form() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                      labelText: 'Modelo', prefixIcon: Icon(Icons.computer)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el modelo';
                    }
                  }),
              TextFormField(
                  controller: _procesadorController,
                  decoration: const InputDecoration(
                      labelText: 'Procesador',
                      prefixIcon: Icon(Icons.data_usage_sharp)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre del procesador';
                    }
                  }),
              TextFormField(
                  controller: _discoDuroController,
                  decoration: const InputDecoration(
                      labelText: 'Disco Duro', prefixIcon: Icon(Icons.storage)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa la capacidad del disco duro';
                    }
                  }),
              TextFormField(
                  controller: _ramController,
                  decoration: const InputDecoration(
                      labelText: 'RAM', prefixIcon: Icon(Icons.memory_rounded)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa la capacidad del disco duro';
                    }
                  }),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    // Save new journal
                    if (_formKey.currentState!.validate()) {
                      if (id == 0) {
                        _addItem();
                      } else {
                        _updateItem(id);
                        id = 0;
                      }
                    }

                    // Clear the text fields
                    _nombreController.text = '';
                    _procesadorController.text = '';
                    _discoDuroController.text = '';
                    _ramController.text = '';
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      );

//Computadora list title display here
  _listTitle() => Container(
      //apply margin and padding using Container Widget.
      padding: const EdgeInsets.all(10), //You can use EdgeInsets like above
      margin: const EdgeInsets.all(0),
      child: const Text('Computadora list display here',
          style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.bold,
              fontSize: 20)));

//Computadora list goes here
  _ComputadoraList() => Expanded(
        child: Card(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          shape: const RoundedRectangleBorder(
            //<-- SEE HERE
            side: BorderSide(
              color: Colors.grey,
            ),
          ),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                //List view title
                if (index == 0) {
                  return Column(
                    // The header
                    children: <Widget>[
                      const ListTile(
                        leading: Text(
                          'ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          'Model',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Text(
                                '  Edit       ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      _listItemDisplay(index)
                    ],
                  );
                }

                return Column(
                  children: <Widget>[
                    _listItemDisplay(index),
                    const Divider(
                      height: 10.0,
                    ),
                  ],
                );
              },
              itemCount: _journals.length,
            ),
          ),
        ),
      );

  // Item of the ListView
  Widget _listItemDisplay(index) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black26))),
      child: ListTile(
        leading: Text(
          _journals[index].id.toString(),
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: darkBlueColor, fontWeight: FontWeight.bold),
        ),
        title: Text(
          "${_journals[index].nombre}})",
          style: const TextStyle(
              color: darkBlueColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Text(_journals[index].procesador.toString()),
            const VerticalDivider(
              width: 20, // Espacio total ocupado por el separador
              thickness: 2, // Grosor de la línea
              color: Colors.grey, // Color de la línea
            ),
            Text(_journals[index].discoDuro.toString()),
          ],
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    //update the details
                    _nombreController.text = _journals[index].nombre.toString();
                    _procesadorController.text =
                        _journals[index].procesador.toString();
                    _discoDuroController.text =
                        _journals[index].discoDuro.toString();
                    id = int.parse(_journals[index].id.toString());
                    _ramController.text = _journals[index].ram.toString();
                  }),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    _deleteItem(int.parse(_journals[index].id.toString())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Insert a new Computadora to the database
  Future<void> _addItem() async {
    Computadora computadora = Computadora(
        nombre: _nombreController.text,
        procesador: _procesadorController.text,
        discoDuro: _discoDuroController.text,
        ram: _ramController.text);

    await SQLHelper.insert(computadora);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully added a record!'),
    ));

    _refreshComputadoraLists();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.update(
        id,
        _nombreController.text,
        _procesadorController.text,
        _discoDuroController.text,
        _ramController.text);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully updated a record!'),
    ));

    //Refresh the Computadora list
    _refreshComputadoraLists();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteComputadora(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));

    //Refresh the Computadora list
    _refreshComputadoraLists();
  }
}
