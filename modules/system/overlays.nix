{ pkgs-unstable, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      lutris = pkgs-unstable.lutris;
      vscode = pkgs-unstable.vscode;
      discord = pkgs-unstable.discord;
    })
  ];
}
