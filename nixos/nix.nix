  {
    # enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # garbage collection
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  }
