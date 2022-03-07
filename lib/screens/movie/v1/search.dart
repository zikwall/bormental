import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

import 'constants.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(35, 15, 35, 17),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: kTextColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: kSearchHint.apply(color: kTextColor),
        decoration: InputDecoration(
          icon: const Icon(
              Fontisto.search ,
              color: Colors.grey,
              size: 15
          ),
          hintText: query.isEmpty ? 'Поиск фильмов' : query,
          hintStyle: kSearchHint,
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          setState(() {
            query = value;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
    );
  }
}