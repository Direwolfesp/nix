{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    gnumake
    cmake
    fzf
    vim
    git
    wget
    curl
    zenity
    libnotify
  ];
}
