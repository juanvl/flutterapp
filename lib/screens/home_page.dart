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
  bool _isLoading = true;
  bool _isLoadingAddUser = false;

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

      setState(() {
        _items = result;
      });
    }
    _isLoading = false;
  }

  void _showError(ScaffoldState scaffold, String errorMsg) {
    scaffold.showSnackBar(
      SnackBar(
        content: Text(errorMsg),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void addUser(scaffold) async {
    setState(() {
      _isLoadingAddUser = true;
    });

    final response =
        await http.get('https://api.github.com/users/${_usernameInput.text}');

    if (response.statusCode == 200) {
      final githubUser = GithubUser.fromJson(
        json.decode(response.body),
      );
      setState(() {
        _items.add(githubUser);
        _isLoadingAddUser = false;
        _usernameInput.text = '';

        save();
      });
    } else {
      setState(() {
        _isLoadingAddUser = false;
        _usernameInput.text = '';
      });
      _showError(scaffold, 'Usuário não encontrado!');
    }
  }

  void removeUser(scaffold, index) async {
    setState(() {
      _items.removeAt(index);

      save();
    });

    scaffold
        .showSnackBar(SnackBar(content: Text("Usuário removido da lista.")));
  }

  @override
  Widget build(BuildContext context) {
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
                        fillColor: Color(0xFFE7E7E7),
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
                    child: Builder(
                      builder: (context) => FlatButton(
                        child: _isLoadingAddUser
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                height: 20,
                                width: 20,
                              )
                            : Icon(Icons.add),
                        onPressed: () {
                          addUser(Scaffold.of(context));
                        },
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (BuildContext cxt, int index) {
                      final item = _items[index];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          removeUser(Scaffold.of(cxt), index);
                        },
                        background: Container(color: Colors.red),
                        child: UserListItem(item: item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
