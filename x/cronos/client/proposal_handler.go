package client

import (
	govclient "github.com/cosmos/cosmos-sdk/x/gov/client"

	"github.com/monk07-01/bfhevm/x/cronos/client/cli"
	"github.com/monk07-01/bfhevm/x/cronos/client/rest"
)

// ProposalHandler is the token mapping change proposal handler.
var ProposalHandler = govclient.NewProposalHandler(cli.NewSubmitTokenMappingChangeProposalTxCmd, rest.ProposalRESTHandler)
