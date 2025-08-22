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

    # Stylix
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux"; # Your architecture
        host = "Laptop"; # One of: {Laptop, Desktop}
        hostname = "dire-laptop"; # select your hostname
        timezone = "Europe/Madrid"; # select timezone
        defaultLocale = "en_US.UTF-8"; # select locale
      };

      pkgs = import nixpkgs { system = systemSettings.system; };

      userSettings = {
        # Core
        username = "dire";
        name = "Direwolfesp";
        email = "alvarolg365@gmail.com";

        # Program preferences
        shell = "nushell"; # Default shell, same name as in nixpkgs
        editor = "helix"; # Default editor, same name as in nixpkgs
        term = "ghostty"; # Default terminal, same name as in nixpkgs
        web_browser = "firefox"; # Default browser, same name as in nixpkgs

        # Looks
        theme = "uwunicorn"; # Same name as in ./themes/
        font = "JetBrainsMono Nerd Font"; # Font name, same name as in `fc-list : family`
        fontPkg = pkgs.nerd-fonts.jetbrains-mono; # Font package to use
      };

    in
    {
      nixosConfigurations.${systemSettings.hostname} = nixpkgs.lib.nixosSystem rec {
        system = systemSettings.system;

        modules = [
          ./hosts/${systemSettings.host}/configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userSettings.username}.imports = [ ./home-manager/home.nix ];
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.sharedModules = [
              inputs.nixcord.homeModules.nixcord
            ];
          }
        ];

        specialArgs = {
          # pass config variables
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
}
