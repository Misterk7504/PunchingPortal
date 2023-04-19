# PunchingPortal
The All Data Is  Belong To The Punching Portal .Total Codes And Api Is In Build In this Code 







import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/perfectpunching/perfectpunching_widget.dart';
import '/unauthoriseduser/unauthoriseduser_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'perfectpunching_model.dart';
export 'perfectpunching_model.dart';

class PerfectpunchingWidget extends StatefulWidget {
  const PerfectpunchingWidget({Key? key}) : super(key: key);

  @override
  _PerfectpunchingWidgetState createState() => _PerfectpunchingWidgetState();
}

class _PerfectpunchingWidgetState extends State<PerfectpunchingWidget> {
  late PerfectpunchingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PerfectpunchingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.battery = await SystemInfoGroup.batteryCall.call();
      FFAppState().update(() {
        FFAppState().battery = SystemInfoGroup.batteryCall.hasbattery(
          (_model.battery?.jsonBody ?? ''),
        );
      });
      if (FFAppState().battery) {
        _model.networkinform = await SystemInfoGroup.networkinfoCall.call();
        FFAppState().update(() {
          FFAppState().MacAddress = (SystemInfoGroup.networkinfoCall.macaddress(
            (_model.networkinform?.jsonBody ?? ''),
          ) as List)
              .map<String>((s) => s.toString())
              .toList()!
              .toList();
          FFAppState().ipd = (SystemInfoGroup.networkinfoCall.ip4(
            (_model.networkinform?.jsonBody ?? ''),
          ) as List)
              .map<String>((s) => s.toString())
              .toList()!
              .toList();
        });
        _model.osInform = await SystemInfoGroup.osinfoCall.call();
        FFAppState().update(() {
          FFAppState().HOSTNAME = SystemInfoGroup.osinfoCall
              .hostname(
                (_model.osInform?.jsonBody ?? ''),
              )
              .toString();
        });
        _model.systemmac = await SystemValidationMacCall.call(
          macaddress: FFAppState().MacAddress[0],
        );
        FFAppState().update(() {
          FFAppState().MacVeri = SystemValidationMacCall.result(
            (_model.systemmac?.jsonBody ?? ''),
          );
        });
        if (SystemValidationMacCall.result(
              (_model.systemmac?.jsonBody ?? ''),
            ).toString().toString() !=
            '1') {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: Text('You are not authorised to punch in Laptop'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnauthoriseduserWidget(),
            ),
          );
          return;
        }
      } else {
        _model.networkinforma = await SystemInfoGroup.networkinfoCall.call();
        FFAppState().update(() {
          FFAppState().MacAddress = (SystemInfoGroup.networkinfoCall.macaddress(
            (_model.networkinforma?.jsonBody ?? ''),
          ) as List)
              .map<String>((s) => s.toString())
              .toList()!
              .toList();
          FFAppState().ipd = (SystemInfoGroup.networkinfoCall.ip4(
            (_model.networkinforma?.jsonBody ?? ''),
          ) as List)
              .map<String>((s) => s.toString())
              .toList()!
              .toList();
        });
        _model.osInforma = await SystemInfoGroup.osinfoCall.call();
        FFAppState().update(() {
          FFAppState().HOSTNAME = SystemInfoGroup.osinfoCall
              .hostname(
                (_model.osInforma?.jsonBody ?? ''),
              )
              .toString();
        });
      }

      _model.branchdet = await BrannchDetCall.call(
        speci1: '1',
        speci2: '0',
        empID: '0',
        hostname: FFAppState().HOSTNAME,
        macId: FFAppState().MacAddress[0],
        flag: 'FLTRGETBRANCHKEY',
        fromTime: '12:00:00 AM',
        toTime: '2:00:00 AM',
      );
      if ((_model.branchdet?.succeeded ?? true)) {
        FFAppState().update(() {
          FFAppState().brid = BrannchDetCall.branchID(
            (_model.branchdet?.jsonBody ?? ''),
          );
          FFAppState().BranchName = BrannchDetCall.branchName(
            (_model.branchdet?.jsonBody ?? ''),
          ).toString();
        });
      }
    });

    _model.employeeCodeController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
              tabletLandscape: false,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFF0BB03), Color(0xFFFAF9F7)],
                            stops: [0.5, 0.5],
                            begin: AlignmentDirectional(0, -1),
                            end: AlignmentDirectional(0, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 16, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (responsiveVisibility(
                                          context: context,
                                          tabletLandscape: false,
                                          desktop: false,
                                        ))
                                          Container(
                                            width: double.infinity,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  90, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -0.5, 0),
                                                      child: Text(
                                                        'MANAPPURAM FINANCE LIMITED ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .displaySmall
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              color: Color(
                                                                  0xE7000000),
                                                              fontSize: 25,
                                                              letterSpacing: 5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              lineHeight: 1,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.95, -0.45),
                                                child: Image.asset(
                                                  'assets/images/download.jpeg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  45, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dateTimeFormat('d/M/y',
                                                    getCurrentTimestamp),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              Text(
                                                FFAppState().BranchName,
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (responsiveVisibility(
                                          context: context,
                                          tabletLandscape: false,
                                          desktop: false,
                                        ))
                                          Divider(
                                            height: 24,
                                            thickness: 1,
                                            color: FlutterFlowTheme.of(context)
                                                .lineColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Divider(
                                        thickness: 4,
                                        indent: 90,
                                        endIndent: 90,
                                        color: Color(0xFFED2023),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'PUNCHING PORTAL',
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 20,
                                                          letterSpacing: 5,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        100, 0, 100, 50),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .lineColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 10, 10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.45,
                                                decoration: BoxDecoration(
                                                  color: Color(0xA5B2BEB5),
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xBDB2BEB5),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF2EEEE),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0x00B2BEB5),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          Form(
                                                                        key: _model
                                                                            .formKey,
                                                                        autovalidateMode:
                                                                            AutovalidateMode.disabled,
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.stretch,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0x00B2BEB5),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                                                                  child: TextFormField(
                                                                                    controller: _model.employeeCodeController,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).bodySmall,
                                                                                      hintText: 'Employee Code',
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodySmall,
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0x00000000),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0x00000000),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0x00000000),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      filled: true,
                                                                                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Poppins',
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                    textAlign: TextAlign.start,
                                                                                    keyboardType: TextInputType.number,
                                                                                    validator: _model.employeeCodeControllerValidator.asValidator(context),
                                                                                    inputFormatters: [
                                                                                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0x00B2BEB5),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                                                                  child: TextFormField(
                                                                                    controller: _model.passwordController,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.passwordController',
                                                                                      Duration(milliseconds: 2000),
                                                                                      () async {
                                                                                        var _shouldSetState = false;
                                                                                        if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                                                                          return;
                                                                                        }
                                                                                        FFAppState().update(() {
                                                                                          FFAppState().EmpName = '';
                                                                                          FFAppState().ShiftTimings = '';
                                                                                          FFAppState().LocalBase64Image = '';
                                                                                        });
                                                                                        _model.passve = await PasswordVerificationCall.call(
                                                                                          empID: _model.employeeCodeController.text,
                                                                                          pswd: _model.passwordController.text,
                                                                                        );
                                                                                        _shouldSetState = true;
                                                                                        FFAppState().update(() {
                                                                                          FFAppState().veri = PasswordVerificationCall.result(
                                                                                            (_model.passve?.jsonBody ?? ''),
                                                                                          );
                                                                                        });
                                                                                        if (FFAppState().veri.toString() != '1') {
                                                                                          await showDialog(
                                                                                            context: context,
                                                                                            builder: (alertDialogContext) {
                                                                                              return AlertDialog(
                                                                                                title: Text('Please check your Password'),
                                                                                                actions: [
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                    child: Text('Ok'),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                          setState(() {
                                                                                            _model.employeeCodeController?.clear();
                                                                                            _model.passwordController?.clear();
                                                                                          });
                                                                                          FFAppState().update(() {
                                                                                            FFAppState().LocalBase64Image = '';
                                                                                          });
                                                                                          if (_shouldSetState) setState(() {});
                                                                                          return;
                                                                                        }
                                                                                        _model.getshift = await GettingEmpShiftCall.call(
                                                                                          employeeByCode: int.tryParse(_model.employeeCodeController.text),
                                                                                        );
                                                                                        _shouldSetState = true;
                                                                                        FFAppState().update(() {
                                                                                          FFAppState().EmpName = GettingEmpShiftCall.empName(
                                                                                            (_model.getshift?.jsonBody ?? ''),
                                                                                          ).toString();
                                                                                          FFAppState().ShiftTimings = GettingEmpShiftCall.shiftTimings(
                                                                                            (_model.getshift?.jsonBody ?? ''),
                                                                                          ).toString();
                                                                                        });
                                                                                        if (_shouldSetState) setState(() {});
                                                                                      },
                                                                                    ),
                                                                                    obscureText: !_model.passwordVisibility,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).bodySmall,
                                                                                      hintText: 'Password',
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodySmall,
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0x00000000),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0x00000000),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0x00000000),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      filled: true,
                                                                                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                                                                                      suffixIcon: InkWell(
                                                                                        onTap: () => setState(
                                                                                          () => _model.passwordVisibility = !_model.passwordVisibility,
                                                                                        ),
                                                                                        focusNode: FocusNode(skipTraversal: true),
                                                                                        child: Icon(
                                                                                          _model.passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                                                                          color: Color(0xFF757575),
                                                                                          size: 22,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Poppins',
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                    validator: _model.passwordControllerValidator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                height: MediaQuery.of(context).size.height * 0.06,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-0.9, 0),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            GettingEmpShiftCall.empName(
                                                                                              (_model.getshift?.jsonBody ?? ''),
                                                                                            ).toString(),
                                                                                            'Emp namee',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                color: Color(0xFF101213),
                                                                                                fontSize: 12,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(30, 16, 30, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                height: MediaQuery.of(context).size.height * 0.06,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-0.9, 0),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            FFAppState().ShiftTimings,
                                                                                            'Shift',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      var _shouldSetState =
                                                                          false;
                                                                      if (_model
                                                                              .employeeCodeController
                                                                              .text ==
                                                                          '') {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              content: Text('Please enter your Employeecode'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        if (_shouldSetState)
                                                                          setState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                      if (_model
                                                                              .passwordController
                                                                              .text ==
                                                                          '') {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              content: Text('Please enter your password'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        if (_shouldSetState)
                                                                          setState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                      _model.test =
                                                                          await PasswordVerificationCall
                                                                              .call(
                                                                        empID: _model
                                                                            .employeeCodeController
                                                                            .text,
                                                                        pswd: _model
                                                                            .passwordController
                                                                            .text,
                                                                      );
                                                                      _shouldSetState =
                                                                          true;
                                                                      if (!(_model
                                                                              .test
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              content: Text('Please Enter correct Employee Code/ Password'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        if (_shouldSetState)
                                                                          setState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                      await actions
                                                                          .clickPictureFromCamera();
                                                                      await Future.delayed(const Duration(
                                                                          milliseconds:
                                                                              1000));
                                                                      _model.punchingPost =
                                                                          await PunchingPostCall
                                                                              .call(
                                                                        empcode: int.tryParse(_model
                                                                            .employeeCodeController
                                                                            .text),
                                                                        branchid:
                                                                            FFAppState().brid,
                                                                        punchTime: dateTimeFormat(
                                                                            'jm',
                                                                            getCurrentTimestamp),
                                                                        ipd:
                                                                            '${FFAppState().ipd[0]}~${FFAppState().HOSTNAME}',
                                                                      );
                                                                      _shouldSetState =
                                                                          true;
                                                                      _model.iMGpostAPI =
                                                                          await ImgPostCall
                                                                              .call(
                                                                        empCode: int.tryParse(_model
                                                                            .employeeCodeController
                                                                            .text),
                                                                        pPhoto:
                                                                            FFAppState().LocalBase64Image,
                                                                      );
                                                                      _shouldSetState =
                                                                          true;
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            content:
                                                                                Text(PunchingPostCall.message(
                                                                              (_model.punchingPost?.jsonBody ?? ''),
                                                                            ).toString()),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        _model
                                                                            .employeeCodeController
                                                                            ?.clear();
                                                                        _model
                                                                            .passwordController
                                                                            ?.clear();
                                                                      });
                                                                      FFAppState()
                                                                          .update(
                                                                              () {
                                                                        FFAppState().EmpName =
                                                                            '';
                                                                        FFAppState().ShiftTimings =
                                                                            '';
                                                                        FFAppState().LocalBase64Image =
                                                                            '';
                                                                      });
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              PerfectpunchingWidget(),
                                                                        ),
                                                                      );
                                                                      if (_shouldSetState)
                                                                        setState(
                                                                            () {});
                                                                    },
                                                                    text:
                                                                        'Submit',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          35,
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      iconPadding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      color: Color(
                                                                          0xFFD3222D),
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      elevation:
                                                                          2,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        _model
                                                                            .employeeCodeController
                                                                            ?.clear();
                                                                        _model
                                                                            .passwordController
                                                                            ?.clear();
                                                                      });
                                                                      FFAppState()
                                                                          .update(
                                                                              () {
                                                                        FFAppState().EmpName =
                                                                            '';
                                                                        FFAppState().ShiftTimings =
                                                                            '';
                                                                        FFAppState().LocalBase64Image =
                                                                            '';
                                                                      });
                                                                    },
                                                                    text:
                                                                        'Reject',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          35,
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      iconPadding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      color: Color(
                                                                          0xFFD3222D),
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      elevation:
                                                                          2,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.45,
                                              decoration: BoxDecoration(
                                                color: Color(0xBDB2BEB5),
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                  color: Color(0xFFFAF9F7),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, -1),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: custom_widgets
                                                      .CameraWidget(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    myTakePicture: () async {},
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 4,
                                    indent: 90,
                                    endIndent: 90,
                                    color: Color(0xFFF50709),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Developed By ',
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                fontFamily: 'Trade Winds',
                                                color: Color(0xD1ED2023),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text(
                                          'IT Modernization Team',
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                fontFamily: 'Teko',
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
