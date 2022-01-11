import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registration/Sheet/form.dart';
import 'package:registration/Sheet/controller.dart';


void main() => runApp(MaterialApp(
  home: Registration(),
));

class Registration extends StatefulWidget{
  @override
  _Registration createState()=>_Registration();
}

class _Registration extends State<Registration> {

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = new TextEditingController();
  String date,time;

  void _submitForm() {

    date = DateFormat.yMMMd().format(DateTime.now());
    time = DateFormat.jm().format(DateTime.now());
    if (_formKey.currentState.validate()) {
      Register register = Register(nameController.text, mobileNoController.text, emailController.text,date,time);

      Controller formController = Controller();

      formController.submitForm(register, (String response) {
        setState(() {
          nameController.text="";
          mobileNoController.text="";
          emailController.text="";
        });
        print("Response: ${response}");
        if (response == Controller.STATUS_SUCCESS) {
          showSnackbar("Registered Successfully");

        } else {
          showSnackbar("Error Occurred!");
        }
      });
    }
  }

  void showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration App"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child:
                Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Name'
                        ),
                      ),
                      TextFormField(
                        controller: mobileNoController,
                        validator: (value) {
                          if (value.trim().length != 10) {
                            return 'Enter 10 Digit Mobile Number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (!value.contains("@")) {
                            return 'Enter Valid Email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email'
                        ),
                      ),
                    ],
                  ),
                )
            ),
            RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Register'),
            ),
          ],
        ),
      )
    );
  }
}
