{ ... }:
              
{
  imports = [
    <home-manager/nixos>
  ];
            
  home-manager.users.adityag = { config, pkgs, ... }: {  
    programs.git = {
      enable = true;
      diff-so-fancy.enable = true;

      userName = "Aditya Gupta";
      userEmail = "me.adityag15@gmail.com";
              
      extraConfig = {
        core = { editor = "nvim"; };
        init = { defaultBranch = "main"; };
        pull = { rebase = false; };
        tag = { gpgSign = true; };
        color = { ui = "auto"; };
      };
      
      signing = {
        key = "97EE50F0010EDA0C";
        signByDefault = true;
      };
      includes = [
        {
          # Instead of path, can also specify `contents`
          path = "~/shunya-iotiot/.gitconfig_include";
          condition = "gitdir:~/shunya-iotiot/";
        }
        {
          path = "~/os-projects/.gitconfig_include";
          condition = "gitdir:~/os-projects";
        }
      ];
    };

    # WARNING: still copy the ~/.gnupg directory to maintain the keys
    programs.gpg.enable = true;
  };
}

# ex: shiftwidth=2 expandtab: 
