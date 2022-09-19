import 'dart:typed_data';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials(
      {required this.provider, required this.metamaskUri});

  final EthereumWalletConnectProvider provider;
  final String metamaskUri;

  @override
  Future<EthereumAddress> extractAddress() => Future(
      () => EthereumAddress.fromHex(provider.connector.session.accounts.first));

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final from = await this.extractAddress();
    launchUrlString(metamaskUri, mode: LaunchMode.externalApplication);
    final hash = await provider.sendTransaction(
      from: from.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
