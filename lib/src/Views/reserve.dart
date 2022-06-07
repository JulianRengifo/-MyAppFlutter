import 'dart:ui';
import 'dart:convert';
import 'package:cosifi/src/Views/listStores.dart';
import 'package:cosifi/src/Views/menu.dart';
import 'package:cosifi/src/Views/resume.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cosifi/src/auth/auth_state.dart';

import 'package:intl/intl.dart' hide TextDirection;
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map/map.dart' hide Map;
import 'package:latlng/latlng.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:cosifi/globals.dart' as globals;

class PageReserve extends StatefulWidget {
  const PageReserve({
    Key? key,
  }) : super(key: key);

  @override
  _StateReserve createState() => _StateReserve();
}

class _StateReserve extends AuthState<PageReserve>
    with SingleTickerProviderStateMixin {
  // Date Selected
  String date = '';
  String time = '';

  var datasets = <String, dynamic>{};
  // Email del usuario que ingreso
  String email = globals.email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
            right: 16,
          ),
          width: double.maxFinite,
          height: 65,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              left: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFF000000)),
              top: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFF000000)),
              right: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFF000000)),
              bottom: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFF000000)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  await Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageMenu(),
                    ),
                  );
                },
                onLongPress: () async {},
                child: Icon(
                  MdiIcons.fromString('microsoft-xbox-controller-menu'),
                  size: 48,
                  color: Color(0xFF000000),
                ),
              ),
              Icon(
                MdiIcons.fromString('account-circle'),
                size: 48,
                color: Color(0xFF000000),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(
                left: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000)),
                top: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000)),
                right: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000)),
                bottom: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: double.maxFinite,
                  height: 600,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border(
                      left: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                          color: Color(0xFF000000)),
                      top: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                          color: Color(0xFF000000)),
                      right: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                          color: Color(0xFF000000)),
                      bottom: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                          color: Color(0xFF000000)),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(r'''Elije la Fecha''',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          maxLines: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              border: Border(
                                left: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFF000000)),
                                top: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFF000000)),
                                right: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFF000000)),
                                bottom: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFF000000)),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 16,
                                top: 8,
                                right: 16,
                                bottom: 8,
                              ),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                border: null,
                              ),
                              child: TextField(
                                onChanged: (String value) async {
                                  setState(() {
                                    date = '''$value''';
                                  });
                                },
                                onSubmitted: (String value) async {},
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  hintText: r'''YYYY/MM/DD''',
                                  contentPadding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                                minLines: 1,
                                maxLength: null,
                                obscureText: false,
                                showCursor: true,
                                autocorrect: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              border: Border(
                                left: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFFFFFFFF)),
                                top: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFFFFFFFF)),
                                right: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFFFFFFFF)),
                                bottom: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 16,
                                top: 8,
                                right: 16,
                                bottom: 8,
                              ),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                border: null,
                              ),
                              child: TextField(
                                onChanged: (String value) async {
                                  setState(() {
                                    time = value;
                                  });
                                },
                                onSubmitted: (String value) async {},
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  hintText: r'''HH:MM''',
                                  contentPadding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                                minLines: 1,
                                maxLength: null,
                                obscureText: false,
                                showCursor: true,
                                autocorrect: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border(
                            left: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                color: Color(0xFF000000)),
                            top: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                color: Color(0xFF000000)),
                            right: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                color: Color(0xFF000000)),
                            bottom: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                color: Color(0xFF000000)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                border: Border(
                                  left: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                  top: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                  right: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                  bottom: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  final response = await Supabase
                                      .instance.client
                                      .from("reserves")
                                      .insert(
                                    {
                                      '''id_user''': '''${email}''',
                                      '''date''': '''${date}''',
                                      '''reserved''': "false",
                                      '''time''': '''${time}''',
                                    },
                                    returning: ReturningOption.minimal,
                                  ).execute();
                                  if (response != null) {
                                    final response = await Supabase
                                        .instance.client
                                        .from("orders")
                                        .update({"activated": false})
                                        .eq("id_user", email)
                                        .execute();
                                    if (response != null) {
                                      print("Ordenes Eliminadas");
                                      print(
                                          "Reserva para reclamar en el resutaurante");
                                      await Navigator.push<void>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PageResume(),
                                        ),
                                      );
                                    } else {
                                      print("No se pudo eliminar las ordenes");
                                    }
                                  } else {
                                    print("No se puede hacer la reserva");
                                  }
                                },
                                onLongPress: () async {},
                                child: Container(
                                  width: double.maxFinite,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00C9A7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    border: null,
                                  ),
                                  child: Text(
                                    'Recoger',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                border: Border(
                                  left: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                  top: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                  right: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                  bottom: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                      color: Color(0xFF000000)),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  final response = await Supabase
                                      .instance.client
                                      .from("reserves")
                                      .insert(
                                    {
                                      '''id_user''': '''${email}''',
                                      '''date''': '''${date}''',
                                      '''reserved''': "true",
                                      '''time''': '''${time}''',
                                    },
                                    returning: ReturningOption.minimal,
                                  ).execute();
                                  if (response != null) {
                                    final response = await Supabase
                                        .instance.client
                                        .from("orders")
                                        .update({"activated": false})
                                        .eq("id_user", email)
                                        .execute();
                                    if (response != null) {
                                      print("Ordenes Eliminadas");
                                      print(
                                          "Reserva de mesa en el resutaurante");
                                      await Navigator.push<void>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PageListStore(),
                                        ),
                                      );
                                    } else {
                                      print("No se pudo eliminar las ordenes");
                                    }
                                  } else {
                                    print("No se puede hacer la reserva");
                                  }
                                },
                                onLongPress: () async {},
                                child: Container(
                                  width: double.maxFinite,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF845EC2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    border: null,
                                  ),
                                  child: Text(
                                    'Reservar Mesa',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
