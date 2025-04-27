import "dart:convert";
import "dart:math";
import "dart:typed_data";

import "package:crypto/crypto.dart" as crypto;
import "package:openid_client/openid_client_io.dart";
import "package:universal_html/html.dart" as html;

abstract interface class IAuthenticationService {
  /// Authentication the user.
  Future<void> authenticate();

  /// Logout the user.
  Future<void> logout();
}

/// Authentication based on Keycloak OIDC.
final class KeycloakAuthenticationService implements IAuthenticationService {
  @override
  Future<void> authenticate() async {
    // Create the discovery uri.
    final Uri discoveryUri = Uri.parse("$authUrl/realms/$realm");

    // Discover the token and authorization endpoints.
    final Issuer issuer = await Issuer.discover(discoveryUri);

    // P.C.K.E parameters.
    final String codeVerifier = storageRead(kCodeVerifier, () {
      return secureRandomCode(128);
    });
    final String authState = storageRead(kAuthState, () {
      return secureRandomCode(32);
    });

    // The client application.
    final Client client = Client(issuer, clientId);

    // Trigger the P.C.K.E flow.
    final Flow flow = Flow.authorizationCodeWithPKCE(
      client,
      state: authState,
      codeVerifier: codeVerifier,
      scopes: ['profile', 'email', 'offline_access'],
    );
    flow.redirectUri = Uri.parse(redirect);

    final String? callback = html.window.sessionStorage[kAuthResponseCallback];
    if (callback != null) {
      final Uri callbackUri = Uri.parse(callback);
      final Credential credential = await flow.callback(
        callbackUri.queryParameters,
      );
      print(credential);
      return;
    }
    html.window.location.href = flow.authenticationUri.toString();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  // Keys.
  static const String kToken = "auth_token";
  static const String kAuthState = "auth_state";
  static const String kRefreshToken = "refresh_token";
  static const String kCodeVerifier = "code_verifier";
  static const String kCodeChallenge = "code_challenge";
  static const String kAuthResponseCallback = "auth_response_callback";

  /// The concerned realm.
  static const String realm = String.fromEnvironment("realm");

  /// The keycloak host url.
  static const String authUrl = String.fromEnvironment("auth_url");

  /// The current application's client ID.
  static const String clientId = String.fromEnvironment("client_id");

  /// The secure random code generator.
  static final Random secureRandomGen = Random.secure();

  /// Generate a secure random code (String).
  String secureRandomCode(final int length) {
    final StringBuffer buffer = StringBuffer();
    for (int index = 0; index < length; index++) {
      final int type = secureRandomGen.nextInt(3);
      final int charCode;
      switch (type) {
        case 0: // Type is digits. ASCII value 48 to 57.
          charCode = secureRandomGen.nextInt(10) + 48;
        case 1: // Type is lowercase alphabets. ASCII value 65-90
          charCode = secureRandomGen.nextInt(26) + 65;
        default: // case 1: // Type is uppercase alphabets. ASCII value 97-122
          charCode = secureRandomGen.nextInt(26) + 97;
      }
      buffer.write(String.fromCharCode(charCode));
    }
    return buffer.toString();
  }

  /// Generate a SHA-256 based code challenge of the code verifier.
  String codeChallenge(String verifier) {
    final Uint8List bytes = utf8.encode(verifier);
    final crypto.Digest digest = crypto.sha256.convert(bytes);
    return base64Url
        .encode(digest.bytes)
        .replaceAll('=', '')
        .replaceAll('+', '-')
        .replaceAll('/', '_');
  }

  /// Read values from storage.
  String storageRead(final String key, String Function() fallback) {
    final String? stored = html.window.sessionStorage[key];
    if (stored != null) return stored;
    final String computed = fallback();
    html.window.sessionStorage[key] = computed;
    return computed;
  }

  /// The redirect-uri.
  String get redirect {
    return "http://localhost:3000";
  }

  /// Assert valid auth state.
  String assertAuthState(final String? state) {
    final String? stored = html.window.sessionStorage[kAuthState];
    if (state == null || stored != state) {
      throw StateError("Invalid state error!");
    }
    return state;
  }

  /// Assert code.
  String assertCode(final String? code) {
    if (code != null) return code;
    throw StateError("Invalid Authorization code!");
  }
}
