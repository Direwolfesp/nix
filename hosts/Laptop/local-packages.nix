{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    openssl
    gdb
    gnumake
    cmake
    cargo
    rustc
    zig
    zls
    fzf
    vim
    git
    wget
    curl
    zenity
    libnotify
  ];
}
