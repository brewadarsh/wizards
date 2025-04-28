import "dart:math";

import "package:openid_client/openid_client_io.dart";
import "package:universal_html/html.dart" as html;

import "../../domain/entities/credential_entity.dart";

abstract interface class IAuthenticationService {
  Future<bool> validateAccessToken();
  Future<void> getAuthCode();
  Future<void> getAccessToken();
  Future<void> logout();
}

/// Authentication based on Keycloak OIDC.
final class KeycloakAuthenticationService implements IAuthenticationService {
  // Storage Keys.
  static const String kToken = "auth_token";
  static const String kAuthState = "auth_state";
  static const String kRefreshToken = "refresh_token";
  static const String kCodeVerifier = "code_verifier";
  static const String kAuthResponseCallback = "auth_response_callback";

  @override
  Future<bool> validateAccessToken() async {
    final String? token = html.window.sessionStorage[kToken];
    final bool isExpired = CredentialEntity.isExpired(token ?? "");
    if (!isExpired) return true;
    // TODO: Refresh the token.
    throw UnimplementedError();
  }

  @override
  Future<void> getAuthCode() async {
    final Flow flow = await createAuthenticationFlow();
    flow.redirectUri = Uri.parse(redirect);
    // Redirect the authentication portal.
    html.window.location.href = flow.authenticationUri.toString();
    return;
  }

  @override
  Future<void> getAccessToken() async {
    try {
      final Uri uri = Uri.parse(
        html.window.sessionStorage[kAuthResponseCallback] ?? "",
      );
      final Flow flow = await createAuthenticationFlow();
      flow.redirectUri = Uri.parse(redirect);
      final Credential credential = await flow.callback(uri.queryParameters);
      final UserInfo _ = await credential.getUserInfo();
    } finally {
      html.window.sessionStorage.remove(kAuthState);
      html.window.sessionStorage.remove(kCodeVerifier);
      html.window.sessionStorage.remove(kAuthResponseCallback);
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

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
    final StringBuffer buffer = StringBuffer();
    buffer.write("${html.window.location.protocol}//");
    buffer.write(html.window.location.host);
    buffer.write(html.window.location.pathname);
    return buffer.toString();
  }

  /// Create the authentication flow.
  Future<Flow> createAuthenticationFlow() async {
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
    return Flow.authorizationCodeWithPKCE(
      client,
      state: authState,
      codeVerifier: codeVerifier,
      scopes: ['openid', 'profile', 'email', 'offline_access'],
    );
  }
}
