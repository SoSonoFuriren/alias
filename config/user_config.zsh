# User-defined Configuration
# Custom aliases, functions, and personal configurations

# If set to an empty array, this variable will have no effect.
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# User configuration
# You may need to manually set your language environment
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
# else
# fi
# Compilation flags
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias ip='ip -c'
alias sr='screen -r'
alias sl='screen -ls'
alias killsrn='screen -ls | awk "/[0-9]+\./ {print \$1}" | xargs -I {} screen -X -S {} quit'
alias sshlou='ssh user@192.168.8.80'
alias sshlor='ssh root@192.168.8.80'
alias sshju='ssh root@192.168.8.93'
alias sshfr='ssh free5gc@192.168.8.21'
alias sshcg='ssh geniuscore@192.168.8.94'
alias sshatt='ssh oai@192.168.8.35'
alias ssh5gs='ssh oai-cn@192.168.8.108'
alias ssh5gc='ssh free5gc@192.168.8.21'
alias sshlou2='ssh user@192.168.8.77'
alias sshlor2='ssh root@192.168.8.77'
alias sshue='ssh oaiue@192.168.8.56'
alias sshyh='ssh yueh@192.168.8.90'
alias sshoaicn='ssh oaicn@192.168.8.91'
alias sshsmo='ssh ksmo@192.168.8.121'
alias ptp4l_status='sudo journalctl -u ptp4l -f'
alias phc2sys_status='sudo journalctl -u phc2sys -f'
alias ptp4l_stop='sudo systemctl stop ptp4l.service'
alias phc2sys_stop='sudo systemctl stop phc2sys.service'
alias ptp4l_start='sudo systemctl start ptp4l.service'
alias phc2sys_start='sudo systemctl start phc2sys.service'
alias ptp4l_restart='sudo systemctl restart ptp4l.service'
alias phc2sys_restart='sudo systemctl restart phc2sys.service'
alias ptp4lps='sudo ps aux | grep ptp4l'
alias ptpc1_stop='systemctl stop ptp-c1.service && sudo systemctl disable ptp-c1.service'
alias ptpc3_stop='ptp4l_stop && phc2sys_stop && sudo systemctl disable ptp4l.service && sudo systemctl disable phc2sys.service'
# PTP Configuration Aliases
alias ptpc1='ptpc3_stop && sudo systemctl start ptp-c1.service && sudo systemctl enable ptp-c1.service && sudo ip link set ens1f1 down && sudo ip link set ens1f0 up && sudo /home/oai72_su/Script/oaipega.sh'
alias ptpc3='ptpc1_stop && ptp4l_start && phc2sys_start && sudo systemctl enable ptp4l.service && sudo systemctl enable phc2sys.service && sudo ip link set ens1f0 down && sudo ip link set ens1f1 up && sudo /home/oai72_su/Script/oaijuravf.sh'
alias nrps='sudo ps aux | grep nr-softmodem'
alias nrkill='sudo pkill -9 nr-softmodem'
alias o1_start='sudo docker start adapter-gnb'
alias o1_stop='sudo docker stop adapter-gnb'
alias o1_log='sudo docker logs -f adapter-gnb'
alias docps='sudo docker ps -a'
alias ueip='ip a | gr｀ep 12.1.1'
# OAI UE route
alias ueroute='sudo ip route add 192.168.70.128/26 via 192.168.8.90 dev eno1'
#screen kill
alias srnkill='screen -ls | awk "/[0-9]+\./ {print \$1}" | xargs -I {} screen -X -S {} quit'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# auto M-plane configuration
