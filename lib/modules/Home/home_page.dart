import 'dart:io';
import 'package:assistsaude/modules/Agenda/visualizar_agenda.dart';
import 'package:assistsaude/modules/Comunicados/comunicados.dart';
import 'package:assistsaude/modules/Terapia/terapia_page.dart';
import 'package:assistsaude/shared/alert_button_check.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:http/http.dart' as http;
import 'package:assistsaude/modules/Home/components/home_widget.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.find(tag: 'login');
  HomeController homeController = Get.put(HomeController());

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;

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

    Get.offAllNamed('/login');
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idprof'] = loginController.idprof.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile!.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      onAlertButtonCheck(context, 'Imagem Atualizada', null);
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
            : Container(
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
                    image: NetworkImage(
                      'https://assistesaude.com.br/downloads/fotosprofissionais/${loginController.imgperfil.value}',
                    ),
                  ),
                ),
              ),
      );
    }
  }

  getImage(ImageSource source) async {
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
  }

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
      Comunicados(),
      TerapiaPage(),
      VisualizarAgenda()
    ];

    return Scaffold(
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
                            "${loginController.nome.value} ${loginController.sobrenome.value}",
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
                            "${loginController.email.value.text}",
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '${loginController.tipousu.value}',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context).primaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Perfil',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).primaryColor,
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
                        'Sessões',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        Get.toNamed('/visitas');
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
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.help,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        homeController.abrirWhatsApp();
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
                          color: Theme.of(context).primaryColor,
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
                          'images/logo.png',
                          width: 80,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Versão 1.0.0',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).primaryColor,
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
              Icons.notification_add,
            ),
            label: 'Comunicados',
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
        selectedIconTheme: IconThemeData(color: Theme.of(context).accentColor),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
      body: bottomNavigationList[selectedIndex],
    );
  }
}
