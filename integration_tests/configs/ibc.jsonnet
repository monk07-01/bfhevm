local config = import 'default.jsonnet';

config {
  'bfhevm_777-1'+: {
    'account-prefix': 'bfh',
    'coin-type': 60,
    key_name: 'signer1',
  },
  'chainmain-1': {
    cmd: 'bfhevmd',
    'start-flags': '--trace',
    'account-prefix': 'bfh',
    'app-config': {
      'minimum-gas-prices': '500basebfh',
    },
    validators: [
      {
        coins: '2234240000000000000abfh',
        staked: '10000000000000abfh',
        mnemonic: '${VALIDATOR1_MNEMONIC}',
        base_port: 26800,
      },
      {
        coins: '987870000000000000abfh',
        staked: '20000000000000abfh',
        mnemonic: '${VALIDATOR2_MNEMONIC}',
        base_port: 26810,
      },
    ],
    accounts: [
      {
        name: 'community',
        coins: '10000000000000abfh',
        mnemonic: '${COMMUNITY_MNEMONIC}',
      },
      {
        name: 'relayer',
        coins: '10000000000000abfh',
        mnemonic: '${SIGNER1_MNEMONIC}',
      },
      {
        name: 'signer2',
        coins: '10000000000000abfh',
        mnemonic: '${SIGNER2_MNEMONIC}',
      },
    ],
    genesis: {
      app_state: {
        staking: {
          params: {
            unbonding_time: '1814400s',
          },
        },
        gov: {
          voting_params: {
            voting_period: '1814400s',
          },
          deposit_params: {
            max_deposit_period: '1814400s',
            min_deposit: [
              {
                denom: 'basebfh',
                amount: '10000000',
              },
            ],
          },
        },
        transfer: {
          params: {
            receive_enabled: true,
            send_enabled: true,
          },
        },
        interchainaccounts: {
          host_genesis_state: {
            params: {
              allow_messages: [
                '/cosmos.bank.v1beta1.MsgSend',
              ],
            },
          },
        },
      },
    },
  },
  relayer: {
    global: {
      strategy: 'all',
    },
    rest: {
      enabled: true,
      host: '127.0.0.1',
      port: 3000,
    },
    chains: [
      {
        id: 'bfhevm_777-1',
        address_type: {
          derivation: 'ethermint',
          proto_type: {
            pk_type: '/ethermint.crypto.v1.ethsecp256k1.PubKey',
          },
        },
        max_gas: 500000,
        gas_price: {
          price: 10000000000000,
          denom: 'basebfh',
        },
      },
      {
        id: 'chainmain-1',
        gas_price: {
          price: 1000000,
          denom: 'basebfh',
        },
      },
    ],
  },
}
