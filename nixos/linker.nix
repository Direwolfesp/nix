{ pkgs, ... }:
{
  # Setup for running FHS foreign dynamically linked execs
  # like crackmes
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    zlib
    libcxx
    libgcc
    openssl
    libxcrypt
  ];
}
