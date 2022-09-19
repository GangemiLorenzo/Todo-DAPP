import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants.dart';
import 'package:todo/main.dart';
import 'package:todo/session/model/session.dart';
import 'package:todo/session/wallet_connect_ethereum_credentials.dart';
import 'package:todo/web3_service.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier, Session>((ref) {
  final web3 = ref.watch(web3ServiceProvider);
  return SessionNotifier(
    web3: web3,
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  );
});

class SessionNotifier extends StateNotifier<Session> {
  SessionNotifier({
    required this.web3,
    required this.sharedPreferences,
  }) : super(Session()) {
    final current = web3.getConnector().session;
    if (current.connected) {
      state = Session(
        credentials: WalletConnectEthereumCredentials(
          metamaskUri: sharedPreferences.getString(METAMASK_URI) ?? '',
          provider: EthereumWalletConnectProvider(web3.getConnector()),
        ),
      );
    }
  }

  final Web3Service web3;
  final SharedPreferences sharedPreferences;

  Future<void> loginWithMetamask() async {
    final connector = web3.getConnector();
    if (!connector.connected) {
      try {
        state = state.copyWith(isLoading: true);

        await connector.createSession(onDisplayUri: (uri) async {
          await sharedPreferences.setString(METAMASK_URI, uri);
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        }).timeout(
          const Duration(seconds: 15),
        ); //Added a timeout to avoid getting stuck when walletconnect doesn't return promise

        final provider = EthereumWalletConnectProvider(connector);
        state = state.copyWith(
          credentials: WalletConnectEthereumCredentials(
            provider: provider,
            metamaskUri: sharedPreferences.getString(METAMASK_URI)!,
          ),
          isLoading: false,
        );
      } catch (e) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> disconnect() async {
    state = state.copyWith(isLoading: true);
    final connector = web3.getConnector();
    await connector.killSession();
    state = Session();
  }
}
