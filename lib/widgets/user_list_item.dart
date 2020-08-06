import 'package:flutter/material.dart';
import 'package:flutterapp/models/github_user.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final GithubUser item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              item.avatar_url,
              width: 60,
              height: 60,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: RichText(
              text: TextSpan(
                text: '${item.name}',
                style: TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' (${item.login})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              item.bio,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          FlatButton(
            child: const Text(
              'Ver Perfil',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
            color: Colors.deepPurple,
            textColor: Colors.white,
            padding: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ]),
      ),
    );
  }
}
