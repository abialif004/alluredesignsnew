import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
      child: Drawer(
        child: Container(
          color: Color(0xFF626ABB),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF626ABB),
                ),
                accountName: Text(
                  "Anandhu PA",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                accountEmail: Text(
                  "appus97461@gmail.com",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                currentAccountPicture: CircleAvatar(),
              ),
              SizedBox(
                height: 60.0,
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  title: Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.brightness_6,
                    color: Color(0xFFFFFFFF),
                  ),
                  trailing: Transform.scale(
                    scale: 1,
                    child: Switch(
                      onChanged: toggleSwitch,
                      value: isSwitched,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.blue,
                      inactiveThumbColor: Colors.blue,
                      inactiveTrackColor: Colors.white,
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  title: Text(
                    "Category",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.category,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  title: Text(
                    "My Orders",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  title: Text(
                    "Wishlist",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  title: Text(
                    "Shopping Cart",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      title: Text(
                        "About Us",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Icon(
                        Icons.help_outline,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    title: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
