{
  description = "Nixos configuration";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home-manager oficial repo
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux"; # Your architecture
        host = "Laptop"; # One of: {Laptop, Desktop}
        hostname = "dire-laptop"; # select your hostname
        timezone = "Europe/Madrid"; # select timezone
        defaultLocale = "en_US.UTF-8"; # select locale
      };

      userSettings = {
        username = "dire";  
        name = "Direwolfesp";
        email = "alvarolg365@gmail.com";
        term = "ghostty";
        editor = "helix";
      };

    in {
    
    nixosConfigurations.${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
      system =  systemSettings.system;

      modules = [
        ./hosts/${systemSettings.host}/configuration.nix
      ];

      specialArgs = {
        # pass config variables
        inherit systemSettings;
        inherit userSettings;
      };
    };

    homeConfigurations.${systemSettings.hostname} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};

      modules = [ ./home-manager/home.nix ];

      extraSpecialArgs = {
        # pass config variables
        inherit systemSettings;
        inherit userSettings;
      };     
    };
  };
}
