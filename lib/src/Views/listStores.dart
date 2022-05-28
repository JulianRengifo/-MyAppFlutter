import 'dart:ui';
import 'dart:convert';
import 'package:cosifi/src/Views/listProduct.dart';
import 'package:cosifi/src/Views/menu.dart';
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

class PageListStore extends StatefulWidget {
  const PageListStore({
    Key? key,
  }) : super(key: key);

  @override
  _StateListStore createState() => _StateListStore();
}

class _StateListStore extends AuthState<PageListStore>
    with SingleTickerProviderStateMixin {
  String search = '%';

  var datasets = <String, dynamic>{};
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
            width: MediaQuery.of(context).size.width * (100 / 100),
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
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
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
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      right: 5,
                      bottom: 5,
                    ),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
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
                      children: [
                        Icon(
                          MdiIcons.fromString('text-search'),
                          size: 35,
                          color: Color(0xFF515151),
                        ),
                        Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Color(0xFF000000),
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
                              left: 5,
                            ),
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              border: null,
                            ),
                            child: TextField(
                              onChanged: (String value) async {},
                              onSubmitted: (String value) async {},
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                                hintText: r'''Nombre de Restaurante''',
                                contentPadding: EdgeInsets.zero,
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
                  ),
                ),
                FutureBuilder(
                    future: Supabase.instance.client
                        .from('stores')
                        .select(
                            'id, name, category, logo, start_schedule, end_schedule')
                        .order('name')
                        .range((1 * 0) - 1, 1 * 100)
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
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: this
                                        .datasets['Supabase future builder']
                                        .length >
                                    0
                                ? this
                                    .datasets['Supabase future builder']
                                    .length
                                : 0,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                padding: EdgeInsets.zero,
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF000000),
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
                                  children: [
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      width: 150,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF000000),
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
                                      child: Image.network(
                                        this
                                            .datasets['Supabase future builder']
                                                [index]['logo']
                                            .toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (100 / 100),
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.only(
                                        left: 5,
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              this
                                                  .datasets[
                                                      'Supabase future builder']
                                                      [index]['name']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              maxLines: 1),
                                          Text(
                                              this
                                                  .datasets[
                                                      'Supabase future builder']
                                                      [index]['category']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              maxLines: 1),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  this
                                                      .datasets[
                                                          'Supabase future builder']
                                                          [index]
                                                          ['start_schedule']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      color: const Color(
                                                          0xFF00C9A7),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  maxLines: 1),
                                              Text(r''' - ''',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  maxLines: 1),
                                              Text(
                                                  this
                                                      .datasets[
                                                          'Supabase future builder']
                                                          [index]
                                                          ['end_schedule']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      color: const Color(
                                                          0xFFFF6F91),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  maxLines: 1),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    print(
                                                        "****************************************");
                                                    print(this
                                                        .datasets[
                                                            'Supabase future builder']
                                                            [index]['id']
                                                        .toString());
                                                    print(globals.idRestaurant);
                                                    print(
                                                        "****************************************");
                                                    globals.idRestaurant = this
                                                        .datasets[
                                                            'Supabase future builder']
                                                            [index]['id']
                                                        .toString();
                                                    await Navigator.push<void>(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PageListProducts(),
                                                      ),
                                                    );
                                                  },
                                                  onLongPress: () async {},
                                                  child: Container(
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFFFCE30),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                      ),
                                                      border: null,
                                                    ),
                                                    child: Text(
                                                      'Ver Menu',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                          color: const Color(
                                                              0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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

                      ;
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
