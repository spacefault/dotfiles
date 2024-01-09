CC=g++
CFLAGS=-Wall

all: installer

installer: main.cxx
	@echo "dotfile installation"
	@echo
	@echo "This makefile will let you import the dotfiles I use on my computer to your system."
	@echo "If you want to sync with upstream, you can return anytime and run 'git pull'."
	@echo "When you install, the existing files at ~/.config will be **REMOVED**, so please be careful."
	@echo "You can see what will be removed prior to installation by running 'make check'."
	@echo "This is designed for personal use only! Please be careful. (I am not responsible for damages to your system)"
	@echo
	@echo "use 'make install' to install, 'make check' to check what's going to happen, and 'make uninstall' to uninstall."
	@echo
	$(CC) $(CFLAGS) -o installer main.cxx

install: 
	./installer install

uninstall:
	rm -rf $(HOME)/.config/{anyrun,waybar,kitty,hypr,swaylock,dunst}

check:
	./installer check
clean:
	rm installer