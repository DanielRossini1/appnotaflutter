import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isChecked = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controlRA = TextEditingController();
  TextEditingController _controlSenha = TextEditingController();

  String _hintInputSenha = "Senha";
  String _hintInputRA = "RA";

  Color _hintColorSenha = Colors.white;
  Color _hintColorRA = Colors.white;

  Color _iconColorSenha = Colors.white;
  Color _iconColorRA = Colors.white;

  Future _getCookie() async {
    http.Response res;

    res = await http.post(
      "https://22561fb4.ngrok.io/api/getcookie",
      body: {"ra": _controlRA.text, "senha": _controlSenha.text},
    );

    if (res.body != '') {
      print(res.body);
    } else {
      print('Ta vazio carai');
    }
  }

  Future<File> _getDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  // Future<File> _validationChecked() async{
  //   if(_isChecked){
  //     final file = await _getDirectory();
  //     String data = json.encode({ "ra": _controlRA.text,  "senha": _controlSenha.text, "checked": true });
  //     return file.writeAsString(data);
  //   }
  //   return;
  // }

  void _validationInput() {
    if (_controlRA.text == '' || _controlSenha.text == '') {
      setState(() {
        if (_controlRA.text == '') {
          _iconColorRA = Colors.red;
          _hintColorRA = Colors.red;
          _hintInputRA = "Insira seu RA";
        }
        if (_controlSenha.text == '') {
          _iconColorSenha = Colors.red;
          _hintColorSenha = Colors.red;
          _hintInputSenha = "Insira sua senha";
        }
      });
      return;
    }
    _getCookie();
  }

  void _changeInputRA(String text) {
    setState(() {
      if (_iconColorRA == Colors.red) {
        _iconColorRA = Colors.white;
        _hintColorRA = Colors.white;
        _hintInputRA = "RA";
      }
    });
  }

  void _changeInputSenha(String text) {
    setState(() {
      if (_iconColorSenha == Colors.red) {
        _iconColorSenha = Colors.white;
        _hintColorSenha = Colors.white;
        _hintInputSenha = "Senha";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: FutureBuilder(
            future: _getCookie(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                  } else {
                    return FormLogin();
                  }
              }
            }),
      ),
    );
  }
}

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

// Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Image.asset(
//             "images/background.jpg",
//             fit: BoxFit.cover,
//             height: 1000.0,
//             width: 1000.0,
//           ),
//           Container(
//             color: Color.fromARGB(175, 50, 50, 150),
//           ),
//           SingleChildScrollView(
//             padding: EdgeInsets.only(right: 30.0, left: 30.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 30.0),
//                     child: SvgPicture.asset(
//                       'images/graduation.svg',
//                       height: 180.0,
//                     ),
//                   ),
//                   InputText(
//                     hintText: _hintInputRA,
//                     isNumber: true,
//                     controller: _controlRA,
//                     hintColor: _hintColorRA,
//                     iconColor: _iconColorRA,
//                     changeInput: _changeInputRA,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
//                     child: InputText(
//                       hintText: _hintInputSenha,
//                       isPassword: true,
//                       controller: _controlSenha,
//                       hintColor: _hintColorSenha,
//                       iconColor: _iconColorSenha,
//                       changeInput: _changeInputSenha,
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       IconButton(
//                         padding: EdgeInsets.all(0.0),
//                         icon: _isChecked
//                             ? Icon(
//                                 Icons.check_box_outline_blank,
//                                 color: Theme.of(context).primaryColor,
//                               )
//                             : Icon(
//                                 Icons.check_box,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                         onPressed: () {
//                           setState(() {
//                             _isChecked = !_isChecked;
//                           });
//                         },
//                       ),
//                       Expanded(
//                         child: Text(
//                           "Salvar RA e senha?",
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: SizedBox(
//                       height: 55.0,
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50.0)
//                         ),
//                         child: Text(
//                           "LOGIN",
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.indigo[900],
//                           ),
//                         ),
//                         color: Theme.of(context).primaryColor,
//                         onPressed: _validationInput,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );



class InputText extends StatelessWidget {
  final String hintText;
  final bool isNumber;
  final bool isPassword;
  final TextEditingController controller;
  final Color hintColor;
  final Color iconColor;
  final Function changeInput;

  InputText(
      {this.hintText,
      this.isNumber = false,
      this.isPassword = false,
      this.controller,
      this.hintColor,
      this.iconColor,
      this.changeInput});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(230, 50, 50, 150),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            child: Icon(
              hintText == "RA" || hintText == "Insira seu RA"
                  ? Icons.person
                  : Icons.lock,
              color: iconColor,
              size: 20.0,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: changeInput,
              controller: controller,
              obscureText: isPassword,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: isNumber ? TextInputType.number : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintColor,
                  fontSize: 18.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
