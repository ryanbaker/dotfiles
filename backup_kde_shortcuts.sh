#!/bin/bash
BACKUP_DIR=.

# Main shortcut configuration files
cp ~/.config/kglobalshortcutsrc $BACKUP_DIR/
cp ~/.config/khotkeysrc $BACKUP_DIR/
cp ~/.config/kwinrc $BACKUP_DIR/
cp ~/.config/kdeglobals $BACKUP_DIR/

# Plasma-specific shortcuts
cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc $BACKUP_DIR/ 2>/dev/null || true

echo "Keyboard shortcuts backed up to: $BACKUP_DIR"
