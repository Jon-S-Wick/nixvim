{
  description = "Nix vim ";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    home-manager.url =
      "github:nix-community/home-manager"; # Home Manager flake input

  };
  outputs = { nixvim, flake-parts, nixpkgs, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {

      # homeManagerModules.nixvim = { system, pkgs, ... }:
      #
      #   let
      #     nixvimLib = nixvim.lib.${system};
      #     nixvim' = nixvim.legacyPackages.${system};
      #     nixvimModule = {
      #       inherit pkgs;
      #       inherit system; # or alternatively, set `pkgs`
      #       module = import ./config; # import the module directly
      #       # You can use `extraSpecialArgs` to pass additional arguments to your module files
      #       extraSpecialArgs = {
      #         # inherit (inputs) foo;
      #       };
      #     };
      #     nvim = nixvim'.makeNixvimWithModule nixvimModule;
      #   in { imports = [ ./config/default.nix ]; };
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { system, pkgs, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            inherit system; # or alternatively, set `pkgs`
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default =
              nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
          };
        };
    };
}
