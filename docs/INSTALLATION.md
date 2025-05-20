# Installation Steps

1. Download the Arch Linux ISO (and verify it)
2. Create a bootable USB drive (you can use Ventoy)
3. Boot into the USB
4. Setup a working internet connection using `iwctl`
5. Use the `archinstall` script to set up a base system with Hyprland
6. After logging in for the first time, run `sudo pacman -Syu` to update the system
   - If it doesn't work, your wifi probably isn't working.
7. Run the install script using the command below

## WARNING

It is a safe practice to first download scripts locally and verify them before running them.

The below command will immediately run the script upon downloading it.

Only run the command if you trust me or have already verified the script.

```bash
curl -fsSL https://raw.githubusercontent.com/ShalevAri/dotfiles/main/setup.sh | bash
```

If you want to only download the script and run it later manually, for example after verifying it, you can use the commands below.

```bash
curl -LO https://raw.githubusercontent.com/ShalevAri/dotfiles/main/setup.sh # Download the script
```

You can now verify the script.

After you're done:

```bash
chmod +x setup.sh # Make the script executable
```

```bash
./setup.sh # Run the script
```
