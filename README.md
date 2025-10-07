# 🎮 Arch Linux Gaming Optimization Script

<div align="center">

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Bash](https://img.shields.io/badge/bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Gaming](https://img.shields.io/badge/gaming-optimized-blueviolet?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

**One-script solution to transform your Arch Linux into a gaming powerhouse!**

[Features](#-features) • [Installation](#-installation) • [What's Included](#-whats-included) • [Usage](#-usage) • [Tips](#-pro-tips)

</div>

---

## Features

- **Automatic GPU Detection** - Supports NVIDIA, AMD, and Intel graphics.
- **Zen Kernel** - Low-latency kernel optimized for gaming.
- **GameMode Integration** - Automatically optimize system performance while gaming.
- **MangoHud Support** - Beautiful in-game performance overlay (optional).
- **Game Launchers** - Easy installation of Steam, Lutris, and Heroic Games Launcher.
- **System Optimization** - Automatic system tuning for better gaming performance.
- **CPU Microcode** - Automatic detection and installation of Intel/AMD microcode.
- **Multilib Support** - Enables 32-bit library support for compatibility.

## 🔧 Installation

1) sudo pacman -S --noconfirm git && git clone 
2 ) cd  && chmod +x  && ./
```

## 📦 What's Included

### Core Components

| Component | Description | Status |
|-----------|-------------|--------|
| **yay** | AUR helper for additional packages | ✅ Auto-installed |
| **GPU Drivers** | NVIDIA/AMD/Intel drivers | ✅ Auto-detected |
| **Zen Kernel** | Low-latency gaming kernel | ✅ Auto-installed |
| **GameMode** | Performance optimization daemon | ✅ Auto-installed |
| **Vulkan** | Modern graphics API support | ✅ Auto-installed |
| **CPU Microcode** | Intel/AMD microcode updates | ✅ Auto-detected |

### Optional Components

| Component | Description | Prompt |
|-----------|-------------|--------|
| **Steam** | Valve's gaming platform | Interactive |
| **Lutris** | Open-source gaming platform | Interactive |
| **Heroic** | Epic Games & GOG launcher | Interactive |
| **MangoHud** | Performance overlay | Interactive |

## 💡 Usage

1. **Run the script:**
   ```bash
   ./archgaming.sh
   ```

2. **Follow the prompts:**
   - Choose whether to install game launchers
   - Choose whether to install MangoHud

3. **Reboot your system:**
   ```bash
   sudo reboot
   ```

4. **Start gaming!** 🎮

## 🎯 Pro Tips

### For Steam Games
Add this to your game's launch options:
```bash
gamemoderun %command%
```

### For Lutris/Heroic
- ✅ Enable **GameMode** in game settings
- ✅ Enable **MangoHud** for performance monitoring (if installed)
- 💻 On laptops: Enable **"Use Dedicated Graphics Card"**

### Custom GameMode Config
Place a `gamemode.ini` file in the same directory as the script for custom GameMode settings.

## 🖥️ GPU Support

| GPU Vendor | Drivers Installed | Vulkan Support |
|------------|-------------------|----------------|
| **NVIDIA** | nvidia-dkms, nvidia-utils | ✅ Full support |
| **AMD** | mesa, AMDGPU | ✅ Full support |
| **Intel** | mesa, Intel media driver | ✅ Full support |

## 🔍 System Optimizations

- **Multilib repository** enabled for 32-bit support
- **vm.max_map_count** set to 2147483642 (required for many games)
- **GameMode** configured and enabled
- **User added to gamemode group** for proper permissions

## 🤝 Contributing

Contributions are welcome! Feel free to:
- 🐛 Report bugs
- 💡 Suggest new features
- 🔧 Submit pull requests

## 📜 License

This project is licensed under the MIT License - feel free to use, modify, and distribute!

## ⭐ Support

If this script helped you, consider giving a star ⭐ to this repository!
