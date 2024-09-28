{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
