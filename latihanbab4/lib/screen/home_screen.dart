import 'package:flutter/material.dart';
import 'package:latihanbab4/screen/detail_screen.dart';
import 'package:latihanbab4/screen/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //Data berita statis
  final List<Map<String, String>> news = [
    {
      'imageUrl':
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': 'Russian warship: Moskva sinks in Black Sea',
      'author': 'arhy',
      'description':
      'Ini adalah desrkipsi',
      'time': '4h ago',
    },
    {
      'imageUrl':
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': 'Russian warship: Moskva sinks in Black Sea',
      'author': 'arhy',
      'description':
      'Ini adalah desrkipsi',
      'time': '2h ago',
    },
    {
      'imageUrl':
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': 'Russian warship: Moskva sinks in Black Sea',
      'author': 'arhy',
      'description':
      'Ini adalah desrkipsi',
      'time': '1h ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    //halaman yang akan ditampikan di index stack
    final List<Widget> pages = [
      //page home dengan dftr berita menggunakan listviewbuilder
      ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      Title: news[index]['title'].toString(),
                      description:
                      news[index]['description'].toString(),
                      imageUrl: news[index]['imageUrl'].toString(), title: '',
                    ),
                  )
                );
              },
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      news[index][
                        'imageUrl']!,
                      fit: BoxFit.cover,
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news[index]['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        news[index]['author']! + " * " + news[index]['time']!,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      Center(child: Text('Explore Page')), 
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'HMTI',
              style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'News',
                style: TextStyle(
                  color: Color(0xFF1877F2),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              )
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Pengaturan', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                color: Color(0xFF1877F2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ...pages,
          EditProfileScreen(),//halaman Profil
          EditProfileScreen(),//halaman Profil
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF1877F2),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

