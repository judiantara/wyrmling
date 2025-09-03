{ ... }:

{
  programs.git = {
    enable = true;
    config = [
      {
        alias = {
          al         = ''add .'';
          br         = ''branch -v'';
          ci         = ''commit -m'';
          co         = ''checkout'';
          cb         = ''checkout -b'';
          df         = ''diff'';
          st         = ''status'';
          ri         = ''remote -v'';
          fp         = ''push -f'';
          rb         = ''pull --rebase'';
          cia        = ''commit --amend -m'';
          cfg        = ''config --list --show-origin'';
          dfs        = ''diff --staged'';
          rmb        = ''branch -d'';
          prb        = ''branch -D'';
          out        = ''log @{u}..'';
          hist       = ''log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'';
          type       = ''cat-file -t'';
          dump       = ''cat-file -p'';
        };

        column = {
          ui = "auto";
        };

        branch = {
          sort = "-committerdate";
        };

        tag = {
          sort = "version:refname";
        };

        init = {
          defaultBranch = "master";
        };

        diff = {
          algorithm      = "histogram";
          colorMoved     = "plain";
          mnemonicPrefix = "true";
          renames        = "true";
        };

        help = {
          autocorrect = "prompt";
        };

        apply = {
          # Remove trailing whitespaces
          whitespace = "fix";
        };

        commit = {
          verbose = "true";
        };

        rerere = {
          enabled = "true";
          autoupdate = "true";
        };

        fetch = {
          prune     = "true";
          pruneTags = "true";
          all       = "true";
        };

        rebase = {
          autoSquash = "true";
          autoStash  = "true";
          updateRefs = "true";
        };

        merge = {
          conflictstyle = "zdiff3";
        };

        pull = {
          rebase = "true";
        };

        core = {
          pager = "less -FRX";
        };

        pager = {
          diff = "less -FRX";
        };
      }
    ];
  };
}
