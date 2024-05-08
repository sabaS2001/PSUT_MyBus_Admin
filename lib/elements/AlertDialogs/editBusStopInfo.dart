import 'package:flutter/material.dart';

class EditBusStop extends StatefulWidget {
  @override
  _EditBusStopState createState() => _EditBusStopState();
}

class _EditBusStopState extends State<EditBusStop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (BuildContext context) {
            return AlertDialog(
              shadowColor:
              Colors.blue[900],
              backgroundColor:
              Colors.white,
              title: const Center(
                child: Text(
                    'Bus Stop Information:',
                    style: TextStyle(
                      fontFamily:
                      'Wellfleet',
                      fontSize: 20.0,
                      color: Colors
                          .black,
                    )),
              ),
              content: SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .center,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceAround,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Text(
                              'Bus Stop Name: ',
                              style: TextStyle(
                                  fontFamily:
                                  'Wellfleet',
                                  fontSize:
                                  16.0)),
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      Colors.grey,
                                      width:
                                      2.0,
                                    )),
                              ),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily:
                                'Wellfleet',
                                fontSize:
                                16.0,
                                color:
                                Colors.black,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Text(
                              'Location: ',
                              style: TextStyle(
                                  fontFamily:
                                  'Wellfleet',
                                  fontSize:
                                  16.0)),
                        ),
                        SizedBox(
                          width: 90,
                          height: 30,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                hintText:'Latitude',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      Colors.grey,
                                      width:
                                      2.0,
                                    )),
                              ),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily:
                                'Wellfleet',
                                fontSize:
                                16.0,
                                color:
                                Colors.black,
                              )),
                        ),
                        const SizedBox(width: 10.0,),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                hintText:'Longitude',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      Colors.grey,
                                      width:
                                      2.0,
                                    )),
                              ),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily:
                                'Wellfleet',
                                fontSize:
                                16.0,
                                color:
                                Colors.black,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Text(
                              'Arrival Time (Route 1): ',
                              style: TextStyle(
                                  fontFamily:
                                  'Wellfleet',
                                  fontSize:
                                  16.0)),
                        ),

                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      Colors.grey,
                                      width:
                                      2.0,
                                    )),
                              ),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily:
                                'Wellfleet',
                                fontSize:
                                16.0,
                                color:
                                Colors.black,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Text(
                              'Arrival Time (Route 2): ',
                              style: TextStyle(
                                  fontFamily:
                                  'Wellfleet',
                                  fontSize:
                                  16.0)),
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      Colors.grey,
                                      width:
                                      2.0,
                                    )),
                              ),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily:
                                'Wellfleet',
                                fontSize:
                                16.0,
                                color:
                                Colors.black,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Text(
                              'Bus Number:',
                              style: TextStyle(
                                  fontFamily:
                                  'Wellfleet',
                                  fontSize:
                                  16.0)),
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      Colors.grey,
                                      width:
                                      2.0,
                                    )),
                              ),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily:
                                'Wellfleet',
                                fontSize:
                                16.0,
                                color:
                                Colors.black,
                              )),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    child: const Text(
                        'SAVE',
                        style:
                        TextStyle(
                          fontFamily:
                          'Wellfleet',
                          fontSize:
                          15.0,
                          color: Colors
                              .black,
                        )),
                    onPressed:
                        () {

                    }
                ),
                ElevatedButton(
                  child: const Text(
                      'CANCEL',
                      style:
                      TextStyle(
                        fontFamily:
                        'Wellfleet',
                        fontSize:
                        15.0,
                        color: Colors
                            .black,
                      )),
                  onPressed: () {
                    Navigator.of(
                        context)
                        .pop();
                  },
                ),
              ],
            );
          },
        );
      },
      style: ButtonStyle(
        backgroundColor:
        WidgetStatePropertyAll(
            Colors.blue.shade900),
      ),
      child: const Row(
        children: [
          Icon(Icons.edit,
              color: Colors.white),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'Edit Bus Stop',
            style: TextStyle(
                color: Colors.white,
                fontFamily:
                'Wellfleet',
                fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}