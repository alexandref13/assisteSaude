import 'dart:convert';
import 'dart:io';
import 'package:assistsaude/modules/Agenda/calendario_controller.dart';
import 'package:assistsaude/modules/Agenda/visualizar_agenda.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/modules/Session/session_controller.dart';
import 'package:assistsaude/modules/Session/session_page.dart';
import 'package:assistsaude/modules/Terapia/terapia_controller.dart';
import 'package:assistsaude/modules/Terapia/terapia_page.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/delete_alert.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:assistsaude/modules/Home/components/home_widget.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.find(tag: 'login');
  HomeController homeController = Get.put(HomeController());
  SessionController sessionController = Get.put(SessionController());
  TerapiaController terapiaController = Get.put(TerapiaController());
  MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
  CalendarioController calendarioController = Get.put(CalendarioController());

  void onItemTapped(int index) {
    setState(() {
      loginController.selectedIndex.value = index;
    });

    if (loginController.selectedIndex.value == 1) {
      sessionController.getSessions().then((value) => value);
    }
    if (loginController.selectedIndex.value == 2) {
      terapiaController.getTerapias().then((value) => value);
    }
    if (loginController.selectedIndex.value == 3) {
      mapaAgendaController.getClientes().then((value) => value);
      calendarioController.agenda().then((value) => value);
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;
  CroppedFile? _croppedFile;

  final uri =
      Uri.parse("https://assistesaude.com.br/flutter/upload_imagem.php");

  Future<void> logoutUser() async {
    await GetStorage.init();

    final box = GetStorage();
    box.erase();

    loginController.email.value.text = '';
    loginController.password.value.text = '';
    loginController.idprof.value = '';
    loginController.nome.value = '';
    loginController.tipousu.value = '';
    loginController.imgperfil.value = '';
    loginController.idCliente.value = '';

    Get.offAllNamed('/login');
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idprof'] = loginController.idprof.value;
    var pic = await http.MultipartFile.fromPath("image", _croppedFile!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        loginController.imgperfil.value = value.trim();
      });
    } else if (response.statusCode == 404) {
      loginController.imgperfil.value = '';
    } else {
      Navigator.of(context).pop();
      onAlertButtonPressed(
        context,
        'Algo deu errado.\n Tente novamente mais tarde',
        () {
          Get.back();
        },
      );
    }
    _croppedFile = null;
    _selectedFile = null;
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
          //Navigator.pushNamed(context, '/Home');
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 40, bottom: 5),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor)),
            ],
          ),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              image: new FileImage(_selectedFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            _configurandoModalBottomSheet(context);
          },
          child: loginController.imgperfil.value == ''
              ? Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40, bottom: 5),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/user.png'),
                    ),
                  ),
                )
              : Obx(() => Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image:
                                  'https://assistesaude.com.br/downloads/fotosprofissionais/${loginController.imgperfil.value}',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(left: 40),
                                child: Center(
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {});
    // ignore: deprecated_member_use
    PickedFile? image = await _picker.getImage(source: source);

    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 80,
        maxWidth: 400,
        maxHeight: 400,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
              toolbarColor: Colors.deepOrange,
              toolbarTitle: "Imagem para o Perfil",
              statusBarColor: Colors.deepOrange.shade900,
              backgroundColor: Colors.white,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio4x3,
              cropGridStrokeWidth: 400,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Imagem para o Perfil',
          ),
          /*WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 400,
              height: 400,
            ),
            viewPort:
                const CroppieViewPort(width: 400, height: 400, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),*/
        ],
      );
      this.setState(() {
        _croppedFile = croppedFile;
        //_selectedFile = croppedFile;
        //_selectedFile = _selectedFile;
        if (croppedFile != null) {
          uploadImage();
          Get.back();
        }
      });
    }
  }

  /*getImage(ImageSource source) async {
    this.setState(() {});
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 80,
          maxWidth: 400,
          maxHeight: 400,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Imagem para o Perfil",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = File(image.path);
        _selectedFile = cropped;
        if (cropped != null) {
          uploadImage();
          Get.back();
        }
      });
    }
  }*/

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(
                        child: Text(
                  "Alterar Imagem",
                  style: GoogleFonts.montserrat(fontSize: 16),
                ))),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    title: new Text('Câmera'),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(Icons.collections,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    title: new Text('Galeria de Fotos'),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavigationList = <Widget>[
      HomeWidget(),
      SessionPage(),
      TerapiaPage(),
      VisualizarAgenda()
    ];

    return WillPopScope(
      onWillPop: () async {
        deleteAlert(context, 'Deseja realmente sair?', () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
        key: homeController.key,
        drawer: Drawer(
          child: Container(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: <Widget>[
                          getImageWidget(),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "${loginController.nome.value}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              "${loginController.emailprof.value}",
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              '${loginController.especialidade.value}',
                              style: GoogleFonts.montserrat(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Column(
                  children: <Widget>[
                    loginController.isMoreThanOneEmail.value == false
                        ? Container()
                        : Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                              dense: true,
                              title: Text(
                                'Empresas',
                                style: GoogleFonts.montserrat(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 12,
                                ),
                              ),
                              leading: Icon(
                                Icons.home,
                                color: Theme.of(context).primaryColor,
                                size: 22,
                              ),
                              onTap: () async {
                                loginController.idCliente.value = '';
                                await loginController.hasMoreEmail(
                                  loginController.email.value.text,
                                );
                                Get.offAllNamed('/listOfClients');
                              },
                            ),
                          ),
                    loginController.isMoreThanOneEmail.value == false
                        ? Container()
                        : Divider(
                            height: 5,
                            color: Theme.of(context).primaryColor,
                          ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        dense: true,
                        title: Text(
                          'Perfil',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 12,
                          ),
                        ),
                        leading: Icon(
                          Icons.person_outline,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        onTap: () {
                          Get.toNamed('/perfil');
                        },
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        dense: true,
                        title: Text(
                          'Senha',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 12,
                          ),
                        ),
                        leading: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        onTap: () {
                          Get.toNamed('/senha');
                        },
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        dense: true,
                        title: Text(
                          'Comunicados',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 12,
                          ),
                        ),
                        leading: Icon(
                          Icons.notification_add,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        onTap: () {
                          Get.toNamed('/comunicados');
                        },
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        dense: true,
                        title: Text(
                          'Ajuda',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 12,
                          ),
                        ),
                        leading: Icon(
                          Icons.help,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        onTap: () {
                          homeController.abrirWhatsApp(
                              '5591981220670', context);
                        },
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        dense: true,
                        title: Text(
                          'Sair',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 12,
                          ),
                        ),
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        onTap: () {
                          logoutUser();
                        },
                      ),
                    ),
                    Divider(
                      height: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60, bottom: 5),
                        child: Container(
                          //color: Color(0xfff5f5f5),
                          child: Image.asset(
                            'images/logobranca.png',
                            width: 80,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Versão 1.6',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.description_outlined,
              ),
              label: 'Sessões',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.business,
              ),
              label: 'Terapias',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.date_range_outlined,
              ),
              label: 'Agenda',
            ),
          ],
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).accentColor),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: loginController.selectedIndex.value,
          onTap: onItemTapped,
        ),
        body: bottomNavigationList[loginController.selectedIndex.value],
      ),
    );
  }
}
