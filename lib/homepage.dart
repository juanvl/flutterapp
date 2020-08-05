import 'package:flutter/material.dart';
import 'package:flutterapp/Models/Item.dart';

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items.add(
      Item(
        name: "Juan Victor",
        bio: 'blablabla blabla blabla',
        avatar_url: 'https://avatars2.githubusercontent.com/u/29025963?v=4',
        login: 'juanvl',
      ),
    );
    items.add(
      Item(
        name: "Juan Victor",
        bio: 'blablabla blabla blabla',
        avatar_url: 'https://avatars2.githubusercontent.com/u/29025963?v=4',
        login: 'juanvl',
      ),
    );
    items.add(
      Item(
        name: "Juan Victor",
        bio: 'blablabla blabla blabla',
        avatar_url: 'https://avatars2.githubusercontent.com/u/29025963?v=4',
        login: 'juanvl',
      ),
    );
    items.add(
      Item(
        name: "Juan Victor",
        bio: 'blablabla blabla blabla',
        avatar_url: 'https://avatars2.githubusercontent.com/u/29025963?v=4',
        login: 'juanvl',
      ),
    );
    items.add(
      Item(
        name: "Juan Victor",
        bio: 'blablabla blabla blabla',
        avatar_url: 'https://avatars2.githubusercontent.com/u/29025963?v=4',
        login: 'juanvl',
      ),
    );
    items.add(
      Item(
        name: "Juan Victor",
        bio: 'blablabla blabla blabla',
        avatar_url: 'https://avatars2.githubusercontent.com/u/29025963?v=4',
        login: 'juanvl',
      ),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Users'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Adicionar usuário'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext cxt, int index) {
                final item = widget.items[index];
                return Card(
                  child: Column(children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        item.avatar_url,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Text(
                      "${item.name} (${item.login})",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(item.bio),
                    FlatButton(
                      child: const Text('Ver Perfil'),
                      onPressed: () {},
                    ),
                  ]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
