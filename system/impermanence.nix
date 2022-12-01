# @ref: https://nixos.wiki/wiki/Impermanence
# @ref: https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/

{ config, pkgs, ... }:

let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{
  imports = [
    "${impermanence}/nixos.nix"
  ];

  # These files will be stored in the /nix/persist/system directory as given
  environment.persistence."/nix/persist/system" = {
    directories = [
      "/etc/nixos"      # will be bind mounted
      "/etc/NetworkManager"
      # "/var/log"	# not saving systemd journal for now
      "/var/lib/iwd"
      # "/var/lib/fprint"
    ];
    files = [
      # machine-id is used by systemd for journal, if not persisted, will not be able
      # to easily use journalctl to look at journals for previous boots
      "/etc/machine-id"
    ];
  };

  # Don't allow mutation of users outside of config
  users.mutableUsers = false;

  # To generate hash: nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.users.root.initialHashedPassword = "mypassword";
  users.users.adityag.password = "mypassword2";
}

# ex: shiftwidth=2 expandtab:
