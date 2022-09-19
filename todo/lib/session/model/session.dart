import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/session/wallet_connect_ethereum_credentials.dart';

part 'session.freezed.dart';

@freezed
class Session with _$Session {
  factory Session({
    WalletConnectEthereumCredentials? credentials,
    @Default(false) bool isLoading,
  }) = _Session;
}
