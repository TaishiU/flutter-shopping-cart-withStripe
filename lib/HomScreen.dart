import 'package:flutter/material.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  _HomScreenState createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  Map group = {
    0: {
      'brand': 'Nike',
      'logo':
          'https://freepngimg.com/thumb/nike_logo/6-2-nike-logo-free-png-image-thumb.png'
    },
    1: {
      'brand': 'Adidas',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/2/24/Adidas_logo.png'
    },
    2: {
      'brand': 'Puma',
      'logo': 'http://assets.stickpng.com/images/580b57fcd9996e24bc43c4f8.png'
    },
    3: {
      'brand': 'New Balance',
      'logo':
          'https://logos-world.net/wp-content/uploads/2020/09/New-Balance-Logo-1972-2006.png'
    },
  };
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Shoes',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 90,
              color: Colors.transparent,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: group.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectedIndex == index
                                    ? Colors.orange
                                    : Colors.grey.shade100,
                                image: DecorationImage(
                                  image: NetworkImage(group[index]['logo']),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              group[index]['brand'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 30,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
