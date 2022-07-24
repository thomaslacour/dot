ENV_FILEPATH="$HOME/.config/env"
readonly SSH_KEY_GITHUB="$HOME/.ssh/github"

if [ ! -f "$ENV_FILEPATH" ]; then
  echo "$ENV_FILEPATH does not exists. Abort."
  exit 1
fi
source $ENV_FILEPATH

if [ -z ${MAIL+x} ]; then
  echo "MAIL is unset in $ENV_FILEPATH"
  exit 1
fi
if [ -z ${TOKEN_GITHUB+x} ]; then
  echo "TOKEN_GITHUB is unset in $ENV_FILEPATH"
  exit 1
fi
OUTPUT=$(curl -SsH "Authorization: token $TOKEN_GITHUB" --data "{\"title\":\"dotfiles-key\",\"key\":\"$(cat $SSH_KEY_GITHUB)\"}" https://api.github.com/user/keys)
if echo "$OUTPUT" | grep -q "Bad credentials"; then
  echo "Token not allowed for github. Abort."
  exit 1
fi

# install usefull packages
sudo apt -qq update > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1
sudo apt -qq install -y git vim openssh-client curl > /dev/null 2>&1

# prepare ssh key
if [ ! -f "$SSH_KEY_GITHUB" ]; then
  ssh-keygen -t ed25519 -C $MAIL -f $SSH_KEY_GITHUB -P ""
  ssh-add $SSH_KEY_GITHUB
fi
ssh-keygen -F github.com > /dev/null 2>&1 || ssh-keyscan github.com >> ~/.ssh/known_hosts

echo ":: git clone $REPO in $TMP"
git clone $REPO $TMPDIR

dot() {
  git --git-dir=.dot --work-tree=. "$@"
}

rm -rf .dot
mv "$TMPDIR/.git" .dot

rm -rf $TMPDIR

echo "git remote set-url origin git@github.com:thomaslacour/dot.git"
dot remote set-url origin git@github.com:thomaslacour/dot.git
dot remote set-url origin git@github.com:thomaslacour/dot.git
dot push --set-upstream origin main

echo ":: git config ..."
dot config --local status.showUntrackedFiles no
dot config user.email $MAIL
dot config user.name $USERNAME

echo ":: backup your files on branch 'backup' ..."
dot switch -c backup
dot add -u
dot commit -m "backup"
dot checkout main
