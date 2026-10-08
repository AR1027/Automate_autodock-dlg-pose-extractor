# Automate Autodock DLG Pose Extractor

A lightweight Bash script to extract specific docking poses from AutoDock `.dlg` files without using MGLTools. Bypasses GUI parser errors.

## Prerequisites
* **awk** (Pre-installed on Linux/macOS)
* **Open Babel** (`obabel`)

## Quick Start
```bash
# 1. Make the script executable
chmod +x extract_pose.sh

# 2. Run the script (Usage: ./extract_pose.sh <input.dlg> <model_number>)
./extract_pose.sh dock.dlg 8
```
