{ pkgs, ... }:

with pkgs; [
  # 3-D printing tool
  orca-slicer
  # CAD
  freecad-wayland
  # Media Player
  vlc
  # Chromium for nand IDE
  ungoogled-chromium
]
