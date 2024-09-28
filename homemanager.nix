{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.root = {
    home.stateVersion = "24.05";

    programs.git = {
      enable = true;
      userName = "Simon Bechard";
      userEmail = "simon.bechard@gmail.com";
    };
  };

  home-manager.users.simon = {
    home.stateVersion = "24.05";

    programs.git = {
      enable = true;
      userName = "Simon Bechard";
      userEmail = "simon.bechard@gmail.com";
    };
  };
}
