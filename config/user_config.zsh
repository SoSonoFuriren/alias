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
alias sshfh='ssh ocnos@192.168.8.25'
alias sshpega='ssh padmin@192.168.9.9'
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
alias ptpc1='ptpc3_stop && sudo systemctl start ptp-c1.service && sudo systemctl enable ptp-c1.service && sudo ip link set ens1f1 down && sudo ip link set ens1f0 up && sudo ~/Script/oaipega.sh'
alias ptpc3='ptpc1_stop && ptp4l_start && phc2sys_start && sudo systemctl enable ptp4l.service && sudo systemctl enable phc2sys.service && sudo ip link set ens1f0 down && sudo ip link set ens1f1 up && sudo ~/Script/oaijuravf.sh'
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
alias pegam='~/SMO-Mplane/Pegatron/Mplane_pega.sh'
alias juram='~/SMO-Mplane/Metanoia-Jura/Mplane_jura.sh'

# 快速建立筆記 (支援指定資料夾)
# Quick note creation (supports custom folder)
alias nn='f(){ bash ~/ming-note/scripts/new-note.sh note "$2" "${1:-}"; }; f'

# 快速建立會議紀錄 (自動加入日期後綴，儲存到 Meeting-Minutes 資料夾)
# Quick meeting minutes (auto date suffix, saves to Meeting-Minutes folder)
alias mm='f(){ bash ~/ming-note/scripts/new-note.sh meeting "${1:-meeting}-$(date +%Y%m%d)" "Meeting-Minutes"; }; f'

# 快速建立 Paper Survey（預設建立在 notes/papers，並自動更新索引）
# Quick paper survey (defaults to notes/papers; auto-updates paper index)
alias pp='f(){ bash ~/ming-note/scripts/new-note.sh paper-survey "${1:-paper-$(date +%Y%m%d)}" "${2:-papers}"; }; f'


# eval "$(/bin/brew shellenv)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ================= OAI Log Shortcuts =================

export MY_PNF_LOG="$HOME/gNB-logs/nfapi-PNF-pegatron-localcn-develop-latest-f-ming-develop.log"
export MY_PNF_ORIGINAL_LOG="$HOME/gNB-logs/nfapi-PNF-pegatron-localcn-develop-latest-f-orig-develop.log"
export MY_PNF_SPLIT_LOG="$HOME/gNB-logs/nfapi-PNF-Split-pegatron-localcn-develop-latest-f-ming-develop.log"
export MY_PNF_SPLIT_ORIGINAL_LOG="$HOME/gNB-logs/nfapi-PNF-Split-pegatron-localcn-develop-latest-f-orig-develop.log"
# export MY_VNF_LOG="/gNB-logs/nfapi-VNF-pegatron-localcn-2025.w44-ming-develop.log"
export MY_VNF_LOG="/gNB-logs/nfapi-VNF-pegatron-localcn-develop-latest-ming-develop.log"
export MY_VNF_ORIG_LOG="/gNB-logs/nfapi-VNF-pegatron-localcn-develop-latest-orig-develop.log"
export MY_MEASURE_LOG="$HOME/oai_mp_f_ming/openairinterface5g/cmake_targets/ran_build/build/measure.txt"
export MY_PRB_LOG="$HOME/oai_mp_f_ming/openairinterface5g/cmake_targets/ran_build/build/vnf-PRB.txt"

# --- Tail Follow Aliases ---
alias rrr='~/auto_reboot_pegatron_ru.sh'
alias tp='tail -F $MY_PNF_LOG'
alias tpo='tail -F $MY_PNF_ORIGINAL_LOG'
alias tpp='tail -F $MY_PNF_SPLIT_LOG'
alias tppo='tail -F $MY_PNF_SPLIT_ORIGINAL_LOG'
alias tv='tail -F $HOME$MY_VNF_LOG'
alias tvo='tail -F $HOME$MY_VNF_ORIG_LOG'
alias tvv='ssh hpe tail -F "~"$MY_VNF_LOG' 
alias tvvo='ssh hpe tail -F "~"$MY_VNF_ORIG_LOG' 
alias ss='~/oai_mp_f_ming/openairinterface5g/run_nfapi.sh split'
alias ssr='~/oai_mp_f_ming/openairinterface5g/run_nfapi.sh split-orig'
alias sl='~/oai_mp_f_ming/openairinterface5g/run_nfapi.sh local'
alias slr='~/oai_mp_f_ming/openairinterface5g/run_nfapi.sh local-orig'
alias qq='~/oai_mp_f_ming/openairinterface5g/stop_nfapi.sh'

# --- Grep Functions (Search with Context) ---
gm() {
    if [ -z "$1" ]; then
        echo "Usage: gm <search_string> <number_of_context_lines>"
    else
        grep -a -F -C ${2:-5} --color=auto "$1" "$MY_MEASURE_LOG"
    fi
}
gp() {
    if [ -z "$1" ]; then
        echo "Usage: gp <search_string> <number_of_context_lines>"
    else
        grep -F -C ${2:-5} --color=auto "$1" "$MY_PNF_LOG"
    fi
}
gpp() {
    if [ -z "$1" ]; then
        echo "Usage: gp <search_string> <number_of_context_lines>"
    else
        grep -F -C ${2:-5} --color=auto "$1" "$MY_PNF_SPLIT_LOG"
    fi
}
gv() {
    if [ -z "$1" ]; then
        echo "Usage: gv <search_string> <number_of_context_lines>"
    else
        grep -F -C ${2:-5} --color=auto "$1" "$HOME$MY_VNF_LOG"
    fi
}
gvv() {
    if [ -z "$1" ]; then
        echo "Usage: gvv <search_string> <number_of_context_lines>"
    else
        ssh hpe "grep -F -C ${2:-5} --color=auto \"$1\" ~$MY_VNF_LOG"
    fi
}

# Added by Antigravity CLI installer
export PATH="~/.local/bin:$PATH"

# ================= Antigravity CLI Profiles =================$
export PATH=$HOME/.local/bin:$PATH
alias agy-babu='HOME=$HOME/.agy_profile_babu agy'
alias agy-kenny='HOME=$HOME/.agy_profile_kenny agy'
alias agy-ming='HOME=$HOME/.agy_profile_ming agy'
alias agy-rita='HOME=$HOME/.agy_profile_rita agy'
alias agy-tobby='HOME=$HOME/.agy_profile_tobby agy'
# ===========================================================
