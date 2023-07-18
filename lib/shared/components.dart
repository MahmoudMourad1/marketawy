
import 'package:flutter/material.dart';

void NavigateTo (context, widget) => Navigator.push(context,
    MaterialPageRoute(builder:(context)=>widget ));

void NavigateAndFinish (context , widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => widget),(route){
  return false;
    });

Widget defaultButton ({
  required double width ,
  required Color background ,
  required String text,
  required Function? function,


  double radius = 0.0
}) => Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed :(){
      function!();
    }  ,
    child: Text( text.toUpperCase() ,
      style: TextStyle(
          color: Colors.white
      ),
    ),

  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius,),
    color: background,


  ),
);
Widget defaultFormField({
  required TextEditingController  controller,
  required TextInputType type,
  final Function? onSubmit,
  final Function? onChange,
  required Function validate,
  required String label,
  required IconData prefix,
  final Function? onTap,
  final IconData? suffix,


}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:(value){
    onSubmit!(value);
  },
  onChanged: (value){
    onChange!(value);
  },
  onTap: (){
    onTap!();
  },
  validator: (value){
    validate(value);
  },
  decoration: InputDecoration(
    labelText: label,

    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: Icon(
      suffix
    ),
    border: OutlineInputBorder(),
  ),


);


