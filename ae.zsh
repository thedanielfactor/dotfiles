selection-menu() {
  # spiffy selection menu
  # echo ''
  PS3=$'\n'"%F{green}Select an environment:%{$reset_color%} "
  if [ -z "$1" ]; then # if length arg != 0 (not empty string)
    files=($(find . -type f -iname "*.env*"))
    select file in "${files[@]}"; do
      if [ 1 -le "$REPLY" ] && [ "$REPLY" -le ${#files[@]} ]; then
        SELECTED_FILE=$file
        break
      else
        ERROR="Invalid entry. Select a number between \033[00;32m1\033[0m-\033[00;32m${#files[@]}\033[0m "
        printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $ERROR\n"
      fi
    done
  else
    USER_FILES=($(find . -type f -iname "*$1*" -maxdepth 2))
    if [ ${#USER_FILES[@]} -eq 1 ]; then
      SELECTED_FILE=$USER_FILES
    else
      select user_file in "${USER_FILES[@]}"; do
        if [ 1 -le "$REPLY" ] && [ "$REPLY" -le ${#USER_FILES[@]} ]; then
          SELECTED_FILE=$user_file
          break
        else
          ERROR="Invalid entry. Select a number between \033[00;32m1\033[0m-\033[00;32m${#USER_FILES[@]}\033[0m "
          printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $ERROR\n"
        fi
      done
    fi
  fi
  echo $SELECTED_FILE
}

spark-env() {                    # shoutout to raymondd and andrews for the inspiration
  SPARK=~/Development/AE/code/edge-spark-react
  cd $SPARK
  ENV_FILE=$(selection-menu $1)
  MESSAGE="Building Spark with \033[00;32m$ENV_FILE\033[0m variables"
  OK_MESSAGE="[ \033[00;32mOK\033[0m ] $MESSAGE"
  echo -n $OK_MESSAGE | boxes -d unicornsay

  set -a
  source $ENV_FILE
  set +a
  # cat $SPARK/.env.$1 > $SPARK/.env ## other option to avoid set
  npm run generate-graphql-types && npm start ## or `spark` alias
}

tg-source() {
  set -a
  ENV_FILE=$(selection-menu $1)
  echo $ENV_FILE
  source $ENV_FILE
  set +a
  npm run generate-graphql-types
}

es() {
  DEFAULT="amtest"
  AUCTION=${3:-$DEFAULT}
  echo ""
  echo "============="
  echo "\033[00;33mELASTIC-SEARCHING ....\033[0m"
  echo "Stock Number [ \033[00;32m$1\033[0m ] "
  echo "Environment: [ \033[00;32m${2:-dev}\033[0m ]"
  echo "Auction: [ \033[00;32m$AUCTION\033[0m ]"
  SEARCH_URL="https://vpc-dev-edge-spark-abjrfqwjnu4tkra7hugnfgwhe4.us-west-2.es.amazonaws.com"
  STAGE_SEARCH_URL="https://vpc-stage-edge-spark-ayaymeuahm7sf5xwl6s4uvlfpe.us-west-2.es.amazonaws.com"
  PROD_SEARCH_URL="https://vpc-prod-edge-spark-20210322-hor4s3m3tmg52beleuia5ux374.us-west-2.es.amazonaws.com"
  if [ -n "$2" ]; then
    if [ "$2" = "prod" ]; then
      SEARCH_URL=$PROD_SEARCH_URL
    elif [ "$2" = "stage" ]; then
      SEARCH_URL=$STAGE_SEARCH_URL
    fi
    echo $SEARCH_URL
  fi
  PAYLOAD='{"track_total_hits": true,"track_scores": true,"query": {"bool": {"must": [{"match": {"auction_code": "'$AUCTION'"}},{"match": {"is_valid": "1"}},{"match": {"stock_number": "'"${1}"'"}}]}}}'

  echo "============="
  echo "\033[00;33mELASTICSEARCH RESPONSE ....\033[0m"
  curl -XGET "$SEARCH_URL/a_vehicles/_search?pretty=true" -H 'Content-Type: application/json' -d"$PAYLOAD" | jq .
  echo "Showing results for Stock Number [ \033[00;32m$1\033[0m ] "
  echo "Environment: [ \033[00;32m${2:-dev}\033[0m ]"
  echo "Auction: [ \033[00;32m$AUCTION\033[0m ]"
}

es-all() {
  SEARCH_URL="https://vpc-dev-edge-spark-abjrfqwjnu4tkra7hugnfgwhe4.us-west-2.es.amazonaws.com"
  STAGE_SEARCH_URL="https://vpc-stage-edge-spark-ayaymeuahm7sf5xwl6s4uvlfpe.us-west-2.es.amazonaws.com"
  PROD_SEARCH_URL="https://vpc-prod-edge-spark-20210322-hor4s3m3tmg52beleuia5ux374.us-west-2.es.amazonaws.com"
  if [ -n "$2" ]; then
    if [ "$2" = "prod" ]; then
      SEARCH_URL=$PROD_SEARCH_URL
    elif [ "$2" = "stage" ]; then
      SEARCH_URL=$STAGE_SEARCH_URL
    fi
    echo $SEARCH_URL
  fi
  PAYLOAD='{"track_total_hits": true,"track_scores": true,"query": {"bool": {"must": [{"match": {"is_valid": "1"}},{"match": {"stock_number": "'"${1}"'"}}]}}}'
  curl -XGET "$SEARCH_URL/a_vehicles/_search?pretty=true" -H 'Content-Type: application/json' -d"$PAYLOAD" | jq .
  echo "Showing results for Stock Number [ \033[00;32m$1\033[0m ] "
  echo "Environment: [ \033[00;32m${2:-dev}\033[0m ]"
  echo "Auction: [ \033[00;32mANY\033[0m ]"
}

es-go() {
  echo "\033[00;33mLet's get you that vehicle up in Spark ....\033[0m"
  echo "Stock Number [ \033[00;32m$1\033[0m ] "
  echo "Environment: [ \033[00;32m${2:-dev}\033[0m ]"
  echo "Auction: [ \033[00;32m${3:-amtest}\033[0m ]"
  SEARCH=$(es $1 $2 $3)
  ID=$(echo $SEARCH | ack "\"_id\": \"([0-9]+)\"" --output '$1')
  if [ "$2" = "prod" ]; then
    URL="https://spark.auctionedge.com/details/vehicles?id=$ID&auction=${3:-amtest}"
    echo "Here's the link for reference: [ \033[01;34m$URL\033[0m ]"
    open $URL
  elif [ "$2" = "stage" ]; then
    URL="https://sparkpreview-stage.ext.edgeapps.net/details/vehicles?id=$ID&auction=${3:-amtest}"
    echo "Here's the link for reference: [ \033[01;34m$URL\033[0m ]"
    open $URL
  else
    URL="https://sparkpreview.ext-dev.edgeapps.net/details/vehicles?id=$ID&auction=${3:-amtest}"
    echo "Here's the link for reference: [ \033[01;34m$URL\033[0m ]"
    open $URL
  fi
}

get-veh() {
  echo "\033[00;33mGetting vehicle details ....\033[0m"
  echo "Stock Number [ \033[00;32m$1\033[0m ] "
  echo "Environment: [ \033[00;32m${2:-dev}\033[0m ]"
  echo "Auction: [ \033[00;32m${3:-amtest}\033[0m ]"
  SEARCH=$(es $1 $2 $3)
  ID=$(echo $SEARCH | ack "\"_id\": \"([0-9]+)\"" --output '$1')
  echo "Asset ID: [ \033[00;32m$ID\033[0m ]"
  echo ''
  # TODO: remove aliases from this script: https://unix.stackexchange.com/a/368258
  if [ "$2" = "prod" ]; then
    pg-o-p -xc"SELECT * FROM ods.get_vehicle_details($ID, '${3:-amtest}');"
  elif [ "$2" = "stage" ]; then
    pg-o-s -xc"SELECT * FROM ods.get_vehicle_details($ID, '${3:-amtest}');"
  else
    pg-o-d -xc"SELECT * FROM ods.get_vehicle_details($ID, '${3:-amtest}');"
  fi
}

search-res() {
  if [ -z "$4" ]; then
    SELECTED_TYPE=$(select-search)
  fi
  ENV="dev-appsync"
  while getopts 'sp' flag; do
    case "${flag}" in
      s) ENV="stage-appsync" ;;
      p) ENV="prod-appsync" ;;
    esac
  done
  RESOLVER="spark-api-appsync-$ENV-appsyncSearchResolver"
  MESSAGE="Searching $RESOLVER, Type: $SELECTED_TYPE"
  echo "[ \033[00;32m$MESSAGE\033[0m ]"
  aws-vault exec edge-prod -- aws lambda invoke --function-name $RESOLVER --payload '{ "requestContext": { "queryArgs": { "identity": "test", "auctionArgs": { "id": "'${3:-amtest}'"}}}, "args": { "filter": { "searchString": "'${2}'", "type": "'${4:-$SELECTED_TYPE}'" }}, "selectionSetList": "", "selectionGraphQL": "" }' response.json && cat response.json | jq .
}

select-search() {
  types=$(node ~/.helper.js)
  echo ''
  PS3=$'\n'"%F{green}Select a search type:%{$reset_color%} "
  select type in ${types[@]}; do
    if [ 1 -le "$REPLY" ] && [ "$REPLY" -le ${#types[@]} ]; then
      SELECTED_TYPE=$type
      break
    else
      ERROR="Invalid entry. Select a number between \033[00;32m1\033[0m-\033[00;32m${#types[@]}\033[0m "
      printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $ERROR\n"
    fi
  done
  echo $SELECTED_TYPE
}

sshnuc() {
  if [ -z $1 ]; then
    echo "What is the port#?"
    read PORT
  fi
  PORT_NUMBER=${1:-$PORT} 
  
  kitten ssh -p $PORT_NUMBER -i ~/.ssh/id_octopus auctionedge@prod-auction-bastion-inbound.ext.edgeapps.net
}

scpnuc() {
  if [ -z $1 ]; then
    echo "What is the port#?"
    read PORT
  fi
  PORT_NUMBER=${1:-$PORT} 
  
  scp -P $PORT_NUMBER -i ~/.ssh/id_octopus $2 auctionedge@prod-auction-bastion-inbound.ext.edgeapps.net:$2
}

getAuctionLogin() {
  if [ -z $1 ]; then
    echo "What is the auction id?" 
    read AUCTION_ID
  fi
  AUCTION_ID=${1:-$AUCTION_ID}
  MESSAGE="Getting Secrets for ${AUCTION_ID}"
  echo "[ \033[00;32m$MESSAGE\033[0m ]"
  aws-vault exec edge-prod -- aws secretsmanager get-secret-value --secret-id ${AUCTION_ID} | jq -r .SecretString | jq '{ username: .cloud_api_username, password: .cloud_api_password }'
}

stock() {
  if [ -z $1 ]; then
    echo "What is the stock #?"
    read STOCK
  fi
  STOCK_NUMBER=${1:-$STOCK}

  if [ -z $2 ]; then
    echo "What is the auction code? (i.e. 'amtest')"
    read AUCTION_CODE_INPUT
  fi
  AUCTION_CODE=${2:-$AUCTION_CODE_INPUT}

  PS3='Select an environment: '
  stage_options=("dev" "stage" "prod")
  select opt in "${stage_options[@]}"
  do
      case $opt in
          "dev")
              ENVIRONMENT=$opt
              break
              ;;
          "stage")
              ENVIRONMENT=$opt
              break
              ;;
          "prod")
              ENVIRONMENT=$opt
              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done
  echo "You chose: $ENVIRONMENT (${AUCTION_CODE}) for stock# $STOCK_NUMBER"

  PS3='Select a workflow: '
  workflow_options=('Search' 'Get Vehicle Details' 'Open in Spark')
  select opt in "${workflow_options[@]}"
  do
    case $opt in
      "Search")
        es $STOCK_NUMBER ${ENVIRONMENT} ${AUCTION_CODE:-amtest}
        break
        ;;
      "Get Vehicle Details")
        get-veh $STOCK_NUMBER ${ENVIRONMENT} ${AUCTION_CODE:-amtest}
        break
        ;;
      "Open in Spark")
        es-go $STOCK_NUMBER ${ENVIRONMENT} ${AUCTION_CODE:-amtest}
        break
        ;;
      *) echo "invalid option $REPLY";;
    esac
  done
  echo "I hope you were satisified with this automation. \033[00;33mHave a wonderful day!\033[0m"
}

