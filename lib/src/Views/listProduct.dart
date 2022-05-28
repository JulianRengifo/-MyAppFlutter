import 'dart:ui';
import 'dart:convert';
import 'package:cosifi/src/Views/menu.dart';
import 'package:cosifi/src/Views/order.dart';
import 'package:cosifi/src/Views/viewProduct.dart';
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

class PageListProducts extends StatefulWidget {
  const PageListProducts({
    Key? key,
  }) : super(key: key);

  @override
  _StateListProducts createState() => _StateListProducts();
}

class _StateListProducts extends AuthState<PageListProducts>
    with SingleTickerProviderStateMixin {
  // Nombre del producto que se desea buscar
  String search = '%';
  // Contador para los productos seleccionados
  int countSelected = 0;

  var datasets = <String, dynamic>{};
  // Id del restaurante que se desea ver el menu
  String idRestaurant = globals.idRestaurant;
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
                            margin: EdgeInsets.zero,
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
                                hintText: r'''Nombre de  Producto''',
                                contentPadding: const EdgeInsets.only(
                                  left: 5,
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
                        .from('products')
                        .select('id_restaurant, name, description, value, img')
                        .eq('id_restaurant', idRestaurant)
                        .order('name')
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
                                  children: [
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      width: 150,
                                      height: 100,
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
                                          await Navigator.push<void>(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PageViewProduct(
                                                img: this
                                                    .datasets[
                                                        'Supabase future builder']
                                                        [index]['img']
                                                    .toString(),
                                                description: this
                                                    .datasets[
                                                        'Supabase future builder']
                                                        [index]['description']
                                                    .toString(),
                                                name: this
                                                    .datasets[
                                                        'Supabase future builder']
                                                        [index]['name']
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        onDoubleTap: () async {},
                                        onLongPress: () async {},
                                        child: Hero(
                                          tag: 'tutorial',
                                          child: Image.network(
                                            this
                                                .datasets[
                                                    'Supabase future builder']
                                                    [index]['img']
                                                .toString(),
                                            width: double.maxFinite,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      width: 190,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        border: Border(
                                          left: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFFFFF)),
                                          top: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFFFFF)),
                                          right: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFFFFF)),
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFFFFF)),
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
                                                      const Color(0xFF000000),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              maxLines: 2),
                                          Text(
                                              this
                                                  .datasets[
                                                      'Supabase future builder']
                                                      [index]['description']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  color:
                                                      const Color(0xFF000000),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.normal,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              maxLines: 2),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (countSelected != null) {
                                                    setState(() {
                                                      countSelected =
                                                          countSelected + 1;
                                                    });
                                                  }
                                                  final response =
                                                      await Supabase
                                                          .instance.client
                                                          .from("orders")
                                                          .insert(
                                                    {
                                                      '''id_user''':
                                                          '''$email''',
                                                      '''count''': "1",
                                                      '''name''': this
                                                          .datasets[
                                                              'Supabase future builder']
                                                              [index]['name']
                                                          .toString(),
                                                      '''description''': this
                                                          .datasets[
                                                              'Supabase future builder']
                                                              [index]
                                                              ['description']
                                                          .toString(),
                                                      '''value''': this
                                                          .datasets[
                                                              'Supabase future builder']
                                                              [index]['value']
                                                          .toString(),
                                                      '''img''': this
                                                          .datasets[
                                                              'Supabase future builder']
                                                              [index]['img']
                                                          .toString(),
                                                    },
                                                    returning:
                                                        ReturningOption.minimal,
                                                  ).execute();
                                                  if (response.error != null) {
                                                    setState(() {});
                                                  } else {}
                                                },
                                                onLongPress: () async {},
                                                child: Container(
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFF003C),
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
                                                    'Comprar',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        color: const Color(
                                                            0xFFFFFFFF),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  left: 25,
                                                ),
                                                padding: EdgeInsets.zero,
                                                width: double.maxFinite,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF000000),
                                                  border: Border(
                                                    left: BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                        color:
                                                            Color(0xFF000000)),
                                                    top: BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                        color:
                                                            Color(0xFF000000)),
                                                    right: BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                        color:
                                                            Color(0xFF000000)),
                                                    bottom: BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                        color:
                                                            Color(0xFF000000)),
                                                  ),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(r'''$ ''',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            color: const Color(
                                                                0xFFFF0000),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        maxLines: 1),
                                                    Text(
                                                        this
                                                            .datasets[
                                                                'Supabase future builder']
                                                                [index]['value']
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            color: const Color(
                                                                0xFFFF0000),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        maxLines: 1),
                                                  ],
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
          // BottomBar
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                width: double.maxFinite,
                height: 50,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: 220,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCE30),
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
                      child: TextButton(
                        onPressed: () async {
                          await Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageMyOrder(),
                            ),
                          );
                        },
                        onLongPress: () async {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r'''Mi Orden''',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                maxLines: 1),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 2,
                              ),
                              padding: const EdgeInsets.only(
                                left: 3,
                                right: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEDB3),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
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
                              child: Text('$countSelected',
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
                                  maxLines: 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
