import 'dart:ui';
import 'dart:convert';
import 'package:cosifi/src/Views/listStores.dart';
import 'package:cosifi/src/Views/menu.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cosifi/src/auth/auth_state.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:auth_buttons/auth_buttons.dart';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:latlng/latlng.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:cosifi/globals.dart' as globals;

class PageResume extends StatefulWidget {
  const PageResume({
    Key? key,
  }) : super(key: key);

  @override
  _StateResume createState() => _StateResume();
}

class _StateResume extends AuthState<PageResume>
    with SingleTickerProviderStateMixin {
  String email = globals.email;
  double total = globals.totalOrder;

  var datasets = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r'''Resumen de su Reserva''',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        maxLines: 1),
                  ],
                ),
                Text(
                    r'''Gracias por usar nuestro servicios, RECUERDA que puedes garantizar tu reserva haciendo el pago al siguiente número de Nequi o Daviplata 322 226 0739''',
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
                    maxLines: 4),
                Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.only(
                    top: 8,
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
                  child: FutureBuilder(
                      future: Supabase.instance.client
                          .from('orders')
                          .select('id, name, activated')
                          .eq('id_user', email)
                          .eq('activated', false)
                          .eq('confirmed', false)
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
                                return Row(
                                  children: [
                                    Icon(
                                      MdiIcons.fromString('check-circle'),
                                      size: 32,
                                      color: Color(0xFF00C9A7),
                                    ),
                                    Text(
                                        this
                                                .datasets[
                                                    'Supabase future builder']
                                                    ?[index]?['name']
                                                ?.toString() ??
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
                                        textDirection: TextDirection.ltr,
                                        maxLines: 1),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      }),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.only(
                    left: 26,
                    top: 16,
                    right: 26,
                    bottom: 16,
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
                    color: Color(0xFF000000),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(r'''Total a Pagar:''',
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: Text('''${total}''',
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
                    ),
                  ],
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
                  bottom: 8,
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
                child: GestureDetector(
                  onTap: () async {
                    this
                        .datasets['Supabase future builder']
                        .forEach((dynamic product) async {
                      final response = await Supabase.instance.client
                          .from('orders')
                          .update({"confirmed": true})
                          .eq("id", product['id'].toString())
                          .execute();
                      if (response != null) {
                        print("Orden Actualizada");
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListStore(),
                          ),
                        );
                      } else {
                        print("No se pudo actualizar la orden");
                      }
                    });
                  },
                  onLongPress: () async {},
                  child: Container(
                      width: double.maxFinite,
                      height: 48,
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
                      child: Center(
                        child: Text(
                          'Confirmar',
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
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
