{ pkgs ? import <nixpkgs> { }
}:
pkgs.mkShell {
  packages = [
    pkgs.jdk
  ];

  env.PROGRAM_NAME = "app.jar";

  shellHook = ''
    mkdir -p build

    javac -d build @<(find -name "*.java")

    cd build

    jar cvfm $PROGRAM_NAME ../src/META-INF/MANIFEST.MF *
  
    alias runapp='java -jar ./build/$PROGRAM_NAME'

  '';
}
