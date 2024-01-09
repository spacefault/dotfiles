#include <iostream>
#include <string>
#include <cstdlib>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>
#include <fstream>

std::string currentUsername() {
    uid_t uid = geteuid();
    struct passwd *pw = getpwuid(uid);
    return pw->pw_name;
}

std::string cloneDir() {
    char buffer[FILENAME_MAX];
    if (getcwd(buffer, sizeof(buffer)) != nullptr) {
        return std::string(buffer);
    } else {
        perror("Error getting current working directory");
        return "";
    }
}

std::string dotdir = "/home/" + currentUsername() + "/.config";

void checkUser() {
    if (geteuid() == 0) {
        std::cerr << "\033[1;31mROOT ACCOUNT DETECTED\033[0m\n";
        std::cerr << "This Installer will NOT work when run as root!\n";
        std::cerr << "Running this script will install the files to /root, and not ~/\n";
        std::cerr << "Please run this as a normal user, and try again!\n";
        exit(1);
    }
}

void welcome() {
    std::cout << "\033[1mspacefault dotfiles installer\033[0m\n";
    std::cout << "Current User = " << currentUsername() << "\n";
    std::cout << "Current cloned directory = " << cloneDir() << "\n";
    std::cout << "Current .config directory = " << dotdir << "\n";
    std::cout << "Welcome to the spacefault dotfiles installer!\n";
    std::cout << "This installer will help you install and update the dotfiles\n";
    std::cout << "The installer will make symlinks from .config/ to here, so the files can be updated through git\n";
    std::cout << "Press enter to continue.\n";
    std::cin.ignore();
}

void overview() {
    std::cout << "====================\n";
    std::cout << "\033[1;31m>>> THESE FOLLOWING FILES WILL BE SYMLINKED, and the existing files at ~/.config will be **REMOVED!!** <<<\033[0m\n";
    std::cout << cloneDir() + "/anyrun/   ---SYMLINKED--> " + dotdir + "/anyrun/\n";
    std::cout << cloneDir() + "/waybar/   ---SYMLINKED--> " + dotdir + "/waybar/\n";
    std::cout << cloneDir() + "/kitty/    ---SYMLINKED--> " + dotdir + "/kitty/\n";
    std::cout << cloneDir() + "/hypr/     ---SYMLINKED--> " + dotdir + "/hypr/\n";
    std::cout << cloneDir() + "/swaylock/ ---SYMLINKED--> " + dotdir + "/swaylock/\n";
    std::cout << cloneDir() + "/dunst/    ---SYMLINKED--> " + dotdir + "/dunst/\n";
    std::cout << "\n";
    std::cout << "any existing configuration files at these locations will be REMOVED, including symlinks\n";
    std::cout << "\n";
    std::cout << "Press enter to continue.\n";
    std::cin.ignore();
}

void confirm() {
    std::cout << "\033[1;31m>>> CONFIRMATION REQUIRED <<<\033[0m\n";
    std::cout << "\n";
    std::cout << "YOU ARE ABOUT TO POTENTIALLY DO SOMETHING **IRREVERSIBLE**\n";
    std::cout << "It is HIGHLY recommended to backup your existing configuration files at $dotdir.\n";
    std::cout << "If you would like to turn back, now's your chance.\n";
    std::cout << "Press CTRL+C to exit the installer, and return to the terminal.\n";
    std::cout << "\n";
    std::cout << "If you would like to continue, read below\n";
    std::cout << "Please enter 'Yes, do as I say!' exactly as seen on the screen to continue (without the quotes)\n";
    std::cout << "\n";
    std::cout << ">>> ";
    std::string confirmcode;
    std::cin >> confirmcode;
    if (confirmcode != "Yes, do as I say!") {
        std::cout << "\033[1;31m>>> CONFIRMATION REJECTED <<<\033[0m\n";
        std::cout << "The Confirmation was rejected, and you must start over.\n";
        sleep(1);
        exit(1);
    } else {
        std::cout << "\033[1;32m>>> CONFIRMATION APPROVED <<<\033[0m\n";
        std::cout << "Approved!\n";
        std::cout << "Installation will resume in a few seconds.\n";
        sleep(5);
    }
}

void install() {
    std::cout << "Installing dotfiles..\n";
    std::cout << "DO NOT CLOSE THIS TERMINAL PROCESS UNTIL IT HAS COMPLETED.\n";
    std::string remove = "rm -rf " + dotdir + "/{anyrun,waybar,kitty,hypr,swaylock,dunst}";
    std::string symlink = "ln -sf " + cloneDir() + "/* " + dotdir + "/";
    system(remove.c_str());
    system(symlink.c_str());
    std::cout << "done\n";
}

void done() {
    std::cout << "Installation complete\n";
}

int main(int argc, char *argv[]) {
    checkUser();

    if (argc > 1) {
        std::string action = argv[1];
        if (action == "install") {
            welcome();
            overview();
            confirm();
            install();
            done();
        } else if (action == "check") {
            overview();
        } else {
            std::cerr << "Invalid action: " << action << std::endl;
            return 1;
        }
    } else {
        std::cerr << "Usage: " << argv[0] << " <action>" << std::endl;
        return 1;
    }

    return 0;
}