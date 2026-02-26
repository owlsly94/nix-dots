{ pkgs-unstable, ... }:

{
  # Use unstable versions of fast-moving packages for stability and features
  # This overlay allows us to maintain static versions for most packages
  # while getting timely updates for apps that benefit from newer releases
  nixpkgs.overlays = [
    (final: prev: {
      lutris = pkgs-unstable.lutris;
      vscode = pkgs-unstable.vscode;
      discord = pkgs-unstable.discord;
    })
  ];
}
