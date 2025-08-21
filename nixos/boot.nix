{ pkgs, ... }:
{
  # Bootloader.
  boot = {
    loader.grub.enable = true;
    loader.grub.device = "/dev/nvme0n1";
    loader.grub.useOSProber = true;

    # Use zen kernel.
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };
}
