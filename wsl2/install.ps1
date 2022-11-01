
$DistroURL = "https://github.com/nix-community/NixOS-WSL/releases/download/22.05-5c211b47/nixos-wsl-installer.tar.gz"
Start-BitsTransfer -Source $DistroURL
wsl --import NixOS .\NixOS\ nixos-wsl-installer.tar.gz --version 2
wsl --set-default NixOS
# NixOS has some boot issues that need it to restart a couple times
Start-Job { wsl }
# A minute should be plenty for it to get stuck
Start-Sleep -Seconds 60
wsl --terminate NixOS
# Run a no-op so it runs startup again
wsl --exec :
# I'm pretty sure it hangs again and needs but I forget.
Start-Sleep -Seconds 60
wsl --terminate NixOS

# I might try rolling it all into one later
# $InstallScript = Get-Content ".\install.sh"
# wsl --exec $InstallScript
# Clean up
Remove-Item -Force nixos-wsl-installer.tar.gz
