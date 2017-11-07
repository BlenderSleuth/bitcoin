
Debian
====================
This directory contains files used to package schleemsd/schleems-qt
for Debian-based Linux systems. If you compile schleemsd/schleems-qt yourself, there are some useful files here.

## schleems: URI support ##


schleems-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install schleems-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your schleems-qt binary to `/usr/bin`
and the `../../share/pixmaps/schleems128.png` to `/usr/share/pixmaps`

schleems-qt.protocol (KDE)

