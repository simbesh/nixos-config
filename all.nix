{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  envVariables = lib.importTOML ./env.toml;
  unstable =
    import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixos-unstable)
    # reuse the current configuration
    {config = config.nixpkgs.config;};
in {
  imports = [
    ./de.nix
    ./homemanager.nix
    ./nvidia.nix
    ./hardware.nix
    ./drives.nix
  ];

  # TOP LEVEL CONFIG
  nixpkgs.config.allowUnfree = true;
  #boot.kernelPackages = pkgs.linuxPackages_zen;

  # NETWORKING
  networking.wireless = {
    enable = false;
    userControlled.enable = true;
    networks = {
      ${envVariables.wifi.ssid} = {
        psk = envVariables.wifi.password;
      };
    };
  };

  # Extra programs that can't/should'nt install via systemPackages
  services.flatpak.enable = true;
  programs.steam.enable = true; # so far, this is the best option. Flathub version less so, systemPackage version sucks
  programs.firefox.enable = true;
  programs.dconf.enable = true; # https://github.com/NixOS/nixpkgs/issues/207339#issuecomment-1747101887

  programs.firefox = {
    # ff addon - https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/
    # enable = true;
    # package = pkgs.firefox;
    nativeMessagingHosts.packages = [unstable.firefoxpwa];
  };

  environment.systemPackages = with pkgs; [
    (callPackage ./cursor.nix {})
    unstable.firefoxpwa # ff addon - https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/

    # System Utils
    git
    htop
    pciutils
    wget
    alejandra # nix code formatter

    # Media Apps
    spotify

    # Commumincation Apps
    telegram-desktop
    discord

    # Productivity Apps
    libreoffice
    obsidian
    google-drive-ocamlfuse
    thunderbird
    teams-for-linux

    # Developer applications
    git
    vscode
    # unstable.zed-editor # ironically, terribly slow. Probably just needs better nix support
    # note, jetbrains products via systemPackages don't work. Use toolbox instead
    jetbrains-toolbox
    bruno

    # SDKs
  ];
}
