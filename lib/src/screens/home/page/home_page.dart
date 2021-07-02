import 'package:asiscumbre/src/models/asistencia_model.dart';
import 'package:asiscumbre/src/providers/asistencia_provider.dart';
import 'package:asiscumbre/src/utils/widgets/loagind_page.dart';
import 'package:asiscumbre/src/utils/api_response.dart';
import 'package:asiscumbre/src/utils/colors.dart';
import 'package:asiscumbre/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:asiscumbre/src/utils/images.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final asistenciaProvider = AsistenciaProvider();
  String ndocumento;
  String nombres;
  String cargo;
  String ciudad;
  String fecha;
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    this.ndocumento = '';
    this.nombres = '';
    this.cargo = '';
    this.ciudad = '';
    this.fecha = '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: Colors.deepOrange[100],
       appBar: AppBar(
         backgroundColor: Colors.deepOrange[100],
          elevation: 0.0,
        ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code),
        backgroundColor: colorPrimary,
        onPressed: () => _scan(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.32),
                    padding: EdgeInsets.only(top: size.height * 0.05, left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'N° documento\n'
                                        ),
                                        TextSpan(
                                          text: ndocumento,
                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0)
                                        )
                                      ]
                                    )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Ciudad\n'
                                    ),
                                    TextSpan(
                                      text: ciudad,
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0)
                                    )
                                  ]
                                )
                              ),
                            )
                          ],
                        ),
                        Divider(height: 20.0,),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Nombres\n'
                              ),
                              TextSpan(
                                text: nombres,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0)
                              )
                            ]
                          )
                        ),
                        Divider(height: 20.0,),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Cargo\n'
                              ),
                              TextSpan(
                                text: cargo,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0,)
                              )
                            ]
                          )
                        ),
                        Divider(height: 20.0,),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Fecha registro\n'
                              ),
                              TextSpan(
                                text: fecha,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0)
                              )
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IV CUMBRE DE LA DESCENTRALIZACION', 
                          style: TextStyle(color: colorPrimary),
                        ),
                        Text(
                          'Registro de Asistencia', 
                          style: Theme.of(context).textTheme.headline4.copyWith(color: colorPrimary, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            
                            SizedBox(width: size.width * 0.62,),
                            Expanded(
                              child: Image.asset(
                                LOGO_HOME,
                                width: 220,
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Future _scan(BuildContext context) async {
    setState(() {
      _clear();
    });
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      showAlertDialog(context, 'No se puede scanear');
    } else {
      LoadingPage loadingPage = LoadingPage(context);
      loadingPage.show();
      ApiResponse<AsistenciaModel> response = await asistenciaProvider.registrarAsistencia(barcode);
      if(response.success){
        loadingPage.close();
        AsistenciaModel asistencia = response.data;
        setState(() {
          ndocumento = asistencia.participante.ndocumento;
          nombres = asistencia.participante.nombres;
          cargo = asistencia.participante.cargo;
          ciudad = asistencia.participante.ciudad;
          fecha = asistencia.fechaRegistro;
        });
      } else {
        loadingPage.close();
        showAlertDialog(context, response.message);
        setState(() {
          _clear();
        });
      }
      
    }
  }

  _clear(){
    ndocumento = '';
    nombres = '';
    cargo = '';
    ciudad = '';
    fecha = '';
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

}
