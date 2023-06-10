import 'package:admonhilton/models/class_data.dart';
import 'package:admonhilton/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ResultsScreen extends ConsumerWidget {
  static const String route = "/results";
  ResultsScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datalist = ref.watch(datalistProvider);
    // final reportsDataList = ref.watch(reportsProvider(datalist));

    return Scaffold(
        appBar: AppBar(
            title: datalist
                ? const Text("Pending Report List")
                : const Text("Fix List")),
        bottomNavigationBar: BottomAppBar(
          height: 100,
          color: Colors.blue,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(40, 10, 10, 10),
                child: IconButton(
                  iconSize: 36,
                  color: Colors.white,
                  icon: const Icon(Icons.pending_actions),
                  onPressed: () {
                    ref.read(datalistProvider.notifier).update((state) => true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 40, 10),
                child: IconButton(
                  iconSize: 36,
                  constraints: const BoxConstraints(),
                  color: Colors.white,
                  icon: const Icon(Icons.construction),
                  onPressed: () {
                    ref
                        .read(datalistProvider.notifier)
                        .update((state) => false);
                  },
                ),
              )
            ],
          ),
        ),
        body: Consumer(
          key: _formKey,
          builder: (context, watch, _) {
            final reportsDataList = ref.watch(reportsProvider(datalist));

            return reportsDataList.when(
              data: (data) {
                return Center(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ),
                      child: GroupedListView<Clsdata, String>(
                        order: GroupedListOrder.DESC,
                        elements: data,
                        groupBy: (element) {
                          DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(
                              element.datereg.millisecondsSinceEpoch);

                          return DateTime(tsdate.year, tsdate.month, tsdate.day)
                              .toString();
                        },
                        groupSeparatorBuilder: (String value) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dateformatGroup(value),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        itemBuilder: (context, element) {
                          final locationsDataList = ref.watch(
                              locationProvider(element.location.toString()));
                          final usersReportDataList = ref.watch(
                              userProvider(element.uidemployeeadd.toString()));
                          // final usersFixDataList = ref.watch(
                          //     userProvider(element.uidemployeeupd.toString()));
                          // ignore: unused_local_variable
                          final imagenreportDataList = ref.watch(
                              imageProvider(element.uidphotoreport.toString()));
                          // ignore: unused_local_variable
                          final imagenfixDataList = ref.watch(
                              imageProvider(element.uidphotofix.toString()));

                          return InkWell(
                            onTap: () {
                              final screenSize = MediaQuery.of(context).size;
                              final imagereport = ref.read(imageProvider(
                                  element.uidphotoreport.toString()));

                              final imagefix = ref.read(imageProvider(
                                  element.uidphotofix.toString()));
                              final locations = ref.read(locationProvider(
                                  element.location.toString()));
                              final userreport = ref.read(userProvider(
                                  element.uidemployeeadd.toString()));
                              final userfix = ref.read(userProvider(
                                  element.uidemployeeupd.toString()));

                              datalist
                                  ? dialogpreview(
                                      context,
                                      screenSize,
                                      locations,
                                      element,
                                      userreport,
                                      imagereport,
                                      datalist)
                                  : dialogfix(
                                      context,
                                      screenSize,
                                      locations,
                                      element,
                                      userreport,
                                      userfix,
                                      imagereport,
                                      imagefix,
                                      datalist);
                            },
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  clipBehavior: Clip.antiAlias,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Stack(
                                        clipBehavior: Clip.antiAlias,
                                        children: <Widget>[
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, bottom: 16),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade100,
                                                        offset: const Offset(
                                                            1.1, 1.1),
                                                        blurRadius: 5.0),
                                                  ],
                                                ),
                                                child: Stack(
                                                  alignment: Alignment.topLeft,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 100,
                                                            right: 16,
                                                            top: 11,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                locationsDataList
                                                                    .value
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  // fontFamily:
                                                                  //     FitnessAppTheme.fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 107,
                                                            // bottom: 8,
                                                            top: 6,
                                                            right: 16,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.person,
                                                                size: 11,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            6.0),
                                                                child: Text(
                                                                  usersReportDataList
                                                                      .value
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    // fontFamily: FitnessAppTheme.fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        10,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 107,
                                                            bottom: 12,
                                                            top: 4,
                                                            right: 16,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  element.report
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    // fontFamily: FitnessAppTheme.fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                          Positioned(
                                            top: 0,
                                            left: 5,
                                            child: SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: datalist
                                                  ? Image.asset(
                                                      'images/reloj3.png')
                                                  : Image.asset(
                                                      'images/ok2.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                          // },
                          // );
                        },
                      )),
                );
              },
              error: (error, stackTrace) => Text('Error: $error'),
              // loading: () => const Center(child: CircularProgressIndicator()),
              loading: () => shime(context),
            );
          },
        ));
  }

  Future<dynamic> dialogpreview(
      BuildContext context,
      Size screenSize,
      AsyncValue<String> locations,
      Clsdata element,
      AsyncValue<String> users,
      AsyncValue<String> imagereport,
      bool datalist) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: screenSize.width *
                0.8, // Ancho del AlertDialog al 80% del ancho de la pantalla
            height: screenSize.height *
                0.5, // Alto del AlertDialog al 50% del alto de la pantalla
            child: Scrollable(
              viewportBuilder: (BuildContext context, ViewportOffset position) {
                return SingleChildScrollView(
                    // child: dialogreport(context, element, ref),
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x2F1D2429),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Positioned(
                                              top: -10,
                                              right: 0,
                                              child: IconButton(
                                                icon: const Icon(Icons.close),
                                                iconSize: 32,
                                                color: Colors.red,
                                                splashRadius: 1,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(children: [
                                                    const Icon(
                                                        Icons.location_on),
                                                    Text(
                                                        locations.value
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20))
                                                  ]),
                                                ]),
                                          ])
                                    ]))),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x2F1D2429),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 12),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            const Row(children: [
                                              Icon(Icons.schedule, size: 16),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    'Report Date / Time',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ]),
                                            const Divider(
                                              height: 16,
                                              thickness: 2,
                                              color: Color(0xFFF1F4F8),
                                            ),
                                            Text(
                                              dateformatDetail(
                                                  element, datalist),
                                              textAlign: TextAlign.left,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            const Row(children: [
                                              Icon(Icons.person, size: 16),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    'User Report',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ))
                                            ]),
                                            const Divider(
                                              height: 16,
                                              thickness: 2,
                                              color: Color(0xFFF1F4F8),
                                            ),
                                            Text(
                                              users.value.toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            const Row(children: [
                                              Icon(Icons.description, size: 16),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    'Description Report',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ))
                                            ]),
                                            const Divider(
                                              height: 16,
                                              thickness: 2,
                                              color: Color(0xFFF1F4F8),
                                            ),
                                            Text(element.report.toString())
                                          ]),
                                      (element.uidphotoreport != null)
                                          ? const SizedBox(
                                              height: 20,
                                            )
                                          : Container(),
                                      (element.uidphotoreport != null)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                  const Row(children: [
                                                    Icon(Icons.photo_camera,
                                                        size: 16),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.0),
                                                        child: Text(
                                                          'Image Report',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ))
                                                  ]),
                                                  const Divider(
                                                    height: 16,
                                                    thickness: 2,
                                                    color: Color(0xFFF1F4F8),
                                                  ),
                                                  imagereport.when(
                                                    data: (url) {
                                                      return Image.network(
                                                        url,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }

                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        },
                                                      );
                                                    },
                                                    loading: () {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    error: (error, stackTrace) {
                                                      return Text(
                                                          error.toString());
                                                    },
                                                  ),
                                                ])
                                          : Container(),
                                    ]))),
                      ],
                    ),
                  ),
                ));
              },
            ),
          ),

          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.close),
          //       onPressed: () => Navigator.pop(context),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }

  Future<dynamic> dialogfix(
      BuildContext context,
      Size screenSize,
      AsyncValue<String> locations,
      Clsdata element,
      AsyncValue<String> userreport,
      AsyncValue<String> userfix,
      AsyncValue<String> imagereport,
      AsyncValue<String> imagefix,
      bool datalist) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.zero,

          content: SizedBox(
            width: screenSize.width *
                0.8, // Ancho del AlertDialog al 80% del ancho de la pantalla
            height: screenSize.height *
                0.9, // Alto del AlertDialog al 50% del alto de la pantalla
            child: Scrollable(
              viewportBuilder: (BuildContext context, ViewportOffset position) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x2F1D2429),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Positioned(
                                        top: -10,
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(Icons.close),
                                          iconSize: 32,
                                          color: Colors.red,
                                          splashRadius: 1,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on),
                                              Text(locations.value.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 7,
                                    color: Color(0x2F1D2429),
                                    offset: Offset(0, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 12),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              const Row(children: <Widget>[
                                                Icon(Icons.schedule, size: 16),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      'Report Date / Time',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    )),
                                              ]),
                                              const Divider(
                                                height: 16,
                                                thickness: 2,
                                                color: Color(0xFFF1F4F8),
                                              ),
                                              Text(
                                                dateformatDetail(
                                                    element, datalist),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ]),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // expandedUser(
                                        //     users.value.toString(), datalist),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              const Row(children: [
                                                Icon(Icons.person, size: 16),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      'User Report',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ))
                                              ]),
                                              const Divider(
                                                height: 16,
                                                thickness: 2,
                                                color: Color(0xFFF1F4F8),
                                              ),
                                              Text(
                                                userreport.value.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ]),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              const Row(children: <Widget>[
                                                Icon(
                                                  Icons.description,
                                                  size: 16,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      'Description Report',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ))
                                              ]),
                                              const Divider(
                                                height: 16,
                                                thickness: 2,
                                                color: Color(0xFFF1F4F8),
                                              ),
                                              Text(element.report.toString())
                                            ]),
                                        (element.uidphotoreport != null)
                                            ? const SizedBox(
                                                height: 20,
                                              )
                                            : Container(),
                                        (element.uidphotoreport != null)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                    const Row(children: [
                                                      Icon(
                                                        Icons.photo_camera,
                                                        size: 16,
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.0),
                                                          child: Text(
                                                            'Image Report',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ))
                                                    ]),
                                                    const Divider(
                                                      height: 16,
                                                      thickness: 2,
                                                      color: Color(0xFFF1F4F8),
                                                    ),
                                                    imagereport.when(
                                                      data: (url) {
                                                        return Image.network(
                                                          url,
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            }

                                                            return const Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          },
                                                        );
                                                      },
                                                      loading: () {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                      error:
                                                          (error, stackTrace) {
                                                        return Text(
                                                            error.toString());
                                                      },
                                                    ),
                                                  ])
                                            : Container(),
                                      ]))),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 7,
                                    color: Color(0x2F1D2429),
                                    offset: Offset(0, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 12),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              const Row(children: <Widget>[
                                                Icon(
                                                  Icons.schedule,
                                                  size: 16,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      'Fix Date / Time',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left,
                                                    ))
                                              ]),
                                              const Divider(
                                                height: 16,
                                                thickness: 2,
                                                color: Color(0xFFF1F4F8),
                                              ),
                                              Text(
                                                dateformatDetail(
                                                    element, datalist),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // expandedUser(
                                        //     users.value.toString(), datalist),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              const Row(children: [
                                                Icon(Icons.person, size: 16),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      'User Fix',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ))
                                              ]),
                                              const Divider(
                                                height: 16,
                                                thickness: 2,
                                                color: Color(0xFFF1F4F8),
                                              ),
                                              Text(
                                                userfix.value.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ]),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              const Row(children: <Widget>[
                                                Icon(
                                                  Icons.description,
                                                  size: 16,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      'Description Fix',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ))
                                              ]),
                                              const Divider(
                                                height: 16,
                                                thickness: 2,
                                                color: Color(0xFFF1F4F8),
                                              ),
                                              Text(
                                                  element.reportfix.toString()),
                                            ]),
                                        (element.uidphotofix != null)
                                            ? const SizedBox(
                                                height: 20,
                                              )
                                            : Container(),
                                        (element.uidphotofix != null)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                    const Row(children: [
                                                      Icon(Icons.photo_camera,
                                                          size: 16),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.0),
                                                          child: Text(
                                                            'Image Fix',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ))
                                                    ]),
                                                    const Divider(
                                                      height: 16,
                                                      thickness: 2,
                                                      color: Color(0xFFF1F4F8),
                                                    ),
                                                    imagefix.when(
                                                      data: (url) {
                                                        return Image.network(
                                                          url,
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            }

                                                            return const Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          },
                                                        );
                                                      },
                                                      loading: () {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                      error:
                                                          (error, stackTrace) {
                                                        return Text(
                                                            error.toString());
                                                      },
                                                    ),
                                                  ])
                                            : Container(),
                                      ]))),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // ElevatedButton.icon(
                          //   icon: const Icon(
                          //     Icons.exit_to_app,
                          //     size: 32,
                          //   ),
                          //   style: ElevatedButton.styleFrom(
                          //       elevation: 2,
                          //       minimumSize: const Size(200, 45),
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius:
                          //               BorderRadius.circular(5.0))),
                          //   label: const Text('Close'),
                          //   onPressed: () => Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const Resume(
                          //                 existkey: true,
                          //               ))),
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String dateformatGroup(String fechastring) {
    if (fechastring != "") {
      DateTime fechaDatetime = DateFormat("yyyy-MM-dd").parse(fechastring);
      String formatFecha = DateFormat("MMMM dd yyyy (EEE)").format(
          fechaDatetime); // change the format to dd/MM/yyyy or any other required format

      return formatFecha.toString();
    } else {
      return "";
    }
  }

  // String dateformatDetail(Clsdata fechastring) {
  String dateformatDetail(Clsdata fechastring, bool datalist) {
    DateTime tsdate;
    if (datalist) {
      tsdate = DateTime.fromMillisecondsSinceEpoch(
          fechastring.datereg.millisecondsSinceEpoch);
    } else {
      tsdate = DateTime.fromMillisecondsSinceEpoch(
          fechastring.dateupd!.millisecondsSinceEpoch);
    }

    String dateformat = DateTime(tsdate.year, tsdate.month, tsdate.day,
            tsdate.hour, tsdate.minute, tsdate.second)
        .toString();

    DateTime fechaDatetime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateformat);
    String formatFecha = DateFormat("dd MMMM yyyy H:mm:ss").format(
        fechaDatetime); // change the format to dd/MM/yyyy or any other required format

    return formatFecha.toString();
  }

  shime(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        height: 107,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.withOpacity(0.5),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 5.0),
                    ],
                  ),
                  child: const SizedBox())),
        ),
      ),
    );
  }

  Column expandedUser1(String useradd, bool datalist) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(children: [
            const Icon(Icons.person, size: 16),
            Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  datalist ? 'User Report' : 'User Fix',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ))
          ]),
          const Divider(
            height: 16,
            thickness: 2,
            color: Color(0xFFF1F4F8),
          ),
          Text(
            useradd,
            style: const TextStyle(fontSize: 14),
          ),
        ]);
  }
}
