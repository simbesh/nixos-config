{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Data Drive Mount
  fileSystems."/run/media/simon/C " = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs3";
    options = [
      # If you don't have this options attribute, it'll default to "defaults"
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      #"nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };
}
