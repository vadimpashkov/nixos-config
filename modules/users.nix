{ config, pkgs, hostname, users, ... }:

let
  userConfigs = map (user: {
    "${user.username}" = {
      isNormalUser = true;
      home = "/home/${user.username}";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "video" ];
    };
  }) users;
in
{
  users.users = lib.mkMerge userConfigs;
}
