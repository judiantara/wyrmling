{ lib, config, pkgs, user, hostname, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    gnumake

    # shell
    nix-zsh-completions
    zsh-fzf-history-search
    ondir
    tmux
    mc

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq      # A lightweight and flexible command-line JSON processor
    yq-go   # yaml processor https://github.com/mikefarah/yq
    eza     # A modern replacement for ‘ls’
    fzf     # A command-line fuzzy finder
    btop    # replacement of htop/nmon
    iotop   # io monitoring
    iftop   # network monitoring
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    zip
    xz
    unzip
    openssl
    cfssl
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      path           = "$HOME/.zsh_history";
      size           = 10000;
      share          = true;
      ignoreAllDups  = true;
      ignoreSpace    = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
        "sudo -i"
      ];
    };

    historySubstringSearch = {
      enable        = true;
      searchUpKey   = ''''${key[Up]}'';
      searchDownKey = ''''${key[Down]}'';
    };

    shellAliases = {
      ll         = "ls -l";
      syup       = "/home/${user}/.local/bin/sysupdate";
      byup       = "/home/${user}/.local/bin/bootupdate";
      age        = "/run/current-system/sw/bin/rage";
      poweroff   = "/run/wrappers/bin/sudo poweroff";
      reboot     = "/run/wrappers/bin/sudo reboot";
      sv         = "/run/wrappers/bin/sudo /run/current-system/sw/bin/systemctl";
      svstatus   = "sv status";
      svrestart  = "sv restart";
      svstop     = "sv stop";
      svstart    = "sv start";
      svlog      = "/run/wrappers/bin/sudo /run/current-system/sw/bin/journalctl -fu";
      clh        = "/run/wrappers/bin/sudo /run/current-system/sw/bin/machinectl shell ${user}@";
      svu        = "/run/current-system/sw/bin/systemctl --user";
      svustatus  = "svu status";
      svurestart = "svu restart";
      svustop    = "svu stop";
      svustart   = "svu start";
    };

    initExtra = ''
export PAGER=/run/current-system/sw/bin/more
export EDITOR=nano

# install ondir
eval_ondir() {
  eval "`${pkgs.ondir}/bin/ondir \"$OLDPWD\" \"$PWD\"`"
}

chpwd_functions=( eval_ondir $chpwd_functions )

# install gitfunctions
if [ -e ~/.config/gitfunctions ]; then . ~/.config/gitfunctions; fi
    '';

    loginExtra = ''
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  ${pkgs.tmux}/bin/tmux has-session -t ssh-tmux &> /dev/null
  if [ $? -eq 1 ]; then
    exec ${pkgs.tmux}/bin/tmux new-session -s ${hostname}-ssh-tmux
    exit
  else
    exec ${pkgs.tmux}/bin/tmux attach-session -t ${hostname}-ssh-tmux
    exit
  fi
