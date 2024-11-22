# Only one single output remains unspent from block 123,321. What address was it sent to?

block_txs=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 123321) | jq -r '.tx[]')

for tx in ${block_txs}; do
    tx_vout_len=$(bitcoin-cli getrawtransaction $tx true | jq -c '.vout | length')
    
    for ((i=0; i<$tx_vout_len; i++))
    do  
        unspent=$(bitcoin-cli gettxout $tx $i | jq -rc '.scriptPubKey.address')
        if [[ -n "${unspent[*]}" ]]; then
            echo $unspent
        fi
    done

    # echo $tx_vout_len
    # tx_vout=$(bitcoin-cli getrawtransaction $tx true | jq -c '.nvout')
    # tx_vout_addrs=($(echo "$tx_vout" | jq -rc '.[].scriptPubKey.address'))

    # for vout in ${tx_vout_addrs[@]}; do
    #     # unspents=$(bitcoin-cli scantxoutset start "[\"addr($vout)\"]" | jq -rc '.unspents[]')
    #     echo $unspents
    #     echo "***"
    #     if [ ${#unspents[@]} -eq 0 ]; then
    #         echo $vout
    #     fi
    # done
done

