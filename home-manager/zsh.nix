{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    programs.zsh = {
      enable = true;
 
      shellAliases = {
        # ls
        l = "ls -lh";
        ll = "ls -lah";
        la = "ls -A";
        lm = "ls -m";
        lr = "ls -R";
        lg = "ls -l --group-directories-first";

        # rsync version of cp
        rcp = "rsync -ah --progress -A -X -U -N";

        # git
        gcd = "git clone --depth 1";
        gc = "git commit -m";
        gp = "git push origin --all";
        gt = "git tag";
        ghv = "gh repo view";

        get_pub_ip = "curl https://ipinfo.io/ip; echo";

        create_rand_pwd="openssl rand -base64 8";

        rm = "echo 'Oh MY GOD! Sab delete ho gya kya !.'; false";
        tp = "trash-put";  #"gio trash";
        diff = "diff --color=always";
        less = "less -R";

        start_web_server="updog -p 5000 -d $HOME/shared-drive"; #"webfsd -p 5000 -r $HOME/shared-drive"
        stop_web_server="kill \$(pgrep updog --oldest)";  # webfsd
        nps="npm run start";
        npd="nodemon run dev";

        view = "vim -R";
        gdb = "cgdb";
      
        lsl = "LD_LIBRARY_PATH=/home/adityag/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib SQL_USERNAME=adityag DB_NAME=wifi /usr/bin/lsl";
        lsl-safe = "LD_LIBRARY_PATH=/home/adityag/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib SQL_USERNAME=adityag DB_NAME=safewifi /usr/bin/lsl";

        rmlint = "rmlint --no-hardlinked --no-crossdev";

        arduino_compile = "arduino-cli compile --fqbn arduino:avr:uno";
        arduino_upload = "arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno";

        code = "codium";
      };
    };

    programs.zsh.oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "man" "copybuffer" "copyfile" "copypath" ];
    };
 
    # @ref: https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
    programs.zsh = {
      enableAutosuggestions = true;
      enableCompletion = true;
      
      enableSyntaxHighlighting = true;

      # disable cd into directory with just the name to ensure consistency @adi-g15
      autocd = false;
      # Extra commands to add to .zshrc
      initExtra = ''
        # @ref: @man: `zshoptions`
        setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
        setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
      
        echo "GDrive Backup kar"
      '';
    };

    # ek localVariables ka option bhi tha, sayad wo exported nhi hote bas
    programs.zsh.sessionVariables = {
      # @ref: https://github.com/cpm-cmake/CPM.cmake#CPM_SOURCE_CACHE
      CMAKE_EXPORT_COMPILE_COMMANDS = true;
      CPM_SOURCE_CACHE = "$HOME/.cache/CPM";
      CPM_USE_LOCAL_PACKAGES = true;

      MAKEFLAGS = "-j8";
      NVM_LAZY_LOAD = true;
    };

    programs.zsh.history = {
      # save timestamp also
      extended = true;

      # ignore command if duplicate to previous command
      ignoreDups = true;

      ignorePatterns = [];

      # don't ignore commands starting with space
      ignoreSpace = false;

      path = ".zsh_history";    # relative to $HOME

      save = 10000000;  # SAVEHIST
      size = 10000000;  # HISTSIZE

      # share command history b/w zsh sessions
      share = true;
    };
  };

  # to get completion for system packages (eg. systemd)
  # @ref: https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
  environment.pathsToLink = [ "/share/zsh" ];
}

# ex: shiftwidth=2 expandtab:
