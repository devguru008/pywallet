#!/usr/bin/env bash
export HOME=~
set -eux pipefail
cd
rm -rf $HOME/pywalletx_db
mkdir $HOME/pywalletx_db
COST_SOFT_LIMIT=0 COST_HARD_LIMIT=0 COIN=BitcoinSegwit SERVICES=tcp://:51001,rpc:// NET=regtest DAEMON_URL=http://doggman:donkey@127.0.0.1:18554 DB_DIRECTORY=$HOME/pywalletx_db DAEMON_POLL_INTERVAL_BLOCKS=100 DAEMON_POLL_INTERVAL_MEMPOOL=100 pywalletx_server
