import 'package:alkhudhrah_app/custom_widgets/widget.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width/0.3,
            height: MediaQuery.of(context).size.height/2.4,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.2, 6.0),
                  blurRadius: 6.0,
                  spreadRadius: -2.0
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: Color.fromRGBO(251, 255, 249, 1),
            ),
          ),
          SizedBox(height: 50,),
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: brandName(115.0, 115.0, 20.0),
          ),
          SizedBox(height: 50,),
          Container(
            margin: EdgeInsets.only(top: 300, left: 60),
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Color.fromRGBO(103, 156, 65, 1),),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ksa_flag.jpg'),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                Container(
                  child: Text("+966", style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),),
                ),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      focusColor: Color.fromRGBO(103, 156, 65, 1),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 90, top: 470),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                fixedSize: Size(250.0, 70.0),
                backgroundColor: Color.fromRGBO(103, 156, 65, 1),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login()));
              }, 
              child: Text("SIGN IN", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}