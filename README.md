My dotfiles for Omarchy

# Installation
1. install `stow`
```bash
sudo pacman -S stow
```
2. From the current directory, run the following command:

```bash
stow -t ~/ .

# Setup syncthing on new machine

1. Install Syncthing: `sudo pacman -S syncthing`
2. Enable the service for your user: `sudo systemctl enable syncthing@sergei.service`
3. Start it: sudo systemctl start syncthing@sergei.service
```
