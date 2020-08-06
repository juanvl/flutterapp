import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutterapp/models/github_user.dart';
import 'package:flutterapp/widgets/user_list_item.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _items = new List<GithubUser>();
  final TextEditingController _usernameInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('userlist', jsonEncode(_items));
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('userlist');
    if (data != null) {
      Iterable decoded = jsonDecode(data);

      List<GithubUser> result =
          decoded.map((x) => GithubUser.fromJson(x)).toList();
      print(result);

      setState(() {
        _items = result;
      });
    }
  }

  void addUser() async {
    final response =
        await http.get('https://api.github.com/users/${_usernameInput.text}');

    if (response.statusCode == 200) {
      final githubUser = GithubUser.fromJson(
        json.decode(response.body),
      );
      setState(() {
        _items.add(githubUser);
        save();
      });
    } else {
      throw Exception('Usuário não encontrado!');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('builddddd');
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Users'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller: _usernameInput,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        filled: true,
                        fillColor: Color(0xFFDDDDDD),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Adicionar usuário',
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 20,
                  height: 40,
                  padding: EdgeInsets.all(8),
                  child: FlatButton(
                    child: Icon(Icons.add),
                    onPressed: addUser,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext cxt, int index) {
                final item = _items[index];
                return UserListItem(item: item);
              },
            ),
          )
        ],
      ),
    );
  }
}
