{ pkgs, ...}:
{  
  environment.systemPackages = with pkgs; [
    home-manager
    gcc
    gdb
    gnumake
    cmake
    fzf
    vim
    git
    wget
    curl
  ];
}
