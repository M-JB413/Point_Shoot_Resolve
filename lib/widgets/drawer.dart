import "package:flutter/material.dart";
import "package:point_shoot_resolve/providers/user_provider.dart";
import "package:provider/provider.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const imageURL =
        "https://cdn4.vectorstock.com/i/thumb-large/23/88/person-gray-photo-placeholder-man-vector-23522388.jpg";
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Drawer(
          child: Container(
            color: const Color.fromARGB(255, 0, 0, 0), //If we want to add a background color
            child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  margin: EdgeInsets.zero,
                  // decoration: BoxDecoration(
                  //   color: Colors.black
                  // ),
                  accountName: Text(
                    "${authProvider.getUser()!.name}",
                    style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.white),
                  ),
                  accountEmail: Text(
                    "${authProvider.getUser()!.emailID}",
                    style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.white),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    // child: Image.network(imageURL)
                    backgroundImage: NetworkImage(imageURL),
                  ),
                )
              ),
              const ListTile(
                leading: Icon(Icons.home_filled, color: Color.fromARGB(255, 255, 255, 255)),
                title: Text(
                  "Home",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
              ),
              const ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  "Profile",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
              ),
              const ListTile(
                leading: Icon(Icons.email, color: Colors.white),
                title: Text(
                  "Email Me",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
              )
            ],
              ),
          )),
    );
  }
}
