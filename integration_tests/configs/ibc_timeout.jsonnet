local ibc = import 'ibc.jsonnet';

ibc {
  'bfhevm_777-1'+: {
    genesis+: {
      app_state+: {
        cronos+: {
          params+: {
            ibc_timeout: 0,
          },
        },
      },
    },
  },
}
