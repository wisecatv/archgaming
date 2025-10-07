#!/bin/bash

set -euo pipefail

echo "
| Arch Linux Gaming Optimization |
>>> github.com/logicalthinkerv/archgaming
"

# Function for enabling multilib repo (if not enabled)
enable_multilib() {
    if ! grep -q '\[multilib\]' /etc/pacman.conf; then
        echo "Enabling multilib repository..."
        sudo sed -i '/\[multilib\]/,+1s/^#//' /etc/pacman.conf
        sudo pacman -Sy
    else
        echo "Multilib repository already enabled."
    fi
}

# Function for installing GPU drivers based on detected GPUs
install_gpu_drivers() {
    echo "Detecting GPUs..."
    gpu_list=$(lspci | grep -iE "vga|3d|display" | sed 's/.*: //')

    echo "Detected GPUs:"
    echo "$gpu_list"

    multi_gpu=false

    if echo "$gpu_list" | grep -iq "NVIDIA"; then
        echo "Installing NVIDIA drivers..."
        sudo pacman -S --noconfirm nvidia-dkms nvidia-settings nvidia-utils lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia libvdpau libxnvctrl
        multi_gpu=true
    fi

    if echo "$gpu_list" | grep -iq "AMD"; then
        echo "Installing AMD drivers..."
        sudo pacman -S --noconfirm mesa lib32-mesa mesa-utils mesa-vdpau lib32-mesa-vdpau lib32-vulkan-radeon vulkan-radeon glu lib32-glu xf86-video-amdgpu vulkan-icd-loader lib32-vulkan-icd-loader vulkan-tools
        multi_gpu=true
    fi

    if echo "$gpu_list" | grep -iq "Intel"; then
        echo "Installing Intel drivers..."
        sudo pacman -S --noconfirm mesa lib32-mesa mesa-utils vulkan-intel lib32-vulkan-intel intel-media-driver glu lib32-glu linux-firmware
        multi_gpu=true
    fi

    if ! $multi_gpu; then
        echo "No supported GPU detected."
    fi

    echo "Installing Vulkan support..."
    sudo pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
}

# Function to install yay AUR helper
install_yay() {
    echo "Installing yay AUR helper..."

    if command -v yay &> /dev/null; then
        echo "yay already installed."
        return
    fi

    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir"
    cd "$tmpdir"
    makepkg -si --noconfirm
    cd -
    rm -rf "$tmpdir"
}

# Function to install Microcode based on CPU vendor
install_cpu_microcode() {
    cpu_vendor=$(lscpu | grep "Vendor ID:" | awk '{print $3}')
    echo "Detected CPU Vendor: $cpu_vendor"

    if [[ "$cpu_vendor" == "GenuineIntel" ]]; then
        echo "Installing Intel microcode..."
        sudo pacman -S --noconfirm intel-ucode
    elif [[ "$cpu_vendor" == "AuthenticAMD" ]]; then
        echo "Installing AMD microcode..."
        sudo pacman -S --noconfirm amd-ucode
    else
        echo "Unknown CPU vendor, skipping microcode installation."
    fi
}

# Update system and enable multilib repo
echo "Updating system and enabling multilib repository if needed..."
sudo pacman -Syyu --noconfirm base-devel git
enable_multilib

# Install yay
install_yay

# Install GPU drivers
install_gpu_drivers

# Install Zen kernel
echo "Installing Zen kernel..."
sudo pacman -S --noconfirm linux-zen linux-zen-headers

# Install CPU microcode
install_cpu_microcode

# Install Vulkan and other gaming tools
echo "Installing Vulkan packages..."
sudo pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader

# Prompt for game launchers installation
while true; do
    read -rp "Do you want to install Games Launchers (Lutris/Heroic/Steam)? [y/n]: " launchers
    case "$launchers" in
        y|Y)
            echo "Installing game launchers..."
            sudo pacman -S --noconfirm steam lutris
            install_yay
            yay -S --noconfirm heroic-games-launcher-bin
            break
            ;;
        n|N)
            echo "Skipping game launchers installation."
            break
            ;;
        *)
            echo "Please enter y or n."
            ;;
    esac
done

# Prompt for MangoHud installation
while true; do
    read -rp "Do you want to install MangoHud? [y/n]: " mangohud
    case "$mangohud" in
        y|Y)
            echo "Installing MangoHud..."
            sudo pacman -S --noconfirm mangohud lib32-mangohud
            break
            ;;
        n|N)
            echo "Skipping MangoHud installation."
            break
            ;;
        *)
            echo "Please enter y or n."
            ;;
    esac
done

# Install GameMode
echo "Installing GameMode..."
sudo pacman -S --noconfirm gamemode lib32-gamemode
sudo usermod -aG gamemode "$USER"
# Copy custom config if provided (optional)
if [[ -f gamemode.ini ]]; then
    echo "Copying custom GameMode config..."
    sudo mkdir -p /usr/share/gamemode
    sudo cp gamemode.ini /usr/share/gamemode/
fi
systemctl --user enable --now gamemoded

# Optimize Steam settings
echo "Optimizing Steam settings..."
sudo tee /etc/sysctl.d/gamecompatibility.conf > /dev/null <<EOF
vm.max_map_count = 2147483642
EOF

# Summary
cat << EOF

| [+] Installed essential packages and drivers.
| [+] Installed yay (AUR Helper).
| [+] Installed Zen kernel (low-latency gaming kernel).
| [+] Installed GameMode.
| [+] Optimized Steam for gaming.

TIPS:
| * For Steam games, add 'gamemoderun %command%' to launch options.
| * Enable GameMode in Heroic Games Launcher and Lutris game options.
| * On laptops, enable "Use Dedicated Graphics Card" in Heroic and Lutris settings.

Please reboot your system to apply all changes.

EOF
