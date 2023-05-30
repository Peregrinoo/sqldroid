//                                          Deus seja louvado !!!




// ignore_for_file: file_names, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sqldroid/Helpers/InstancesHelper.dart';

class InstanceHeadersConfigure extends StatefulWidget {

  List headers = [];
  List<TextEditingController>  _textControllers = InstancesHelper.getInstance.getTextControllers;

  // ignore: use_key_in_widget_constructors
  InstanceHeadersConfigure(this.headers,this._textControllers);

  @override
  State<InstanceHeadersConfigure> createState() => _InstanceHeadersConfigureState(headers, _textControllers);
}

class _InstanceHeadersConfigureState extends State<InstanceHeadersConfigure> {

  List _headers = [];
  List<TextEditingController>  _textControllers = InstancesHelper.getInstance.getTextControllers;

  _InstanceHeadersConfigureState(this._headers, this._textControllers);

  @override
  void initState() {
    super.initState();
    print("Deus me ajude !!!");
  }


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth  = MediaQuery.of(context).size.width;


    _removeColumn(int index, String column) {

      return showDialog(context: context, builder: (context) {

        return AlertDialog(
          title: Text("Delete $column ? "),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent)
                ),
                onPressed: () {

              setState(() {
                InstancesHelper.getInstance.headersRemoveValue(index);
              });
              Navigator.pop(context);
            }, child: const Text("Delete"))
          ],
        );

      });

    }

    // ignore: no_leading_underscores_for_local_identifiers
    _setPrimaryKey(int index) {
      if(index == 0) {
          if(!InstancesHelper.getInstance.getPrimaryKey) {
            setState(() {
              _headers[index]["title"] = "${_headers[index]["title"]}_ID";
              InstancesHelper.getInstance.setPrimaryKey();
            });
          } else {
            return showDialog(context: context, builder: (context) {
              return const AlertDialog(
                title: Text("The primary key already defined"),
                content: Text(""),
              );
            });
          }
      } else {
        return showDialog(context: context, builder: (context) {

          return const AlertDialog(
            title: Text("Primary key"),
            content: Text("You cannot make this a primary key, because the primary key must be the frist column"),
          );

        });
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    _editColumn(int index) {

      return showDialog(context: context, builder: (context) {

        return AlertDialog(
          title: Text("Editing ${_headers[index]["title"]}"),

          content: TextField(
            controller: _textControllers[index],
            decoration: InputDecoration(
              hintText: _headers[index]["title"],
            ),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all<Color?>(Colors.deepPurpleAccent)
                ),
                onPressed: () {
                  InstancesHelper.getInstance.headersSetValue(index, _textControllers[index].text);
                  Navigator.pop(context);
            },child: const Text("Update name",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            ),))
          ],
        );

      });

    }

    // ignore: no_leading_underscores_for_local_identifiers
    Icon? _starToPrimary(int index) {
      return index == 0 ? const Icon(
        Icons.star,
        color: Colors.yellow
      ) : null;
    }

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Configure Headers",
          style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,

      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(padding: const EdgeInsets.only(right: 25, left: 25),
            child: Column(
                children: [
                  const SizedBox(height: 25),
                  const Text("Edit the column names of your database",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _textControllers.length,
                      itemBuilder: (context, index) {

                        return Padding(padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
                          child: InkWell(
                            onTap: () async{
                              print("Deus bendito seja !!!");
                              final newColumnName = await _editColumn(index);
                              print("Deus louvado seja para toda eternidade amém !!! $newColumnName");

                            },
                            onLongPress: () async{
                              await _removeColumn(index, _headers[index]["title"].toString());
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              },

                            onDoubleTap: () async{
                              print("Deus bentido seja !!!");
                              print("Deus me perdoe !!! ");
                              await _setPrimaryKey(index);
                              },

                            child: Card(
                              elevation: 20,
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: deviceHeight * 0.0625,
                                child: Padding(padding: const EdgeInsets.only(right: 10,left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text(
                                      "Edit ${_headers[index]["title"].toString()}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),),

                                    //Icon(Icons.star, color: Colors.yellow,)
                                    SizedBox(

                                      width: 64,
                                      height: 64,
                                      child: _starToPrimary(index),

                                    ),

                                      SizedBox(width: deviceWidth * 0.0625),
                                      const Icon(Icons.chevron_right),

                                  ],),
                                ),




                              ),


                            ),
                          ),
                        );

                      }),
                  const SizedBox(height: 30),
                  ElevatedButton(onPressed: () {

                    setState(() {
                      _textControllers.add(TextEditingController());
                      InstancesHelper.getInstance.headersAddValue("New column");
                    });

                  }, child: const Text("Add header"))



                ]),
          ),
        ),
      )

    );
  }
}



