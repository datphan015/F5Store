import 'package:flutter/material.dart';
import 'package:flutter_doanlt/notification/notificationItem.dart';

class NotificationScreen extends StatelessWidget {
  final Map<String, List<NotificationItem>> notifications = {
    'Hôm nay': [
      NotificationItem(
        imageUrl: 'assets/images/nike_blazer_mid.png',
        description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
        price: '365.950đ',
        time: '6 phút trước',
      ),
      NotificationItem(
        imageUrl: 'assets/images/nike_air_dunk.png',
        description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
        price: '450.950đ',
        time: '26 phút trước',
      ),
    ],
    'Hôm qua': [
      NotificationItem(
        imageUrl: 'assets/images/nike_air_jordan.png',
        description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
        price: '365.95đ',
        time: '4 ngày trước',
      ),
      NotificationItem(
        imageUrl: 'assets/images/nike_air_force.png',
        description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
        price: '365.95đ',
        time: '4 ngày trước',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Color(0xFF6699CC),
            hoverColor: Color(0xFF6699CC),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Center(
            child: Text(
              'Thông báo',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            child: InkWell(
              onTap: () {},
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.delete, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: notifications.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            ...entry.value
                                .map((notification) => NotificationCard(
                                    notification: notification))
                                .toList(),
                            SizedBox(height: 20),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFC5D3F9),
            ),
            child: Image.asset(
              notification.imageUrl,
              height: 75,
              width: 75,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notification.description,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: notification.time.contains('phút')
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    width: 10,
                    height: 10,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                notification.price,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(height: 4),
              Text(
                notification.time,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
