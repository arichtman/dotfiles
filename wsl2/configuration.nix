{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    nixos-wsl.nixosModules.wsl
    (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };
  virtualisation.docker = {
    autoPrune.enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };
  virtualisation.docker = {
    # Installs root
    rootless.enable = true;
    # Sets env var to direct cli to the rootless socket
    rootless.setSocketVariable = true;
  };
  users.users.nixos = {
    # Grants our user permissions to the docker daemon
    extraGroups = [ "docker" ];
    # Marks our user for the socket environment variable
    isNormalUser = true;
  };
  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  # Set system packages
  environment.systemPackages = with pkgs; [
  ];
  # Enable VSCode server service
  services.vscode-server.enable = true;
  # Enable unfree packages (for vscode)
  # nixpkgs.config.allowUnfree = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.05";
}



