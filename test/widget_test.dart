import 'package:flutter_test/flutter_test.dart';

import 'package:bezier_curve/main.dart';

void main() {
  testWidgets('renders home service dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Home Service'), findsWidgets);
    expect(find.text('Popular Services'), findsOneWidget);
    expect(find.text('Upcoming Bookings'), findsOneWidget);
    expect(find.text('Book Service'), findsOneWidget);
    expect(find.text('Cleaning'), findsOneWidget);
  });
}
