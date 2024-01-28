#!/bin/sh
export PEM_FILE="/root/.config/dfx/identity/$(dfx identity whoami)/identity.pem"
export CID="$(dfx canister --network ic id validators)"

quill sns make-proposal 824f1a1df2652fb26c0fe1c03ab5ce69f2561570fb4d042cdc32dcb4604a4f03 --pem-file $PEM_FILE --canister-ids-file sns_canister_ids.json --proposal "(record { title=\"Register new dapp canister with Neutrinite SNS.\"; url=\"\"; summary=\"This proposal registers a new dapp canisters with SNS. The new canister provides generic function validators allowing the SNS to interact with external services. Currently there is icrc1_transfer validator. This allows Generic Functions to external ledgers to be added. SNS generic functions can't interact with ICP or NTN ledgers (these are reserved by the treasury), but can interact with ckETH and ckBTC. The canister repository https://github.com/Neutrinomic/external_gf_validators . Verify build - Open in Github Codespaces and run: ./verify.sh \"; action=opt variant {RegisterDappCanisters = record {canister_ids=vec {principal\"$CID\"}}}})" > register.json

