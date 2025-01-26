<!-- This file is auto-generated. Please do not modify it yourself. -->
# Protobuf Documentation
<a name="top"></a>

## Table of Contents

- [cronos/cronos.proto](#cronos/cronos.proto)
    - [Params](#cronos.Params)
    - [TokenMapping](#cronos.TokenMapping)
    - [TokenMappingChangeProposal](#cronos.TokenMappingChangeProposal)
  
- [cronos/genesis.proto](#cronos/genesis.proto)
    - [GenesisState](#cronos.GenesisState)
  
- [cronos/query.proto](#cronos/query.proto)
    - [ContractByDenomRequest](#cronos.ContractByDenomRequest)
    - [ContractByDenomResponse](#cronos.ContractByDenomResponse)
    - [DenomByContractRequest](#cronos.DenomByContractRequest)
    - [DenomByContractResponse](#cronos.DenomByContractResponse)
    - [ReplayBlockRequest](#cronos.ReplayBlockRequest)
    - [ReplayBlockResponse](#cronos.ReplayBlockResponse)
  
    - [Query](#cronos.Query)
  
- [cronos/tx.proto](#cronos/tx.proto)
    - [MsgConvertVouchers](#cronos.MsgConvertVouchers)
    - [MsgConvertVouchersResponse](#cronos.MsgConvertVouchersResponse)
    - [MsgTransferTokens](#cronos.MsgTransferTokens)
    - [MsgTransferTokensResponse](#cronos.MsgTransferTokensResponse)
    - [MsgUpdateTokenMapping](#cronos.MsgUpdateTokenMapping)
    - [MsgUpdateTokenMappingResponse](#cronos.MsgUpdateTokenMappingResponse)
  
    - [Msg](#cronos.Msg)
  
- [icactl/v1/params.proto](#icactl/v1/params.proto)
    - [Params](#icactl.v1.Params)
  
- [icactl/v1/genesis.proto](#icactl/v1/genesis.proto)
    - [GenesisState](#icactl.v1.GenesisState)
  
- [icactl/v1/query.proto](#icactl/v1/query.proto)
    - [QueryInterchainAccountAddressRequest](#icactl.v1.QueryInterchainAccountAddressRequest)
    - [QueryInterchainAccountAddressResponse](#icactl.v1.QueryInterchainAccountAddressResponse)
    - [QueryParamsRequest](#icactl.v1.QueryParamsRequest)
    - [QueryParamsResponse](#icactl.v1.QueryParamsResponse)
  
    - [Query](#icactl.v1.Query)
  
- [icactl/v1/tx.proto](#icactl/v1/tx.proto)
    - [MsgRegisterAccount](#icactl.v1.MsgRegisterAccount)
    - [MsgRegisterAccountResponse](#icactl.v1.MsgRegisterAccountResponse)
    - [MsgSubmitTx](#icactl.v1.MsgSubmitTx)
    - [MsgSubmitTxResponse](#icactl.v1.MsgSubmitTxResponse)
  
    - [Msg](#icactl.v1.Msg)
  
- [tokenfactory/v1/nft.proto](#tokenfactory/v1/nft.proto)
    - [BaseNFT](#tokenfactory.v1.BaseNFT)
    - [Collection](#tokenfactory.v1.Collection)
    - [Denom](#tokenfactory.v1.Denom)
    - [IDCollection](#tokenfactory.v1.IDCollection)
    - [Owner](#tokenfactory.v1.Owner)
  
- [tokenfactory/v1/genesis.proto](#tokenfactory/v1/genesis.proto)
    - [GenesisState](#tokenfactory.v1.GenesisState)
  
- [tokenfactory/v1/query.proto](#tokenfactory/v1/query.proto)
    - [QueryCollectionRequest](#tokenfactory.v1.QueryCollectionRequest)
    - [QueryCollectionResponse](#tokenfactory.v1.QueryCollectionResponse)
    - [QueryDenomByNameRequest](#tokenfactory.v1.QueryDenomByNameRequest)
    - [QueryDenomByNameResponse](#tokenfactory.v1.QueryDenomByNameResponse)
    - [QueryDenomRequest](#tokenfactory.v1.QueryDenomRequest)
    - [QueryDenomResponse](#tokenfactory.v1.QueryDenomResponse)
    - [QueryDenomsRequest](#tokenfactory.v1.QueryDenomsRequest)
    - [QueryDenomsResponse](#tokenfactory.v1.QueryDenomsResponse)
    - [QueryNFTRequest](#tokenfactory.v1.QueryNFTRequest)
    - [QueryNFTResponse](#tokenfactory.v1.QueryNFTResponse)
    - [QueryOwnerRequest](#tokenfactory.v1.QueryOwnerRequest)
    - [QueryOwnerResponse](#tokenfactory.v1.QueryOwnerResponse)
    - [QuerySupplyRequest](#tokenfactory.v1.QuerySupplyRequest)
    - [QuerySupplyResponse](#tokenfactory.v1.QuerySupplyResponse)
  
    - [Query](#tokenfactory.v1.Query)
  
- [tokenfactory/v1/tx.proto](#tokenfactory/v1/tx.proto)
    - [MsgBurnNFT](#tokenfactory.v1.MsgBurnNFT)
    - [MsgBurnNFTResponse](#tokenfactory.v1.MsgBurnNFTResponse)
    - [MsgEditNFT](#tokenfactory.v1.MsgEditNFT)
    - [MsgEditNFTResponse](#tokenfactory.v1.MsgEditNFTResponse)
    - [MsgIssueDenom](#tokenfactory.v1.MsgIssueDenom)
    - [MsgIssueDenomResponse](#tokenfactory.v1.MsgIssueDenomResponse)
    - [MsgMintNFT](#tokenfactory.v1.MsgMintNFT)
    - [MsgMintNFTResponse](#tokenfactory.v1.MsgMintNFTResponse)
    - [MsgTransferNFT](#tokenfactory.v1.MsgTransferNFT)
    - [MsgTransferNFTResponse](#tokenfactory.v1.MsgTransferNFTResponse)
  
    - [Msg](#tokenfactory.v1.Msg)
  
- [Scalar Value Types](#scalar-value-types)



<a name="cronos/cronos.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## cronos/cronos.proto



<a name="cronos.Params"></a>

### Params
Params defines the parameters for the cronos module.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `ibc_cro_denom` | [string](#string) |  |  |
| `ibc_timeout` | [uint64](#uint64) |  |  |
| `cronos_admin` | [string](#string) |  | the admin address who can update token mapping |
| `enable_auto_deployment` | [bool](#bool) |  |  |






<a name="cronos.TokenMapping"></a>

### TokenMapping
TokenMapping defines a mapping between native denom and contract


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom` | [string](#string) |  |  |
| `contract` | [string](#string) |  |  |






<a name="cronos.TokenMappingChangeProposal"></a>

### TokenMappingChangeProposal
TokenMappingChangeProposal defines a proposal to change one token mapping.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `title` | [string](#string) |  |  |
| `description` | [string](#string) |  |  |
| `denom` | [string](#string) |  |  |
| `contract` | [string](#string) |  |  |
| `symbol` | [string](#string) |  | only when updating cronos (source) tokens |
| `decimal` | [uint32](#uint32) |  |  |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->

 <!-- end services -->



<a name="cronos/genesis.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## cronos/genesis.proto



<a name="cronos.GenesisState"></a>

### GenesisState
GenesisState defines the cronos module's genesis state.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `params` | [Params](#cronos.Params) |  | params defines all the paramaters of the module. |
| `external_contracts` | [TokenMapping](#cronos.TokenMapping) | repeated |  |
| `auto_contracts` | [TokenMapping](#cronos.TokenMapping) | repeated | this line is used by starport scaffolding # genesis/proto/state this line is used by starport scaffolding # ibc/genesis/proto |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->

 <!-- end services -->



<a name="cronos/query.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## cronos/query.proto



<a name="cronos.ContractByDenomRequest"></a>

### ContractByDenomRequest
ContractByDenomRequest is the request type of ContractByDenom call


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom` | [string](#string) |  |  |






<a name="cronos.ContractByDenomResponse"></a>

### ContractByDenomResponse
ContractByDenomRequest is the response type of ContractByDenom call


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `contract` | [string](#string) |  |  |
| `auto_contract` | [string](#string) |  |  |






<a name="cronos.DenomByContractRequest"></a>

### DenomByContractRequest
DenomByContractRequest is the request type of DenomByContract call


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `contract` | [string](#string) |  |  |






<a name="cronos.DenomByContractResponse"></a>

### DenomByContractResponse
DenomByContractResponse is the response type of DenomByContract call


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom` | [string](#string) |  |  |






<a name="cronos.ReplayBlockRequest"></a>

### ReplayBlockRequest
ReplayBlockRequest


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `msgs` | [ethermint.evm.v1.MsgEthereumTx](#ethermint.evm.v1.MsgEthereumTx) | repeated | the eth messages in the block |
| `block_number` | [int64](#int64) |  |  |
| `block_hash` | [string](#string) |  |  |
| `block_time` | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="cronos.ReplayBlockResponse"></a>

### ReplayBlockResponse
ReplayBlockResponse


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `responses` | [ethermint.evm.v1.MsgEthereumTxResponse](#ethermint.evm.v1.MsgEthereumTxResponse) | repeated |  |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->


<a name="cronos.Query"></a>

### Query
Query defines the gRPC querier service.

| Method Name | Request Type | Response Type | Description | HTTP Verb | Endpoint |
| ----------- | ------------ | ------------- | ------------| ------- | -------- |
| `ContractByDenom` | [ContractByDenomRequest](#cronos.ContractByDenomRequest) | [ContractByDenomResponse](#cronos.ContractByDenomResponse) | ContractByDenom queries contract addresses by native denom | GET|/cronos/v1/contract_by_denom/{denom}|
| `DenomByContract` | [DenomByContractRequest](#cronos.DenomByContractRequest) | [DenomByContractResponse](#cronos.DenomByContractResponse) | DenomByContract queries native denom by contract address | GET|/cronos/v1/denom_by_contract/{contract}|
| `ReplayBlock` | [ReplayBlockRequest](#cronos.ReplayBlockRequest) | [ReplayBlockResponse](#cronos.ReplayBlockResponse) | ReplayBlock replay the eth messages in the block to recover the results of false-failed txs. | |

 <!-- end services -->



<a name="cronos/tx.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## cronos/tx.proto



<a name="cronos.MsgConvertVouchers"></a>

### MsgConvertVouchers
MsgConvertVouchers represents a message to convert ibc voucher coins to cronos evm coins.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `address` | [string](#string) |  |  |
| `coins` | [cosmos.base.v1beta1.Coin](#cosmos.base.v1beta1.Coin) | repeated |  |






<a name="cronos.MsgConvertVouchersResponse"></a>

### MsgConvertVouchersResponse
MsgConvertVouchersResponse defines the ConvertVouchers response type.






<a name="cronos.MsgTransferTokens"></a>

### MsgTransferTokens
MsgTransferTokens represents a message to transfer cronos evm coins through ibc.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `from` | [string](#string) |  |  |
| `to` | [string](#string) |  |  |
| `coins` | [cosmos.base.v1beta1.Coin](#cosmos.base.v1beta1.Coin) | repeated |  |






<a name="cronos.MsgTransferTokensResponse"></a>

### MsgTransferTokensResponse
MsgTransferTokensResponse defines the TransferTokens response type.






<a name="cronos.MsgUpdateTokenMapping"></a>

### MsgUpdateTokenMapping
MsgUpdateTokenMapping defines the request type


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `sender` | [string](#string) |  |  |
| `denom` | [string](#string) |  |  |
| `contract` | [string](#string) |  |  |
| `symbol` | [string](#string) |  | only when updating cronos (source) tokens |
| `decimal` | [uint32](#uint32) |  |  |






<a name="cronos.MsgUpdateTokenMappingResponse"></a>

### MsgUpdateTokenMappingResponse
MsgUpdateTokenMappingResponse defines the response type





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->


<a name="cronos.Msg"></a>

### Msg
Msg defines the Cronos Msg service

this line is used by starport scaffolding # proto/tx/rpc

| Method Name | Request Type | Response Type | Description | HTTP Verb | Endpoint |
| ----------- | ------------ | ------------- | ------------| ------- | -------- |
| `ConvertVouchers` | [MsgConvertVouchers](#cronos.MsgConvertVouchers) | [MsgConvertVouchersResponse](#cronos.MsgConvertVouchersResponse) | ConvertVouchers defines a method for converting ibc voucher to cronos evm coins. | |
| `TransferTokens` | [MsgTransferTokens](#cronos.MsgTransferTokens) | [MsgTransferTokensResponse](#cronos.MsgTransferTokensResponse) | TransferTokens defines a method to transfer cronos evm coins to another chain through IBC | |
| `UpdateTokenMapping` | [MsgUpdateTokenMapping](#cronos.MsgUpdateTokenMapping) | [MsgUpdateTokenMappingResponse](#cronos.MsgUpdateTokenMappingResponse) | UpdateTokenMapping defines a method to update token mapping | |

 <!-- end services -->



<a name="icactl/v1/params.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## icactl/v1/params.proto



<a name="icactl.v1.Params"></a>

### Params
Params defines the parameters for the module.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `minTimeoutDuration` | [google.protobuf.Duration](#google.protobuf.Duration) |  | minTimeoutDuration defines the minimum value of packet timeout when submitting transactions to host chain on behalf of interchain account |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->

 <!-- end services -->



<a name="icactl/v1/genesis.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## icactl/v1/genesis.proto



<a name="icactl.v1.GenesisState"></a>

### GenesisState
GenesisState defines the icactl module's genesis state.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `params` | [Params](#icactl.v1.Params) |  | params defines the genesis parameters |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->

 <!-- end services -->



<a name="icactl/v1/query.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## icactl/v1/query.proto



<a name="icactl.v1.QueryInterchainAccountAddressRequest"></a>

### QueryInterchainAccountAddressRequest
QueryInterchainAccountAddressRequest defines the request for the InterchainAccountAddress query.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `connectionId` | [string](#string) |  |  |
| `owner` | [string](#string) |  |  |






<a name="icactl.v1.QueryInterchainAccountAddressResponse"></a>

### QueryInterchainAccountAddressResponse
QueryInterchainAccountAddressResponse defines the response for the InterchainAccountAddress query.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `interchainAccountAddress` | [string](#string) |  |  |






<a name="icactl.v1.QueryParamsRequest"></a>

### QueryParamsRequest
QueryParamsRequest is request type for the Query/Params RPC method.






<a name="icactl.v1.QueryParamsResponse"></a>

### QueryParamsResponse
QueryParamsResponse is response type for the Query/Params RPC method.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `params` | [Params](#icactl.v1.Params) |  | params holds all the parameters of this module. |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->


<a name="icactl.v1.Query"></a>

### Query
Query defines the gRPC querier service.

| Method Name | Request Type | Response Type | Description | HTTP Verb | Endpoint |
| ----------- | ------------ | ------------- | ------------| ------- | -------- |
| `Params` | [QueryParamsRequest](#icactl.v1.QueryParamsRequest) | [QueryParamsResponse](#icactl.v1.QueryParamsResponse) | Parameters queries the parameters of the module. | GET|/bfhevm/icactl/v1/params|
| `InterchainAccountAddress` | [QueryInterchainAccountAddressRequest](#icactl.v1.QueryInterchainAccountAddressRequest) | [QueryInterchainAccountAddressResponse](#icactl.v1.QueryInterchainAccountAddressResponse) | InterchainAccountAddress queries the interchain account address for given `connectionId` and `owner` | GET|/bfhevm/icactl/v1/interchain_account_address/{connectionId}/{owner}|

 <!-- end services -->



<a name="icactl/v1/tx.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## icactl/v1/tx.proto



<a name="icactl.v1.MsgRegisterAccount"></a>

### MsgRegisterAccount
MsgRegisterAccount defines the request message for MsgRegisterAccount


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `owner` | [string](#string) |  | owner represents the owner of the interchain account |
| `connectionId` | [string](#string) |  | connectionId represents the IBC `connectionId` of the host chain |






<a name="icactl.v1.MsgRegisterAccountResponse"></a>

### MsgRegisterAccountResponse
MsgRegisterAccountResponse defines the response message for MsgRegisterAccount






<a name="icactl.v1.MsgSubmitTx"></a>

### MsgSubmitTx
MsgSubmitTx defines the request message for MsgSubmitTx


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `owner` | [string](#string) |  | owner represents the owner of the interchain account |
| `connectionId` | [string](#string) |  | connectionId represents the IBC `connectionId` of the host chain |
| `msgs` | [google.protobuf.Any](#google.protobuf.Any) | repeated | msgs represents the transactions to be submitted to the host chain |
| `timeoutDuration` | [google.protobuf.Duration](#google.protobuf.Duration) |  | timeoutDuration represents the timeout duration for the IBC packet from last block |






<a name="icactl.v1.MsgSubmitTxResponse"></a>

### MsgSubmitTxResponse
MsgSubmitTxResponse defines the response message for MsgSubmitTx





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->


<a name="icactl.v1.Msg"></a>

### Msg
Msg defines the Msg service.

| Method Name | Request Type | Response Type | Description | HTTP Verb | Endpoint |
| ----------- | ------------ | ------------- | ------------| ------- | -------- |
| `RegisterAccount` | [MsgRegisterAccount](#icactl.v1.MsgRegisterAccount) | [MsgRegisterAccountResponse](#icactl.v1.MsgRegisterAccountResponse) | RegisterAccount registers an interchain account on host chain with given `connectionId` | |
| `SubmitTx` | [MsgSubmitTx](#icactl.v1.MsgSubmitTx) | [MsgSubmitTxResponse](#icactl.v1.MsgSubmitTxResponse) | SubmitTx submits a transaction to the host chain on behalf of interchain account | |

 <!-- end services -->



<a name="tokenfactory/v1/nft.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## tokenfactory/v1/nft.proto
Copyright (c) 2016-2021 Shanghai Bianjie AI Technology Inc. (licensed under the Apache License, Version 2.0)
Modifications Copyright (c) 2021, CRO Protocol Labs ("Crypto.org") (licensed under the Apache License, Version 2.0)


<a name="tokenfactory.v1.BaseNFT"></a>

### BaseNFT
BaseNFT defines a non-fungible token


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `name` | [string](#string) |  |  |
| `uri` | [string](#string) |  |  |
| `data` | [string](#string) |  |  |
| `owner` | [string](#string) |  |  |






<a name="tokenfactory.v1.Collection"></a>

### Collection
Collection defines a type of collection


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom` | [Denom](#tokenfactory.v1.Denom) |  |  |
| `nfts` | [BaseNFT](#tokenfactory.v1.BaseNFT) | repeated |  |






<a name="tokenfactory.v1.Denom"></a>

### Denom
Denom defines a type of NFT


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `name` | [string](#string) |  |  |
| `schema` | [string](#string) |  |  |
| `creator` | [string](#string) |  |  |






<a name="tokenfactory.v1.IDCollection"></a>

### IDCollection
IDCollection defines a type of collection with specified ID


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_id` | [string](#string) |  |  |
| `token_ids` | [string](#string) | repeated |  |






<a name="tokenfactory.v1.Owner"></a>

### Owner
Owner defines a type of owner


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `address` | [string](#string) |  |  |
| `id_collections` | [IDCollection](#tokenfactory.v1.IDCollection) | repeated |  |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->

 <!-- end services -->



<a name="tokenfactory/v1/genesis.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## tokenfactory/v1/genesis.proto
Copyright (c) 2016-2021 Shanghai Bianjie AI Technology Inc. (licensed under the Apache License, Version 2.0)
Modifications Copyright (c) 2021, CRO Protocol Labs ("Crypto.org") (licensed under the Apache License, Version 2.0)


<a name="tokenfactory.v1.GenesisState"></a>

### GenesisState
GenesisState defines the NFT module's genesis state


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `collections` | [Collection](#tokenfactory.v1.Collection) | repeated |  |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->

 <!-- end services -->



<a name="tokenfactory/v1/query.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## tokenfactory/v1/query.proto
Copyright (c) 2016-2021 Shanghai Bianjie AI Technology Inc. (licensed under the Apache License, Version 2.0)
Modifications Copyright (c) 2021, CRO Protocol Labs ("Crypto.org") (licensed under the Apache License, Version 2.0)


<a name="tokenfactory.v1.QueryCollectionRequest"></a>

### QueryCollectionRequest
QueryCollectionRequest is the request type for the Query/Collection RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_id` | [string](#string) |  |  |
| `pagination` | [cosmos.base.query.v1beta1.PageRequest](#cosmos.base.query.v1beta1.PageRequest) |  | pagination defines an optional pagination for the request. |






<a name="tokenfactory.v1.QueryCollectionResponse"></a>

### QueryCollectionResponse
QueryCollectionResponse is the response type for the Query/Collection RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `collection` | [Collection](#tokenfactory.v1.Collection) |  |  |
| `pagination` | [cosmos.base.query.v1beta1.PageResponse](#cosmos.base.query.v1beta1.PageResponse) |  |  |






<a name="tokenfactory.v1.QueryDenomByNameRequest"></a>

### QueryDenomByNameRequest
QueryDenomByNameRequest is the request type for the Query/DenomByName RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_name` | [string](#string) |  |  |






<a name="tokenfactory.v1.QueryDenomByNameResponse"></a>

### QueryDenomByNameResponse
QueryDenomByNameResponse is the response type for the Query/DenomByName RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom` | [Denom](#tokenfactory.v1.Denom) |  |  |






<a name="tokenfactory.v1.QueryDenomRequest"></a>

### QueryDenomRequest
QueryDenomRequest is the request type for the Query/Denom RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_id` | [string](#string) |  |  |






<a name="tokenfactory.v1.QueryDenomResponse"></a>

### QueryDenomResponse
QueryDenomResponse is the response type for the Query/Denom RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom` | [Denom](#tokenfactory.v1.Denom) |  |  |






<a name="tokenfactory.v1.QueryDenomsRequest"></a>

### QueryDenomsRequest
QueryDenomsRequest is the request type for the Query/Denoms RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `pagination` | [cosmos.base.query.v1beta1.PageRequest](#cosmos.base.query.v1beta1.PageRequest) |  | pagination defines an optional pagination for the request. |






<a name="tokenfactory.v1.QueryDenomsResponse"></a>

### QueryDenomsResponse
QueryDenomsResponse is the response type for the Query/Denoms RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denoms` | [Denom](#tokenfactory.v1.Denom) | repeated |  |
| `pagination` | [cosmos.base.query.v1beta1.PageResponse](#cosmos.base.query.v1beta1.PageResponse) |  |  |






<a name="tokenfactory.v1.QueryNFTRequest"></a>

### QueryNFTRequest
QueryNFTRequest is the request type for the Query/NFT RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_id` | [string](#string) |  |  |
| `token_id` | [string](#string) |  |  |






<a name="tokenfactory.v1.QueryNFTResponse"></a>

### QueryNFTResponse
QueryNFTResponse is the response type for the Query/NFT RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `nft` | [BaseNFT](#tokenfactory.v1.BaseNFT) |  |  |






<a name="tokenfactory.v1.QueryOwnerRequest"></a>

### QueryOwnerRequest
QueryOwnerRequest is the request type for the Query/Owner RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_id` | [string](#string) |  |  |
| `owner` | [string](#string) |  |  |
| `pagination` | [cosmos.base.query.v1beta1.PageRequest](#cosmos.base.query.v1beta1.PageRequest) |  | pagination defines an optional pagination for the request. |






<a name="tokenfactory.v1.QueryOwnerResponse"></a>

### QueryOwnerResponse
QueryOwnerResponse is the response type for the Query/Owner RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `owner` | [Owner](#tokenfactory.v1.Owner) |  |  |
| `pagination` | [cosmos.base.query.v1beta1.PageResponse](#cosmos.base.query.v1beta1.PageResponse) |  |  |






<a name="tokenfactory.v1.QuerySupplyRequest"></a>

### QuerySupplyRequest
QuerySupplyRequest is the request type for the Query/HTLC RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `denom_id` | [string](#string) |  |  |
| `owner` | [string](#string) |  |  |






<a name="tokenfactory.v1.QuerySupplyResponse"></a>

### QuerySupplyResponse
QuerySupplyResponse is the response type for the Query/Supply RPC method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `amount` | [uint64](#uint64) |  |  |





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->


<a name="tokenfactory.v1.Query"></a>

### Query
Query defines the gRPC querier service for NFT module

| Method Name | Request Type | Response Type | Description | HTTP Verb | Endpoint |
| ----------- | ------------ | ------------- | ------------| ------- | -------- |
| `Supply` | [QuerySupplyRequest](#tokenfactory.v1.QuerySupplyRequest) | [QuerySupplyResponse](#tokenfactory.v1.QuerySupplyResponse) | Supply queries the total supply of a given denom or owner | GET|/bfhevm/tokenfactory/collections/{denom_id}/supply|
| `Owner` | [QueryOwnerRequest](#tokenfactory.v1.QueryOwnerRequest) | [QueryOwnerResponse](#tokenfactory.v1.QueryOwnerResponse) | Owner queries the NFTs of the specified owner | GET|/bfhevm/tokenfactory/nfts|
| `Collection` | [QueryCollectionRequest](#tokenfactory.v1.QueryCollectionRequest) | [QueryCollectionResponse](#tokenfactory.v1.QueryCollectionResponse) | Collection queries the NFTs of the specified denom | GET|/bfhevm/tokenfactory/collections/{denom_id}|
| `Denom` | [QueryDenomRequest](#tokenfactory.v1.QueryDenomRequest) | [QueryDenomResponse](#tokenfactory.v1.QueryDenomResponse) | Denom queries the definition of a given denom | GET|/bfhevm/tokenfactory/denoms/{denom_id}|
| `DenomByName` | [QueryDenomByNameRequest](#tokenfactory.v1.QueryDenomByNameRequest) | [QueryDenomByNameResponse](#tokenfactory.v1.QueryDenomByNameResponse) | DenomByName queries the definition of a given denom by name | GET|/bfhevm/tokenfactory/denoms/name/{denom_name}|
| `Denoms` | [QueryDenomsRequest](#tokenfactory.v1.QueryDenomsRequest) | [QueryDenomsResponse](#tokenfactory.v1.QueryDenomsResponse) | Denoms queries all the denoms | GET|/bfhevm/tokenfactory/denoms|
| `NFT` | [QueryNFTRequest](#tokenfactory.v1.QueryNFTRequest) | [QueryNFTResponse](#tokenfactory.v1.QueryNFTResponse) | NFT queries the NFT for the given denom and token ID | GET|/bfhevm/tokenfactory/nfts/{denom_id}/{token_id}|

 <!-- end services -->



<a name="tokenfactory/v1/tx.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## tokenfactory/v1/tx.proto
Copyright (c) 2016-2021 Shanghai Bianjie AI Technology Inc. (licensed under the Apache License, Version 2.0)
Modifications Copyright (c) 2021, CRO Protocol Labs ("Crypto.org") (licensed under the Apache License, Version 2.0)


<a name="tokenfactory.v1.MsgBurnNFT"></a>

### MsgBurnNFT
MsgBurnNFT defines an SDK message for burning a NFT.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `denom_id` | [string](#string) |  |  |
| `sender` | [string](#string) |  |  |






<a name="tokenfactory.v1.MsgBurnNFTResponse"></a>

### MsgBurnNFTResponse
MsgBurnNFTResponse defines the Msg/BurnNFT response type.






<a name="tokenfactory.v1.MsgEditNFT"></a>

### MsgEditNFT
MsgEditNFT defines an SDK message for editing a nft.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `denom_id` | [string](#string) |  |  |
| `name` | [string](#string) |  |  |
| `uri` | [string](#string) |  |  |
| `data` | [string](#string) |  |  |
| `sender` | [string](#string) |  |  |






<a name="tokenfactory.v1.MsgEditNFTResponse"></a>

### MsgEditNFTResponse
MsgEditNFTResponse defines the Msg/EditNFT response type.






<a name="tokenfactory.v1.MsgIssueDenom"></a>

### MsgIssueDenom
MsgIssueDenom defines an SDK message for creating a new denom.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `name` | [string](#string) |  |  |
| `schema` | [string](#string) |  |  |
| `sender` | [string](#string) |  |  |






<a name="tokenfactory.v1.MsgIssueDenomResponse"></a>

### MsgIssueDenomResponse
MsgIssueDenomResponse defines the Msg/IssueDenom response type.






<a name="tokenfactory.v1.MsgMintNFT"></a>

### MsgMintNFT
MsgMintNFT defines an SDK message for creating a new NFT.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `denom_id` | [string](#string) |  |  |
| `name` | [string](#string) |  |  |
| `uri` | [string](#string) |  |  |
| `data` | [string](#string) |  |  |
| `sender` | [string](#string) |  |  |
| `recipient` | [string](#string) |  |  |






<a name="tokenfactory.v1.MsgMintNFTResponse"></a>

### MsgMintNFTResponse
MsgMintNFTResponse defines the Msg/MintNFT response type.






<a name="tokenfactory.v1.MsgTransferNFT"></a>

### MsgTransferNFT
MsgTransferNFT defines an SDK message for transferring an NFT to recipient.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| `id` | [string](#string) |  |  |
| `denom_id` | [string](#string) |  |  |
| `sender` | [string](#string) |  |  |
| `recipient` | [string](#string) |  |  |






<a name="tokenfactory.v1.MsgTransferNFTResponse"></a>

### MsgTransferNFTResponse
MsgTransferNFTResponse defines the Msg/TransferNFT response type.





 <!-- end messages -->

 <!-- end enums -->

 <!-- end HasExtensions -->


<a name="tokenfactory.v1.Msg"></a>

### Msg
Msg defines the NFT Msg service.

| Method Name | Request Type | Response Type | Description | HTTP Verb | Endpoint |
| ----------- | ------------ | ------------- | ------------| ------- | -------- |
| `IssueDenom` | [MsgIssueDenom](#tokenfactory.v1.MsgIssueDenom) | [MsgIssueDenomResponse](#tokenfactory.v1.MsgIssueDenomResponse) | IssueDenom defines a method for issue a denom. | |
| `MintNFT` | [MsgMintNFT](#tokenfactory.v1.MsgMintNFT) | [MsgMintNFTResponse](#tokenfactory.v1.MsgMintNFTResponse) | MintNFT defines a method for mint a new nft | |
| `EditNFT` | [MsgEditNFT](#tokenfactory.v1.MsgEditNFT) | [MsgEditNFTResponse](#tokenfactory.v1.MsgEditNFTResponse) | EditNFT defines a method for editing a nft. | |
| `TransferNFT` | [MsgTransferNFT](#tokenfactory.v1.MsgTransferNFT) | [MsgTransferNFTResponse](#tokenfactory.v1.MsgTransferNFTResponse) | TransferNFT defines a method for transferring a nft. | |
| `BurnNFT` | [MsgBurnNFT](#tokenfactory.v1.MsgBurnNFT) | [MsgBurnNFTResponse](#tokenfactory.v1.MsgBurnNFTResponse) | BurnNFT defines a method for burning a nft. | |

 <!-- end services -->



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

