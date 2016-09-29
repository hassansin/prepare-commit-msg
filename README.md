# Git `prepare-commit-msg` hook

If commit message does not refer to any JIRA issue number,
this hook will parse the JIRA issue from the current branch and 
prepend it to the commit message


## Example:

**Branch:** CW-645 or CW-645-some-text

**commit message:** Updated README.md 

**prepended commit message:** #CW-645 Updated README.md

## Install

Copy this file into your projects .git/hooks/prepare-commit-msg file

```bash
wget -q -O ./.git/hooks/prepare-commit-msg https://raw.githubusercontent.com/hassansin/prepare-commit-msg/master/prepare-commit-msg
chmod +x ./.git/hooks/prepare-commit-msg
```

For submodules:

```bash

for module in .git/modules/*; do
    wget -q -O "${module}/hooks/prepare-commit-msg" https://raw.githubusercontent.com/hassansin/prepare-commit-msg/master/prepare-commit-msg
    chmod +x "${module}/hooks/prepare-commit-msg"
done


```

## Test

```bash
./test.sh

```

