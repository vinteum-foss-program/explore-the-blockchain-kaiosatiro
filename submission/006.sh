# Which tx in block 257,343 spends the coinbase output of block 256,128?
# set -x
coinbase=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 256128) | jq -r '.tx[0]')
block_txs=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 257343) | jq -r '.tx[]')

for tx in ${block_txs}; do
    tx_vin=$(bitcoin-cli getrawtransaction $tx true | jq -c '.vin')
    tx_vin_ids=($(echo "$tx_vin" | jq -rc '.[].txid'))

    for in in ${tx_vin_ids[@]}; do
        if [ "$in" = "$coinbase" ];
            then 
            echo $tx
        fi
    done
done