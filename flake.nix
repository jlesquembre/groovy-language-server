{
  inputs.gradle2nix.url = "github:tadfisher/gradle2nix/v2";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, gradle2nix, nixpkgs }: {

    packages.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      gradle2nix.builders.x86_64-linux.buildGradlePackage {
        pname = "groovy-language-server";
        version = "1.0";
        src = ./.;
        lockFile = ./gradle.lock;
        gradleInstallFlags = [ "installDist" ];
        gradlePackage = pkgs.gradle_6;
        buildJdk = pkgs.openjdk8;
      };
  };
}
