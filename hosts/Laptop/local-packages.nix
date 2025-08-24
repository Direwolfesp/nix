{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    gnumake
    cmake
    cargo
    rustc
    zig
    fzf
    vim
    git
    wget
    curl
    zenity
    libnotify
  ];
}
