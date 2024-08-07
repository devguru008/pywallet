import os

from . import PywalletTestCase

from pywallet.simple_config import SimpleConfig
from pywallet.wallet import restore_wallet_from_text, Abstract_Wallet
from pywallet.daemon import Daemon


class TestContacts(PywalletTestCase):
    TESTNET = True

    def setUp(self):
        super().setUp()
        self.config = SimpleConfig({'pywallet_path': self.pywallet_path})
        self.wallet_path = os.path.join(self.pywallet_path, "somewallet1")

    async def test_saving_contacts(self):
        text = 'cross end slow expose giraffe fuel track awake turtle capital ranch pulp'
        d = restore_wallet_from_text(text, path=self.wallet_path, gap_limit=2, config=self.config)
        w = d['wallet']  # type: Abstract_Wallet
        w.contacts["myNNuLYNgHE92nGQuJd5mXo6gy9gKXEDyQ"] = ("address", "alice")
        w.contacts["tb1q4syjltptqwhe62t3u5gwz9nsw87kmcwx003z05"] = ("address", "bob")
        self.assertEqual(2, len(w.contacts))
        await w.stop()
        del w
        # re-open wallet from disk
        w = Daemon._load_wallet(self.wallet_path, password=None, config=self.config)
        self.assertEqual(2, len(w.contacts))
        w.contacts["n4STqqWPrvkapAyvXY2wJzfoKMnuJbDWoH"] = ("address", "carol")
        self.assertEqual(3, len(w.contacts))
