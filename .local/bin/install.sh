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

# initialize bare repo
mkdir -p ~/.dot
echo ":: git init --bare $HOME/.dot"
git init --bare $HOME/.dot -b main

# git

dot() {
  git --git-dir=$HOME/.dot --work-tree=$HOME "$@"
}

echo ":: git remote add origin git@github.com:thomaslacour/dot.git"
dot remote add origin git@github.com:thomaslacour/dot.git
dot remote set-url origin git@github.com:thomaslacour/dot.git
echo ":: git config ..."
dot config --local status.showUntrackedFiles no
dot config user.email $MAIL
dot config user.name $USERNAME
echo ":: add ssh key to github ..."
dot fetch >/dev/null 2>&1
echo ":: git pull origin main"
read -p ":: Are you sure you want to reset your dotfiles, bro? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
dot reset --hard origin/main
