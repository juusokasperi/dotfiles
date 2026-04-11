#!/bin/bash

echo "Creating disk usage shell script.." 
cat > ~/.du_check.sh << 'EOF'
#!/bin/bash
CLR="\033[0;30;42m"
RST="\033[0m"
USER=$(whoami)
WORK_USAGE=$(du -sh /var/work/$USER 2>/dev/null | cut -f1)
DATE="[$(date '+%Y-%m-%d')]"

WORK_MSG="Work: $CLR$WORK_USAGE$RST"

echo -e "$CLR# DISK USAGE $DATE$RST" > ~/.disk_report
echo -e "$WORK_MSG" >> ~/.disk_report
EOF
chmod +x ~/.du_check.sh

if grep -qF '.du_check.sh' <(crontab -l 2>/dev/null); then
	echo "Already in crontab, skipping.."
else
	echo "Adding to crontab.."
	(crontab -l 2>/dev/null; echo "0 2 * * 1 $HOME/.du_check.sh") | crontab -
fi

if [[ "$SHELL" == */zsh ]]; then
	RC=~/.zshrc
	HOOK="precmd_functions+=(_check_disk_report)"
else
	RC=~/.bashrc
	HOOK='PROMPT_COMMAND="_check_disk_report;${PROMPT_COMMAND}"'
fi

if grep -qF '_check_disk_report()' "$RC" 2>/dev/null; then
	echo "Already in $RC, skipping.."
else
	echo "Adding to $RC.."
	cat >> "$RC" << EOF
_check_disk_report() {
    if [[ -f ~/.disk_report ]]; then
        cat ~/.disk_report
        rm ~/.disk_report
    fi
}
$HOOK
EOF
fi

echo "Bye."
