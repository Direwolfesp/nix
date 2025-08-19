{ pkgs, lib, ... }:
{
  imports = [
    ./firefox.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./jj.nix
    ./sioyek.nix
    ./nixcord.nix
  ];

  # NOTE: here we can enable/disable each application
  # indepently, maybe based on host.
  config.modules.firefox.enable = true;
  config.modules.ghostty.enable = true;
  config.modules.git.enable = true;
  config.modules.helix.enable = true;
  config.modules.jujutsu.enable = true;
  config.modules.sioyek.enable = true;
  config.modules.nixcord.enable = true;
}
