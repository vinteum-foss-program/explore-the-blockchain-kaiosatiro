# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
# set -x
tx='37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517'

dec_tx=$(bitcoin-cli getrawtransaction "$tx" true)

pubkey_1=$(echo "$dec_tx" | jq  '.vin[0] | .txinwitness[1]')
pubkey_2=$(echo "$dec_tx" | jq  '.vin[1] | .txinwitness[1]')
pubkey_3=$(echo "$dec_tx" | jq  '.vin[2] | .txinwitness[1]')
pubkey_4=$(echo "$dec_tx" | jq  '.vin[3] | .txinwitness[1]')

bitcoin-cli createmultisig 1 "[$pubkey_1, $pubkey_2, $pubkey_3, $pubkey_4]" | jq -r '.address'