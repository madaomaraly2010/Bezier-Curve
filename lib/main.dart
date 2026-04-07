import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Service',
      theme: ThemeData(
        primaryColor: Color(0xFF115173),
        scaffoldBackgroundColor: Color(0xFFF3F6FA),
        fontFamily: 'Roboto',
      ),
      home: HomeServicePage(),
    );
  }
}

class HomeServicePage extends StatelessWidget {
  final List<ServiceItem> services = [
    ServiceItem('Cleaning', Icons.cleaning_services, Color(0xFF4F46E5)),
    ServiceItem('Plumbing', Icons.plumbing, Color(0xFF0EA5E9)),
    ServiceItem('Electrical', Icons.electrical_services, Color(0xFFF59E0B)),
    ServiceItem('Painting', Icons.format_paint, Color(0xFF10B981)),
  ];

  final List<BookingItem> upcoming = [
    BookingItem(
      title: 'Deep Cleaning',
      provider: 'Sparkle Home Pros',
      date: 'Tue, Apr 7 • 10:00 AM',
      status: 'Confirmed',
    ),
    BookingItem(
      title: 'Kitchen Plumbing',
      provider: 'RapidFix Plumbing',
      date: 'Thu, Apr 9 • 1:30 PM',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Home Service',
          style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF0F172A)),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeroCard(),
              SizedBox(height: 24),
              Text(
                'Popular Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 12),
              GridView.builder(
                itemCount: services.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.35,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return _ServiceCard(item: services[index]);
                },
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Upcoming Bookings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Color(0xFF115173),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),
              Column(
                children: upcoming
                    .map((booking) => _BookingCard(booking: booking))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Color(0xFF115173),
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF115173),
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('Book Service'),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(0xFF115173), Color(0xFF1D6FA5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Need a trusted pro today?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Book verified professionals for cleaning, repairs, and more.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
          SizedBox(height: 16),
          RaisedButton(
            color: Colors.white,
            textColor: Color(0xFF115173),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {},
            child: Text('Find Services'),
          )
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceItem item;

  const _ServiceCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: item.color.withOpacity(0.15),
            child: Icon(item.icon, color: item.color),
          ),
          Text(
            item.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          )
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingItem booking;

  const _BookingCard({Key key, this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isConfirmed = booking.status == 'Confirmed';

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFE6F0F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.home_repair_service, color: Color(0xFF115173)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  booking.title,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  booking.provider,
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 4),
                Text(
                  booking.date,
                  style: TextStyle(color: Color(0xFF115173), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isConfirmed ? Color(0xFFD1FAE5) : Color(0xFFFFF7D6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              booking.status,
              style: TextStyle(
                fontSize: 12,
                color: isConfirmed ? Color(0xFF047857) : Color(0xFF92400E),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ServiceItem {
  final String name;
  final IconData icon;
  final Color color;

  ServiceItem(this.name, this.icon, this.color);
}

class BookingItem {
  final String title;
  final String provider;
  final String date;
  final String status;

  BookingItem({this.title, this.provider, this.date, this.status});
}
