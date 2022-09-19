import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:todo/constants.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';

final web3ServiceProvider = Provider<Web3Service>((ref) {
  return Web3Service();
});

class Web3Service {
  late Web3Client _ethClient;
  late WalletConnect _connector;
  late WalletConnectSession? _oldSession;

  initialSetup() async {
    _initClient();
    await _initConnector();
  }

  void _initClient() {
    var httpClient = Client();
    _ethClient = Web3Client(dotenv.env['RPC_ENDPOINT']!, httpClient);
  }

  Future<void> _initConnector() async {
    final sessionStorage = WalletConnectSecureStorage();
    _oldSession = await sessionStorage.getSession();
    _connector = WalletConnect(
      bridge: BRIDGE,
      session: _oldSession,
      sessionStorage: sessionStorage,
      clientMeta: CLIENT_META,
    );

    _connector.on('connect', (session) => print(session));
    _connector.on('disconnect', (session) => print('Disconnected'));
  }

  Web3Client getEthClient() => _ethClient;

  WalletConnect getConnector() => _connector;
}
