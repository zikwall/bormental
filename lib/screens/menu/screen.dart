// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with AutomaticKeepAliveClientMixin<MenuScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 1,
              snap: true,
              floating: true,
              pinned: true,
              toolbarHeight: 120,
              expandedHeight: 120,
              titleSpacing: 10,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s83-c-mo',
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Andrey Kapitonov",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "@suxxorz",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        "На Вашем счету",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "15 Борменталов",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
              centerTitle: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(66.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Fontisto.player_settings,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                SizedBox(width: 5),
                                Text('Панель управления', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text('Выйти', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  )),
                                  SizedBox(width: 5),
                                  Icon(
                                    Fontisto.frowning,
                                    color: Colors.white,
                                    size: 13,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _buildHeaderItem('КОНТЕНТ И ДЕЙСТВИЯ'),
                          _buildMenuItem(Fontisto.shopping_package, 'Bormental Premium', () {

                          }),
                          _buildMenuItem(Fontisto.bitcoin, 'Кошелек', () {

                          },
                              right: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange
                                ),
                                child: const Center(
                                  child: Text('15', style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  )),
                                ),
                              )
                          ),
                          _buildMenuItem(Fontisto.shield, 'Безопасность', () {

                          }),
                          _buildMenuItem(Fontisto.bell, 'Push-уведомления', () {

                          }),
                          _buildMenuItem(Fontisto.language, 'Язык приложения', () {

                          }),
                          _buildMenuItem(Fontisto.share, 'Поделиться приложением', () {

                          }),
                          _buildMenuItem(Fontisto.paw, 'Семейный доступ', () {

                          }),
                          _buildMenuItem(Fontisto.share_a, 'Поделиться профилем', () {

                          }),
                          _buildHeaderItem('КЕШ И МОБИЛЬНЫЕ ДАННЫЕ'),
                          _buildMenuItem(Fontisto.trash, 'Освобождение места', () {

                          }),
                          _buildMenuItem(Fontisto.flash, 'Экономия трафика', () {

                          }),
                          _buildHeaderItem('ПОДДЕРЖКА'),
                          _buildMenuItem(Fontisto.google_play, 'Оценить приложение', () {

                          }),
                          _buildMenuItem(Fontisto.paper_plane, 'Написать нам', () {

                          }),
                          _buildMenuItem(Fontisto.nav_icon_list, 'FAQ', () {

                          }),
                          _buildHeaderItem('ИФОРМАЦИЯ'),
                          _buildMenuItem(Fontisto.file_1, 'Правила размещения контента', () {

                          }),
                          _buildMenuItem(Fontisto.persons, 'Правообладателям', () {

                          }),
                          _buildMenuItem(Fontisto.flag, 'Условия использования', () {

                          }),
                          _buildMenuItem(Fontisto.locked, 'Политика конфиденциальности', () {

                          }),
                          _buildMenuItem(Fontisto.info, 'О Проекте', () {

                          }),
                          _buildHeaderItem('ВХОД'),
                          _buildMenuItem(Fontisto.arrow_swap, 'Сменить аккаунт', () {

                          },
                              right: const CircleAvatar(
                                backgroundImage:
                                NetworkImage('https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s32-c-mo'),
                                backgroundColor: Colors.transparent,
                                radius: 10.0,
                              )
                          ),
                          _buildMenuItem(Fontisto.power, 'Выход', () {

                          }),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      Text('Bormental App', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      )),
                      SizedBox(height: 3),
                      Text('build v22.9.5(20222009050)', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      )),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

Widget _buildHeaderItem(String label) {
  return (
    Padding(
      padding: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            height: 0.5,
            color: Colors.grey.withOpacity(0.5),
          ),
          SizedBox(height: 25),
          Text(label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w500
              )
          ),
        ],
      ),
    )
  );
}

Widget _buildOurSocials() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const <Widget>[
      Icon(
        Fontisto.github,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.telegram,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.vk,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.facebook,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.behance,
        color: Colors.black,
        size: 20,
      ),
    ],
  );
}

Widget _buildMenuItem(IconData icon, String label, onTap, { Widget? right }) {
  final items = <Widget>[
    Icon(
      icon,
      color: Colors.grey,
      size: 14,
    ),
    const SizedBox(width: 15),
    Text(label, style: const TextStyle(
      color: Colors.black,
      fontSize: 15,
    )),
  ];

  if (right != null) {
    items.add(const Spacer());
    items.add(right);
  }

  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    ),
  );
}