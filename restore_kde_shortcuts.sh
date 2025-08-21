cp kglobalshortcutsrc ~/.config/
cp khotkeysrc ~/.config/
cp kwinrc ~/.config/
cp kdeglobals ~/.config/

# Restore plasma config
cp plasma-org.kde.plasma.desktop-appletsrc ~/.config/ 2>/dev/null || true

echo "Restart KDE for changes to take effect"
