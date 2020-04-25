import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isloading = false;

  @override
  void initState() {
//    _isloading = true;
//    Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
//      setState(() {
//        _isloading = false;
//      });
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Order'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnapShot) {
              if (dataSnapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapShot.error != null) {
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else
                  return Consumer<Orders>(
                    builder: (ctx, ordersData, child) => ListView.builder(
                      itemCount: ordersData.order.length,
                      itemBuilder: (ctx, i) => OrderItem(ordersData.order[i]),
                    ),
                  );
              }
            }));
  }
}
