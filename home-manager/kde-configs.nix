{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { ... }: {
    xdg.configFile."kglobalshortcutsrc".text = ''
      [org.flameshot.Flameshot.desktop]
      Capture=Print,none,Take screenshot
      Configure=none,none,Configure
      Launcher=Meta+Print,none,Open launcher
      _k_friendly_name=Flameshot
      _launch=none,none,Flameshot
  
      [org.kde.dolphin.desktop]
      _k_friendly_name=Dolphin
      _launch=Meta+E,Meta+E,Dolphin
  
      [org.kde.krunner.desktop]
      RunClipboard=Alt+Shift+F2,Alt+Shift+F2,Run command on clipboard contents
      _k_friendly_name=KRunner
      _launch=Alt+Space\tAlt+F2\tSearch,Alt+Space\tAlt+F2\tSearch,KRunner
  
      [org.kde.plasma.emojier.desktop]
      _k_friendly_name=Emoji Selector
      _launch=Meta+.,Meta+.,Emoji Selector
  
    '';
  };
}
