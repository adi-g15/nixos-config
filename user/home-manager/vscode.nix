{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        github.copilot
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "rust-analyzer";
          publisher = "rust-lang";
          version = "0.4.1354";
          sha256 = "sha256-WGljVkkcUhEoH3NDKjVcDVSboVkOt0v5gVu38vhiPXw=";
        }
      ];

      # @adig Is tarah extensions manually update/install nhi honge
      #mutableExtensionsDir = false;

      userSettings = {
        "files.autoSave" = "off";
        "[nix]"."editor.tabSize" = 2;
      };

      # @FUTURE: Interesting property h, build/run command create kar sakte h
      userTasks = {};
    };
  };
}
