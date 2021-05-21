
import 'package:flutter/material.dart';

Widget textFieldok(Function function, String text, TextEditingController controller){
  return Container(
    margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
    constraints: BoxConstraints(
      minWidth: 100,
      maxHeight: 40,
      //maxHeight: double.infinity
    ),
    decoration: BoxDecoration(
        color: Colors.grey[200]
    ),
    child: TextField(
      controller: controller,
      onChanged: function,
      minLines: 1,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
          labelStyle: TextStyle(
              fontSize: 13
          )
      ),
    ),
  );
}