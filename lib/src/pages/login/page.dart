import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/auth/auth_state.dart';
import 'package:auth_buttons/auth_buttons.dart';

import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:myapp/src/pages/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends AuthState<PageLogin> with SingleTickerProviderStateMixin {
  String Email = '0';

  String Password = '0';

  String status = '0';

  final datasets = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                left: BorderSide(width: 0, color: Color(0xFF000000)),
                top: BorderSide(width: 0, color: Color(0xFF000000)),
                right: BorderSide(width: 0, color: Color(0xFF000000)),
                bottom: BorderSide(width: 0, color: Color(0xFF000000)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
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
                  child: Image.asset(
                    '''logo_small.png''',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
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
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    border: null,
                  ),
                  child: TextField(
                    onChanged: (String value) async {
                      setState(() {
                        Email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      hintText: r'''Email''',
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
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    minLines: 1,
                    maxLength: null,
                    obscureText: false,
                    showCursor: true,
                    autocorrect: false,
                  ),
                ),
                Container(
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
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    border: null,
                  ),
                  child: TextField(
                    onChanged: (String value) async {
                      setState(() {
                        Password = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      hintText: r'''Password''',
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
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    minLines: 1,
                    maxLength: null,
                    obscureText: true,
                    showCursor: true,
                    autocorrect: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 8,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (Email != null && Password != null) {
                        print(Email);
                        print(Password);
                        setState(() {
                          status = 'Loading';
                        });
                        final response = await Supabase.instance.client.auth
                            .signIn(email: Email, password: Password);
                        if (response.error != null || response.user == null) {
                          setState(() {
                            status = 'Failed';
                          });
                        } else {
                          setState(() {
                            status = 'Success';
                          });
                          await Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageHomePage(),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3285FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        border: null,
                      ),
                      child: Text(
                        'Ingresa',
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
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r'''Aun no tienes cuenta?''',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1),
                      TextButton(
                        onPressed: () async {
                          await Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageRegister(),
                            ),
                          );
                        },
                        child: Text(r'''Registrate ahora''',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xFFFF0000),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1),
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
