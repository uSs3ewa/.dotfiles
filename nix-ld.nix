with import <nixpkgs> {};
mkShell {
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    stylua
    lua-language-server
    clang-tools
    # ...
  ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
}
