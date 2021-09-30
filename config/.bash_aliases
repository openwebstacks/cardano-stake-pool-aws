# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# "Cardano Node"-specifiic commands
alias start="sudo systemctl start cardano-node"
alias restart="sudo systemctl reload-or-restart cardano-node"
alias stop="sudo systemctl stop cardano-node"
alias status="sudo systemctl status cardano-node"

# viewing & filtering logs
alias logs="journalctl --unit=cardano-node --follow"
alias logsToday="journalctl --unit=cardano-node --since=today"
alias logsYesterday="journalctl --unit=cardano-node --since=yesterday"
alias monitorNodeCreationLogs="tail -f /var/log/cloud-init-output.log"

# stake pool specific aliases
if [ -f "$NODE_HOME/${NODE_CONFIG}-shelley-genesis.json" ]; then
    alias slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
    alias slotNo=$(cardano-cli query tip ${NETWORK_ARGUMENT} | jq -r '.slot')
    alias currentSlot=slotNo
fi

if [ -f "$NODE_HOME/payment.addr" ]; then
    alias paymentBalance=$(cardano-cli query utxo --address $(cat $NODE_HOME/payment.addr) ${NETWORK_ARGUMENT})
fi

if [ -f "$NODE_HOME/params.json" ]; then
    alias minPoolCost=$(cat $NODE_HOME/params.json | jq -r .minPoolCost)
fi

# other useful commands
alias gLiveView="$NODE_HOME/gLiveView.sh"
alias systeminfo="sudo $HELPERS/scripts/system_info.sh"

alias ~="cd $HOME"
alias home="cd $HOME"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias helpers="cd $HELPERS"
alias config="cd $HELPERS/config"
alias scripts="cd $HELPERS/scripts"
alias node="cd $NODE_HOME"

alias reloadshell="source $HOME/.bashrc"
alias nah="sudo git clean -df && sudo git reset --hard"
alias linkstakepool="ln -sf $HELPERS/config/.stake_pool $HOME/.stake_pool"
alias linkaliases="ln -sf $HELPERS/config/.bash_aliases $HOME/.bash_aliases"
alias linkservice="sudo rm -f /etc/systemd/system/cardano-node.service; sudo cp $HELPERS/config/cardano-node.service /etc/systemd/system/cardano-node.service; sudo chmod 644 /etc/systemd/system/cardano-node.service"
alias setsymlinks="reloadshell; linkaliases; linkservice; reloadshell"
