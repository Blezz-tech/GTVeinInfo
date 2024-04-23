{ pkgs ? import <nixpkgs> { }
}:
pkgs.mkShell {
  packages = [
    pkgs.jdk
  ];

  shellHook = ''
    mkdir -p build

    javac -d build @<(find -name "*.java")

    cd build

    jar cvfm $PROGRAM_NAME /build/src/META-INF/MANIFEST.MF *
  '';
}
