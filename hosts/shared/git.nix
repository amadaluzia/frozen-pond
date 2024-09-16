{
  username,
  config,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.git;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      config = {
        alias = {
          a = "add";
          aa = "add .";
          aliases = "! f(){ TOP=$(expr $(grep -n \"^\\\\\\\\[alias\" ~/.gitconfig | sed -e 's|:.*||') + 1) && for LINE_NUMBER in $(grep -n \"^\\\\\\\\[\" ~/.gitconfig | sed -e 's|:.*||'); do [ $TOP -lt $LINE_NUMBER ] && BOTTOM=$(expr $LINE_NUMBER - 2 ) && break; done; sed -n \"\${TOP},\${BOTTOM}p\" ~/.gitconfig; }; f | sed -e 's|^  ||'";
          ap = "add -p";
          b = "! git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's|refs/heads/||'";
          bD = "branch -D";
          ba = "branch -a";
          bc = "branch -c";
          bd = "branch -d";
          br = "branch -r";
          c = "! git commit --verbose; git push";
          ca = "! git c --amend";
          cf = "! git commit --verbose; git push --force";
          ch = "switch -C";
          change = "switch -C";
          cl = "clone";
          cm = "commit -m";
          co = "checkout "; # old/bad practice - switches branch and can modify worktree
          cp = "cherry-pick  ; usually abusive; sometimes necessary";
          create = "! git bc";
          d = "diff";
          dc = "diff --cached";
          ds = "diff --stat";
          expire = "! git fsck --unreachable --dangling --no-reflogs; git reflog expire --expire=now --all; git gc --prune=now";
          f = "fetch";
          fe = "fetch";
          filelog = "log --patch";
          find = "! git ls-files | grep -i";
          fl = "log --patch";
          fp = "fetch --prune ; removes branches not in upstream";
          gr = "grep -Ii";
          grep = "grep -Ii";
          greproot = "! git grr";
          grr = "! f() { ROOT=$(git rev-parse --show-toplevel) && cd $ROOT && git grep --full-name -In $1 | xargs -I{} echo $ROOT/{}; }; f";
          invert = "revert";
          l = "log --oneline --graph --decorate --parents";
          lasttag = "describe --tags --abbrev=0";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
          lref = "log --oneline --graph --decorate --parents --reflog";
          ls = "log --pretty=format:\"%C(yellow)%h\\\\ %ad%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --date=short";
          lt = "describe --tags --abbrev=0";
          mailmap = "! f(){ printf \\\"$(git config user.name) <$(git config user.email)> <\${1}>\\\" > mailmap; git filter-repo --force --mailmap mailmap; }; f";
          one = "log -1  ; no input displays HEAD";
          pd = "push -d";
          pf = "push --force";
          pl = "pull";
          pp = "pull --prune ; removes branches not in upstream";
          pr = "pull --rebase ; rebases commits onto upstream";
          ps = "push";
          pt = "! f(){ git push $1 tag $2; }; f";
          r = "rebase";
          ra = "rebase --skip";
          rc = "rebase --continue";
          re = "restore";
          ref = "reflog";
          ri = "rebase --interactive";
          rm = "rm -r";
          rmf = "! git rm --force";
          rq = "rebase --quit";
          rs = "rebase --abort";
          sh = "show";
          st = "status";
          sw = "switch   ; new checkout - only switching branch w/o restoring worktree";
          sync = "! git fe upstream; git rebase upstream/main; git push";
          t = "tag";
          td = "tag --delete";
          un = "restore --staged --worktree";
          uncommit = "switch -C";
          undo = "restore --staged --worktree";
          undo-specific = "! f(){ git restore --source=\\\"$1\\\" $2; }; f";
          undo-stage = "restore";
          undo-unstaged = "restore";
          undo-work = "restore --staged --worktree";
          undo-wt = "restore --staged --worktree";
          unstage = "restore --staged";
          wa = "! f(){ git worktree add ../$1 $1; }; f";
          wc = "! f(){ PROJ=$(printf $1 | sed -e 's|.*/||' | sed -e 's|.git||'); mkdir $PROJ; cd $PROJ; if git ls-remote $1 | grep -q \"main\"; then BRANCH=\"main\"; elif git ls-remote $1 | grep -q \"master\"; then BRANCH=\"master\"; elif git ls-remote $1 | grep -q \"trunk\"; then BRANCH=\"trunk\"; fi; git clone $1 $BRANCH; }; f";
          wcreate = "! git wc";
          wmv = "worktree move";
          wnew = "! f(){ git worktree add ../$1; cd ../$1; git push --set-upstream origin $1; }; f";
          wr = "worktree remove";
          wrm = "! git wr";
          wsc = "! f(){ PROJ=$(printf $1 | sed -e 's|.*/||' | sed -e 's|.git||'); mkdir $PROJ; cd $PROJ; if git ls-remote $1 | grep -q \"main\"; then BRANCH=\"main\"; elif git ls-remote $1 | grep -q \"master\"; then BRANCH=\"master\"; elif git ls-remote $1 | grep -q \"trunk\"; then BRANCH=\"trunk\"; fi; git clone --depth=1 --single-branch $1 $BRANCH; }; f";
          wshallow = "! git wsc";
        };
        branch = {
          autosetuprebase = "always";
        };
        color = {
          branch = "auto";
          diff = "auto";
          status = "auto";
        };
        commit = {
          gpgsign = "true";
        };
        user = {
          email = "balkenix@outlook.com";
          name = "Artur Manuel";
          signingKey = "55C20A84";
        };
      };
    };
  };
}
