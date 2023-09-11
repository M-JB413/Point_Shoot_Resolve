import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OAuthConfig {
  static AadOAuth createMicrosoftOAuth(GlobalKey<NavigatorState> navigatorKey) {
    final Config configWithNavigatorKey = Config(
      tenant: 'common',
      clientId: dotenv.get("CLIENT_ID"), //dotenv.env["CLIENT_ID"].toString()
      scope: dotenv.get("SCOPE") ,//dotenv.env["SCOPE"].toString(),
      redirectUri: dotenv.get("REDIRECT_URI") ,//dotenv.env["REDIRECT_URI"].toString(),
      navigatorKey: navigatorKey,
      // Add other necessary properties here
    );
    
    return AadOAuth(configWithNavigatorKey);
  }
}
