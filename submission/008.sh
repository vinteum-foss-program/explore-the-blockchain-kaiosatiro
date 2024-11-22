# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
# set -x
tx_id=e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163

tx=$(bitcoin-cli getrawtransaction $tx_id true | jq -c '.vin[0]')
tx_wit_script=$(echo $tx | jq -r '.txinwitness[-1]')

script=$(bitcoin-cli decodescript $tx_wit_script | jq -r '.asm')

declare -i i=0
for item in $script;
do
    if [ "$i" -eq 1 ];
    then
        echo $item
        break
    fi
    i+=1
done

