import 'dart:io';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get/get.dart';

const APP_ID = "4fc09c65-34e7-483b-ab14-15dbb8343add";

void inicializarOneSignal() async {
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  if (Platform.isAndroid || Platform.isIOS) {
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
}
