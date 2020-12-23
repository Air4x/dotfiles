#!/bin/sh
#
# ufetch-arch - tiny system info for arch

## INFO

# user is already defined
host="$(cat /etc/hostname)"
os='EndeavourOS'
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(pacman -Q | wc -l)"
shell="$(basename "$SHELL")"

## UI DETECTION

if [ -n "${DE}" ]; then
	ui="${DE}"
	uitype='DE'
elif [ -n "${WM}" ]; then
	ui="${WM}"
	uitype='WM'
elif [ -n "${XDG_CURRENT_DESKTOP}" ]; then
	ui="${XDG_CURRENT_DESKTOP}"
	uitype='DE'
elif [ -n "${DESKTOP_SESSION}" ]; then
	ui="${DESKTOP_SESSION}"
	uitype='DE'
elif [ -f "${HOME}/.xinitrc" ]; then
	ui="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	uitype='WM'
elif [ -f "${HOME}/.xsession" ]; then
	ui="$(tail -n 1 "${HOME}/.xsession" | cut -d ' ' -f 2)"
	uitype='WM'
else
	ui='unknown'
	uitype='UI'
fi
ui="$(basename ${ui})"

## DEFINE COLORS

# probably don't change these
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
	reset="$(tput sgr0)"
fi

# you can change these
lc="${reset}${bold}${blue}"         # labels
nc="${reset}${bold}${blue}"         # user and hostname
ic="${reset}"                       # info
c0="${reset}${blue}"                # first color

## OUTPUT

cat <<EOF
${c0}                .\`            ${nc}${USER}${ic}@${nc}${host}${reset} 
${c0}              \`+yy/\`         ${lc}OS:        ${ic}${os}${reset}  
${c0}            \`:syyyys-         ${lc}KERNEL:    ${ic}${kernel}${reset}
${c0}           ./syyyyyys+.        ${lc}UPTIME:    ${ic}${uptime}${reset} 
${c0}         \`:+yyyyyyyyyyo:      ${lc}PACKAGES:  ${ic}${packages}${reset}
${c0}       \`-/oyyyyyyyyyyyyo/\`   ${lc}SHELL:     ${ic}${shell}${reset}
${c0}      .//syyyyyyyyyyyyys+/\`   ${lc}${uitype}:        ${ic}${ui}${reset}
${c0}    \`:/+syyyyyyyyyyyyyyyo+/   
${c0}   -//+yyyyyyyyyyyyyyyyy+++   
${c0}    \`/oooooosssssssssso++/.   
${c0}     -:::///::::::::---..\`    
EOF

