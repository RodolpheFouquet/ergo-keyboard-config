# Keyboard Firmware Commands

This document lists all available commands for generating and flashing firmware for each keyboard type in this repository.

## Prerequisites

1. Install direnv: `direnv allow`
2. Enter nix shell: `nix develop` (or use direnv automatically)

## Keyboard Types

This repository supports three keyboard types:
- **Totem** (seeeduino_xiao_ble controller)
- **Eyelash Corne** (custom board)
- **Sofle** (nice_nano_v2 controller)

## Firmware Generation Commands

### Totem
```bash
# Build both left and right firmware
nix build .#totem

# Build output location: ./result/
```

### Eyelash Corne
```bash
# Build both left and right firmware  
nix build .#eyelash_corne

# Build output location: ./result/
```

### Sofle
```bash
# Build both left and right firmware
nix build .#sofle

# Build output location: ./result/
```

### Build All Keyboards
```bash
# Build all keyboards at once
nix build .#totem .#eyelash_corne .#sofle
```

## Flashing Commands

### Totem
```bash
# Flash firmware to connected device
nix run .#flash-totem
```

### Eyelash Corne
```bash
# Flash firmware to connected device
nix run .#flash-eyelash_corne
```

### Sofle
```bash
# Flash firmware to connected device
nix run .#flash-sofle
```

## Additional Commands

### Update Dependencies
```bash
# Update ZMK and dependencies
nix run .#update
```

### Development Shell
```bash
# Enter development environment
nix develop
```

## Manual Flashing

If automatic flashing doesn't work, you can manually flash the generated firmware:

1. Build the firmware using the commands above
2. Put your keyboard into bootloader mode
3. Copy the appropriate `.uf2` file from `./result/` to the mounted bootloader drive

### Firmware File Locations

After building, firmware files are located in `./result/`:
- `totem_left.uf2` and `totem_right.uf2`
- `eyelash_corne_left.uf2` and `eyelash_corne_right.uf2`  
- `sofle_left.uf2` and `sofle_right.uf2`

## Configuration Files

Each keyboard has its configuration files in:
- Totem: `config/boards/shields/totem/`
- Eyelash Corne: `boards/arm/eyelash_corne/` and `config/`
- Sofle: `config/sofle.keymap` and `config/sofle.conf`