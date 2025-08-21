# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  systemSettings,
  userSettings,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # X11
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true; # Enable the XFCE Desktop Environment.

    # keymap
    xkb = {
      layout = "es";
      variant = "nodeadkeys";
      options = lib.mkForce "caps:swapescape"; # swap
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
