import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appBackgroundDecoration = const BoxDecoration(
  image: DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage("assets/images/background.jpg"),
  ),
);

var textFormFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.only(
    left: 16,
    top: 5,
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(62, 62, 62, 1)),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 0.7,
        color: Color.fromRGBO(62, 62, 62, 1)),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  hintStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 13)),
);

var passwordFormFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.only(
    left: 16,
    top: 5,
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(62, 62, 62, 1)),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 0.7,
        color: Color.fromRGBO(62, 62, 62, 1)),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  hintText: "Password",
  hintStyle: GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 13,
      color: Color.fromARGB(255, 146, 142, 142),
    ),
  ),
);

var buttonDecoration = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(40)),
  gradient: LinearGradient(
    colors: [Color.fromARGB(255, 23, 109, 179), Colors.green],
  ),
  boxShadow: [
    BoxShadow(
      offset: Offset(5, 5),
      blurRadius: 5,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.2),
    ),
    BoxShadow(
      offset: Offset(-5, 5),
      blurRadius: 10,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.2),
    ),
  ],
);

const textStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);
