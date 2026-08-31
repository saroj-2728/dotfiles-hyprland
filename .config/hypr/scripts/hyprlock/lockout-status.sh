#!/usr/bin/env bash
# Prints the remaining pam_faillock lockout time for the current user.
# Silent (no output) when the account is not locked.

user=$(id -un)
deny=3
unlock_time=600
conf=/etc/security/faillock.conf

# honour non-default deny / unlock_time if the admin set them
if [[ -r $conf ]]; then
    while IFS='=' read -r key val; do
        key=${key//[[:space:]]/}
        val=${val//[[:space:]]/}
        case $key in
            '' | \#*) ;;
            deny)        [[ $val =~ ^[0-9]+$ ]] && deny=$val ;;
            unlock_time) [[ $val =~ ^[0-9]+$ ]] && unlock_time=$val ;;
        esac
    done < "$conf"
fi

# valid ("V") failure timestamps, oldest -> newest
mapfile -t stamps < <(
    faillock --user "$user" 2>/dev/null \
    | awk 'NF>=4 && $1 ~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ && $NF ~ /^V/ {print $1" "$2}'
)

count=${#stamps[@]}
(( count >= deny )) || exit 0

last_epoch=$(date -d "${stamps[$((count - 1))]}" +%s 2>/dev/null) || exit 0
remain=$(( unlock_time - ( $(date +%s) - last_epoch ) ))
(( remain > 0 )) || exit 0

mins=$(( (remain + 59) / 60 ))
if (( mins <= 1 )); then
    echo "󰀦  Locked · try again in under a minute"
else
    echo "󰀦  Locked · try again in ${mins} min"
fi