# Switch node-version when directory changes
# https://github.com/creationix/nvm/issues/603#issuecomment-91290448
# function chpwd() {
# 	if [ -r $PWD/.node-version ]; then
# 	nvm use `cat $PWD/.node-version`
# 	elif [ -r $PWD/.nvmrc ]; then
# 			nvm use
# 		fi
# 	}
# 	chpwd
# }

# AE PSQL
#[pgod]      PSQL To Dev ODS
alias pgod="psql -h $ODS_DEV -U usr_raymondd -d ods_dev"
#[pgos]      PSQL To Stage ODS
alias pgos="psql -h $ODS_STAGE -U usr_raymondd -d ods_stage"
#[pgop]      PSQL To Prod ODS
alias pgop="psql -h $ODS_PROD -U usr_raymondd -d ods_prod"

# Aliases for AuctionEdge
alias tg="npm run typegen"
alias vd="./vault-deploy.sh raymondd"
alias vds="./vault-deploy.sh raymondd stage-appsync"
alias vdp="./vault-deploy.sh raymondd prod-appsync"
alias spark="npm run generate-graphql-types && npm start"
alias vtd="npm run typegen && ~/development/auctionedge/cloud_integrations/spark_api/spark-api-appsync/vault-deploy.sh"
alias cappsync="cd /Users/$USER/development/auctionedge/cloud_integrations/spark_api/spark-api-appsync"
alias cspark="cd /Users/$USER/development/auctionedge/edge-spark-react"


