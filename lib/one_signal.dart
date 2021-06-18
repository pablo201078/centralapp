import 'dart:io';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get/get.dart';
import 'keys.dart';

final APP_ID = Keys().oneSignalApiKey;

void inicializarOneSignal() async {
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  if (Platform.isAndroid || Platform.isIOS) {
    // OneSignal.shared.setAppId(APP_ID);

    OneSignal.shared.init(APP_ID, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setNotificationOpenedHandler(abrirNotificacion);
  }
}

void abrirSesionOneSignal(int idCliente, String hash) async {
  if (Platform.isAndroid || Platform.isIOS) {
    print('oneSignal init: $idCliente - $hash');
    OneSignal.shared.setExternalUserId(idCliente.toString(), hash ?? '');
  }
}

void cerrarSesionOneSignal() {
  OneSignal.shared.removeExternalUserId();
}

void abrirNotificacion(OSNotificationOpenedResult result) {
  //esto campos que estan en additionalData los creo yo desde el server
  // Map<String, dynamic> datos = result.notification.additionalData;
  Map<String, dynamic> datos = result.notification.payload.additionalData;
  int idTipo = datos['idTipo'];
  int idItem = datos['idItem'];

  if (idTipo == 1) {
    //un pedido
    Get.toNamed(
      '/pedido_detalle',
      arguments: {'idPedido': idItem},
    );
    return;
  }
  if (idTipo == 2) {
    //ticket
    Get.toNamed('/ticket');
    return;
  }
  if (idTipo == 3) {
    //ver un producto
    Get.toNamed(
      '/articulo_detalle',
      arguments: {'idArticulo': idItem},
    );
    return;
  }
}
