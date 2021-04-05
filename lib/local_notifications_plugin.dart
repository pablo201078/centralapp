import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


 //const platform = const MethodChannel('com.centralapp.central_app/localtime');

//final BehaviorSubject<String> selectNotificationSubject =
//   BehaviorSubject<String>();

//final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//    BehaviorSubject<ReceivedNotification>();

/*
void configureDidReceiveLocalNotificationSubject(BuildContext context) {
  didReceiveLocalNotificationSubject.stream
      .listen((ReceivedNotification receivedNotification) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: receivedNotification.title != null
            ? Text(receivedNotification.title)
            : null,
        content: receivedNotification.body != null
            ? Text(receivedNotification.body)
            : null,
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              // Navigator.of(context, rootNavigator: true).pop();
              /* await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      SecondScreen(receivedNotification.payload),
                ),
              );*/
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  });
}
*/

/*
void configureSelectNotificationSubject(BuildContext context, int idCliente) {
  selectNotificationSubject.stream.listen((String payload) async {
    debugPrint('toque la notificacion');
    Navigator.pushNamed(context, '/pedidos',
        arguments: {'idCliente': idCliente});
    /*await Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => SecondScreen(payload)),
    );*/
  });
}
*/

/*
Future<void> configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
  print(timeZoneName);
//  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
*/


Future<void> mostrarAvancePedidos(String mensaje, String payload) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'centralapp-0', 'Pedidos', 'Progreso de tus Pedidos',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(
      0,
      'Central App',
      mensaje,
      DateTime.now().add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      //uiLocalNotificationDateInterpretation:
       //   UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload);
}

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

Future onSelectNotificacion(String payload) async {
  print('notificacion: $payload');
//selectNotificationSubject.add(payload);
}
*/