fi
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      scan_timeout = 100;
      command_timeout = 1500;

      format = "$username$hostname$shlvl$directory$kubernetes$git_branch$git_commit$git_state$git_status$docker_context$package$cmake$dart$dotnet$elixir$elm$erlang$golang$helm$java$julia$nim$nodejs$ocaml$perl$php$purescript$python$ruby$rust$swift$terraform$zig$nix_shell$conda$memory_usage$aws$gcloudopenstack$line_break$jobs$battery$time$status$line_break$character";

      hostname = {
        ssh_only = false;
        format = "⟪$hostname⟫";
      };

      username = {
        show_always = true;
      };

      cmd_duration = {
        disabled = true;
      };

      line_break = {
        disabled = false;
      };

      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
        format = "\n[$path]($style)[$read_only]($read_only_style)";
      };

      kubernetes = {
        disabled = false;
        format = "\n[$symbol$context - $namespace]($style)";
      };

      git_branch = {
        format = "\n[$symbol$branch]($style) ";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
      };
    };
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file = {
    ".local/bin/git-pullup" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        set -eou pipefail

        target_branch=''${1:-master}
        current_branch=$(/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD)
        echo "Will pull up upstream/$target_branch and merge into origin/$target_branch"
        /run/current-system/sw/bin/git checkout $target_branch
        /run/current-system/sw/bin/git fetch origin -p -v
        /run/current-system/sw/bin/git fetch upstream -p -v
        /run/current-system/sw/bin/git merge upstream/$target_branch
        /run/current-system/sw/bin/git push origin --tags
        /run/current-system/sw/bin/git checkout $current_branch
      '';
    };

    ".local/bin/sysupdate" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        set -euo pipefail

        /run/wrappers/bin/sudo /run/current-system/sw/bin/nixos-rebuild switch
      '';
    };

    ".local/bin/bootupdate" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        set -euo pipefail

        sudo /run/current-system/sw/bin/nixos-rebuild boot
      '';
    };

    ".ondirrc" = {
      text = ''
        enter /home/${user}/Workspaces/(.*)
          if [ -f $ONDIRWD/.ondir ]; then
            . $ONDIRWD/.ondir enter $ONDIRWD
            echo entering $1
          fi

        leave /home/${user}/Workspaces/(.*)
          if [ -f $ONDIRWD/.ondir ]; then
            . $ONDIRWD/.ondir leave $ONDIRWD
            echo leaving $1
          fi
      '';
    };

    ".gitconfig" = {
      text = ''
        [alias]
          pu         = !"~/.local/bin/git-pullup $2"
          ompull     = !/run/current-system/sw/bin/git pull --rebase --tags origin master
          ompush     = !/run/current-system/sw/bin/git push --tags origin master
          upstreamro = !/run/current-system/sw/bin/git remote set-url --push upstream DISABLE
          
        [credential]
          helper = store
      '';
    };

    ".config/gitfunctions" = {
      text = ''
        function br() {
          /run/current-system/sw/bin/git branch -v
        }

        function nb() {
          /run/current-system/sw/bin/git checkout -b "$@"
        }

        function cb() {
          /run/current-system/sw/bin/git checkout "$@"
        }

        function cu() {
          /run/current-system/sw/bin/git checkout -t "$@"
        }

        function fp() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          if [[ "$curbranch" == "master" ]]
          then
            echo "Cannot force push for master branch"
          else
            echo "Force push for $curbranch"
            /run/current-system/sw/bin/git push -uf origin $curbranch
          fi
        }

        function st() {
          /run/current-system/sw/bin/git status
        }

        function hist() {
          /run/current-system/sw/bin/git hist
        }

        function dfs() {
          /run/current-system/sw/bin/git diff --staged
        }

        function rst() {
          if [[ "$1" == "all" ]]; then
            local yn=
            vared -p "Do you want to revert all changes [y/N] " yn
            if [[ "$yn" =~ ^[yY]$ ]]; then
              /run/current-system/sw/bin/git restore --staged *
              /run/current-system/sw/bin/git restore *
            fi
          else
            if [[ "$1" == "-s" ]]; then
              shift
              /run/current-system/sw/bin/git restore --staged "$@"
            fi
            /run/current-system/sw/bin/git restore "$@"
          fi
        }

        function mr() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          if [[ "$curbranch" == "master" ]]
          then
            echo "Cannot create MR for master branch"
          else
            update-repo
            echo "Create MR for $curbranch"
            /run/current-system/sw/bin/git push -uf origin $curbranch
          fi
        }

        function ci() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          if [[ "$curbranch" == "master" ]]; then
            echo "Cannot Commit to master branch"
          else
            if (( $# == 0 )); then
              echo "Empty commit message"
            else
              /run/current-system/sw/bin/git commit -m "$@"
            fi
          fi
        }

        function cia() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          if [[ "$curbranch" == "master" ]]; then
            echo "Cannot Commit to master branch"
          else
            if (( $# == 0 )); then
              echo "Empty commit message"
            else
              /run/current-system/sw/bin/git commit --amend -m "$@"
            fi
          fi
        }

        function add() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          if [[ "$curbranch" == "master" ]]; then
            echo "Cannot add to master branch"
          else
            /run/current-system/sw/bin/git add -A
          fi
        }

        function prb() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          if [[ "$curbranch" == "master" ]]; then
            echo "Cannot prune master branch"
          else
            local yn=
            vared -p "Do you want prune branch $curbranch [y/N] " yn
            if [[ "$yn" =~ ^[yY]$ ]]; then
              echo "Pull update from upstream/master"
              /run/current-system/sw/bin/git checkout master || return 1
              /run/current-system/sw/bin/git pu master
              echo "Push update to origin/master"
              /run/current-system/sw/bin/git push
              echo "Pruning branch $curbranch"
              /run/current-system/sw/bin/git branch -D $curbranch
            fi
          fi
        }

        function rbm() {
          local curbranch=`/run/current-system/sw/bin/git rev-parse --abbrev-ref HEAD`
          echo "Pull update from upstream/master"
          /run/current-system/sw/bin/git checkout master
          /run/current-system/sw/bin/git pu master
          echo "Push update to origin/master"
          /run/current-system/sw/bin/git push
          if [[ "$curbranch" != "master" ]]; then
            echo "Rebasing branch $curbranch"
            /run/current-system/sw/bin/git checkout $curbranch
            /run/current-system/sw/bin/git rebase master
          fi
        }

        function rld() {
          local cwd=$PWD;
          cd ~
          cd $cwd
        }
      '';
    };
  };
}
