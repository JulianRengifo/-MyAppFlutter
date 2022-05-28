import 'dart:ui';
import 'dart:convert';
import 'package:cosifi/src/Views/listProduct.dart';
import 'package:cosifi/src/Views/menu.dart';
import 'package:cosifi/src/Views/reserve.dart';
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

class PageMyOrder extends StatefulWidget {
  const PageMyOrder({
    Key? key,
  }) : super(key: key);

  @override
  _StateMyOrder createState() => _StateMyOrder();
}

class _StateMyOrder extends AuthState<PageMyOrder>
    with SingleTickerProviderStateMixin {
  var datasets = <String, dynamic>{};
  // Email del usuario que ingreso
  String email = globals.email;

  // calculate total acount
  double total = 0;

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
                FutureBuilder(
                    future: Supabase.instance.client
                        .from('orders')
                        .select('id, count, name, description, value, img')
                        .eq('id_user', email)
                        .eq('activated', true)
                        .order('created_at')
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
                      double temp = 0;
                      datasets['Supabase future builder']
                          .forEach((dynamic product) {
                        temp = temp + product['value'];
                      });
                      globals.totalOrder = temp;

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      width: 150,
                                      height: 100,
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
                                                [index]['img']
                                            .toString(),
                                        width: double.maxFinite,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                      ),
                                      width: 190,
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
                                              maxLines: 1),
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
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              maxLines: 2),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final response = await Supabase
                                                            .instance.client
                                                            .from('orders')
                                                            .update({
                                                              "count": this.datasets[
                                                                              'Supabase future builder']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'count'] -
                                                                  1
                                                            })
                                                            .eq(
                                                                "id",
                                                                this
                                                                    .datasets[
                                                                        'Supabase future builder']
                                                                        [index]
                                                                        ['id']
                                                                    .toString())
                                                            .execute();
                                                        if (response != null) {
                                                          print(
                                                              "Orden Actualizada");
                                                          setState(() {});
                                                        } else {
                                                          print(
                                                              "No se pudo actualizar la orden");
                                                        }
                                                      },
                                                      onLongPress: () async {},
                                                      child: Container(
                                                        width: 28,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFF3285FF),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          border: null,
                                                        ),
                                                        child: Text(
                                                          '<',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              color: const Color(
                                                                  0xFFFFFFFF),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
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
                                                    GestureDetector(
                                                      onTap: () async {},
                                                      onLongPress: () async {},
                                                      child: Container(
                                                        width: 28,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xFF3285FF),
                                                          border: null,
                                                        ),
                                                        child: Text(
                                                          this
                                                              .datasets[
                                                                  'Supabase future builder']
                                                                  [index]
                                                                  ['count']
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              color: const Color(
                                                                  0xFFFFFFFF),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
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
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final response = await Supabase
                                                            .instance.client
                                                            .from('orders')
                                                            .update({
                                                              "count": this.datasets[
                                                                              'Supabase future builder']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'count'] +
                                                                  1
                                                            })
                                                            .eq(
                                                                "id",
                                                                this
                                                                    .datasets[
                                                                        'Supabase future builder']
                                                                        [index]
                                                                        ['id']
                                                                    .toString())
                                                            .execute();
                                                        if (response != null) {
                                                          print(
                                                              "Orden Actualizada");
                                                          setState(() {});
                                                        } else {
                                                          print(
                                                              "No se pudo actualizar la orden");
                                                        }
                                                      },
                                                      onLongPress: () async {},
                                                      child: Container(
                                                        width: 28,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFF3285FF),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          border: null,
                                                        ),
                                                        child: Text(
                                                          '>',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              color: const Color(
                                                                  0xFFFFFFFF),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
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
                                                  ],
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    final response = await Supabase
                                                        .instance.client
                                                        .from("orders")
                                                        .delete()
                                                        .eq(
                                                            "id",
                                                            this
                                                                .datasets[
                                                                    'Supabase future builder']
                                                                    [index]
                                                                    ['id']
                                                                .toString())
                                                        .execute();
                                                    if (response != null) {
                                                      print("Orden Eliminada");
                                                      setState(() {});
                                                    } else {
                                                      print(
                                                          "No se pudo eliminar la orden");
                                                    }
                                                  },
                                                  onLongPress: () async {},
                                                  child: Icon(
                                                    MdiIcons.fromString(
                                                        'delete'),
                                                    size: 24,
                                                    color: Color(0xFFFF0000),
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
                            },
                          );
                        },
                      );

                      ;
                    }),
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
                  child: Divider(
                    height: 10,
                    color: Color(0xFF000000),
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(r'''Total a Pagar: $ ''',
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
                          textDirection: TextDirection.ltr,
                          maxLines: 1),
                      Text('''${globals.totalOrder}''',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          maxLines: 1),
                    ],
                  ),
                ),
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
                height: 60,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageReserve(),
                          ),
                        );
                      },
                      onLongPress: () async {},
                      child: Container(
                        width: 100,
                        height: 40,
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
                          'Reservar',
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
                    GestureDetector(
                      onTap: () async {
                        final response = await Supabase.instance.client
                            .from("orders")
                            .delete()
                            .eq("id_user", email)
                            .eq('activated', true)
                            .execute();
                        if (response != null) {
                          print("Orden Eliminada");
                          await Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageListProducts(),
                            ),
                          );
                        } else {
                          print("No se pudo eliminar la orden");
                        }
                      },
                      onLongPress: () async {},
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          border: null,
                        ),
                        child: Text(
                          'Cancelar',
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
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
