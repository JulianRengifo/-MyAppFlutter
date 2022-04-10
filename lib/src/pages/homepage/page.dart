import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/auth/auth_required_state.dart';

import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:myapp/src/pages/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

class PageHomePage extends StatefulWidget {
  const PageHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends AuthRequiredState<PageHomePage>
    with SingleTickerProviderStateMixin {
  final datasets = <String, dynamic>{};

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
          padding: EdgeInsets.zero,
          width: double.maxFinite,
          height: 65,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              left: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFFFFFFFF)),
              top: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFFFFFFFF)),
              right: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFFFFFFFF)),
              bottom: BorderSide(
                  width: 0, style: BorderStyle.none, color: Color(0xFFFFFFFF)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  MdiIcons.fromString('microsoft-xbox-controller-menu'),
                  size: 48,
                  color: Color(0xFF000000),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageEditProfile(),
                      ),
                    );
                  },
                  child: Icon(
                    MdiIcons.fromString('account-circle'),
                    size: 48,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              right: 16,
            ),
            width: 320,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(
                left: BorderSide(width: 0, color: Color(0xFF000000)),
                top: BorderSide(width: 0, color: Color(0xFF000000)),
                right: BorderSide(width: 0, color: Color(0xFF000000)),
                bottom: BorderSide(width: 0, color: Color(0xFF000000)),
              ),
            ),
            child: FutureBuilder(
                future: Supabase.instance.client
                    .from('products')
                    .select('id, name, description, value, img')
                    .execute(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final doc = snapshot.data as PostgrestResponse?;
                  if (doc == null) return const SizedBox();

                  final datasets = this.datasets;
                  datasets['Supabase future builder'] =
                      doc.data as List<dynamic>? ?? <dynamic>[];
                  const index = 0;

                  return Builder(
                    builder: (context) {
                      print("#########################");
                      print((datasets['Supabase future builder']
                          as List<dynamic>)[index]['img']);
                      print((datasets['Supabase future builder']
                          as List<dynamic>)[index]['name']);
                      print((datasets['Supabase future builder']
                          as List<dynamic>)[index]['description']);
                      print((datasets['Supabase future builder']
                          as List<dynamic>)[index]['value']);
                      print((datasets['Supabase future builder']
                              as List<dynamic>)[index]['value']
                          .runtimeType);

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            datasets.keys.contains('Supabase future builder')
                                ? (datasets['Supabase future builder']
                                        as List<dynamic>)
                                    .length
                                : 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  (datasets['Supabase future builder']
                                      as List<dynamic>)[index]['img'],
                                  width: 140,
                                  fit: BoxFit.fitWidth,
                                ),
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  width: MediaQuery.of(context).size.width *
                                      (100 / 100),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          (datasets['Supabase future builder']
                                              as List<dynamic>)[index]['name'],
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: const Color(0xFF000000),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          textAlign: TextAlign.left,
                                          maxLines: 1),
                                      Text(
                                          (datasets['Supabase future builder']
                                                      as List<dynamic>)[index]
                                                  ['description'] as String? ??
                                              '',
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
                                          maxLines: 3),
                                      TextButton(
                                        onPressed: () async {},
                                        child: SizedBox(
                                          width: 60,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF0000),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16),
                                                bottomLeft: Radius.circular(16),
                                              ),
                                              border: null,
                                            ),
                                            child: Text(
                                                (datasets['Supabase future builder']
                                                            as List<dynamic>)[
                                                        index]['value']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.normal,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
