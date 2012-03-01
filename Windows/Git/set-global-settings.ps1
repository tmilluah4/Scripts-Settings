git config --global user.name "Keith Beckman"
git config --global user.email "kbeckman.c4sc@gmail.com"

git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd '/C/Scripts-Settings/Windows/Git/git-mergetool-diffmerge-wrapper.sh "$LOCAL" "$BASE" "$REMOTE" "$MERGED"'
git config --global mergetool.keepBackup false

git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd '/C/Scripts-Settings/Windows/Git/git-difftool-diffmerge-wrapper.sh "$LOCAL" "$REMOTE"'
