// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'package:bormental/transitions/fade.dart';
import 'package:bormental/screens/home/v1/screen.dart';
import 'package:bormental/screens/menu/menu_item.dart';

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
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              elevation: 1,
              snap: true,
              floating: true,
              pinned: true,
              toolbarHeight: 120,
              expandedHeight: 120,
              titleSpacing: 10,
              backgroundColor: Colors.white,
              title: UserInformation(),
              centerTitle: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(66.0),
                child: UserActionsPanel(),
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
                children: const <Widget>[
                  MenuItems(),
                  AppCurrentRevision(),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

class AppCurrentRevision extends StatelessWidget {
  const AppCurrentRevision({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    fontSize: 14,
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
    );
  }
}

class UserActionsPanel extends StatelessWidget {
  const UserActionsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const HeaderItem(label: 'КОНТЕНТ И ДЕЙСТВИЯ'),
            MenuItem(
              icon: Fontisto.shopping_package,
              label: 'Bormental Premium',
              onTap: () {
                Navigator.push(context, FadeRoute(
                  page: const HomeScreen(),
                ));
              },
              color: Colors.purple.withOpacity(0.5),
              iconColor: Colors.white,
              fontColor: Colors.white,
            ),
            MenuItem(
                icon: Fontisto.bitcoin,
                label: 'Кошелек',
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
            const MenuItem(
                icon: Fontisto.shield,
                label: 'Безопасность'
            ),
            const MenuItem(
                icon: Fontisto.bell,
                label: 'Push-уведомления'
            ),
            const MenuItem(
                icon: Fontisto.language,
                label: 'Язык приложения'
            ),
            const MenuItem(
                icon: Fontisto.share,
                label: 'Поделиться приложением'
            ),
            const MenuItem(
                icon: Fontisto.paw,
                label: 'Семейный доступ'
            ),
            const MenuItem(
                icon: Fontisto.share_a,
                label: 'Поделиться профилем'
            ),
            const HeaderItem(label: 'КЕШ И МОБИЛЬНЫЕ ДАННЫЕ'),
            const MenuItem(
                icon: Fontisto.trash,
                label: 'Освобождение места'
            ),
            const MenuItem(
                icon: Fontisto.flash,
                label: 'Экономия трафика'
            ),
            const HeaderItem(label: 'ПОДДЕРЖКА'),
            const MenuItem(
                icon: Fontisto.google_play,
                label: 'Оценить приложение'
            ),
            const MenuItem(
                icon: Fontisto.paper_plane,
                label: 'Написать нам'
            ),
            const MenuItem(
                icon: Fontisto.nav_icon_list,
                label: 'FAQ'
            ),
            const HeaderItem(label: 'ИФОРМАЦИЯ'),
            const MenuItem(
                icon: Fontisto.file_1,
                label: 'Правила размещения контента'
            ),
            const MenuItem(
                icon: Fontisto.persons,
                label: 'Правообладателям'
            ),
            const MenuItem(
                icon: Fontisto.flag,
                label: 'Условия использования'
            ),
            const MenuItem(
                icon: Fontisto.locked,
                label: 'Политика конфиденциальности'
            ),
            const MenuItem(
                icon: Fontisto.info,
                label: 'О Проекте'
            ),
            const HeaderItem(label: 'ВХОД'),
            const MenuItem(
                icon: Fontisto.arrow_swap,
                label: 'Сменить аккаунт',
                right: CircleAvatar(
                  backgroundImage:
                  NetworkImage('https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s32-c-mo'),
                  backgroundColor: Colors.transparent,
                  radius: 10.0,
                )
            ),
            const MenuItem(
                icon: Fontisto.power,
                label: 'Выход'
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}