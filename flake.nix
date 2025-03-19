{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-kernelsu-builder = {
      url = "github:xddxdd/nix-kernelsu-builder";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };
  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.nix-kernelsu-builder.flakeModules.default
      ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        {
          kernelsu = {
            # Add your own kernel definition here
            galaxy-a10e = {
              # anyKernelVariant = "kernelsu";
              clangVersion = "latest";

              # kernelSU.variant = "next";
              # susfs = {
              #   enable = true;
              #   src = path/to/sufs/source;
              #   kernelsuPatch = ./patches/susfs-for-kernelsu-next.patch;
              # };

              kernelDefconfigs = [
                # "gki_defconfig"
                # "vendor/kalama_GKI.config"
                # "vendor/ext_config/moto-kalama.config"
                # "vendor/ext_config/moto-kalama-gki.config"
                # "vendor/ext_config/moto-kalama-rtwo.config"
              ];
              kernelImageName = "Image";
              kernelMakeFlags = [
                # "KCFLAGS=\"-w\""
                # "KCPPFLAGS=\"-w\""
              ];
              kernelSrc = ./kernel;
            };
          };
        };
    };
}
