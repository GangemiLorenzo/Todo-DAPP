import 'package:walletconnect_dart/walletconnect_dart.dart';

const BRIDGE = 'https://bridge.walletconnect.org';

const NAME_META = 'Todo-dapp';
const DESCRIPTION_META = 'A Todo app over the ETH network';
const URL_META = 'https://walletconnect.org';
const ICON_META =
    'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media';

const CLIENT_META = PeerMeta(
    name: NAME_META,
    description: DESCRIPTION_META,
    url: URL_META,
    icons: [ICON_META]);

const METAMASK_URI = 'metamask.uri';
