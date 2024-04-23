{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      systems = [ "x86_64-linux" ];
    in
    flake-utils.lib.eachSystem systems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.mkShell {
          packages = [
            pkgs.jdk
          ];

          shellHook = ''      
            mkdir -p build

            javac -d build @<(find -name "*.java")

            cd build

            jar cvfm $PROGRAM_NAME ../src/META-INF/MANIFEST.MF *
          
            alias runapp='java -jar ./build/$PROGRAM_NAME'
          '';
        };
      });
}
