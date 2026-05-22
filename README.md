# Package Manager for Arch-like OS

## Project

This repository contains a set of Bash scripts that implement menus and utilities for package management, networking, and system maintenance on an Arch-like Linux distribution.## Goal

Provide an educational tool for an Operating Systems course that demonstrates:

- basic package management operations;
- organization of modular Bash scripts;
- automation of maintenance tasks and network diagnostics.

## Requirements

- System: Arch-based Linux distribution
- User with `sudo` privileges for install/remove operations
- Tools referenced (links):
  - Arch Linux: https://archlinux.org/
  - pacman (package manager): https://man.archlinux.org/man/pacman.8
  - Bash (scripting): https://www.gnu.org/software/bash/manual/
  - curl: https://curl.se/
  - wget: https://www.gnu.org/software/wget/
  - ShellCheck (script linting): https://www.shellcheck.net/

Install missing tools with `pacman` before running the scripts.

## How it was built

Repository structure (main files and directories):

- [main.sh](main.sh): entry point showing the main menu and calling modules.
- [lib/](lib/): support scripts and domain-specific menus:
  - `about.sh` — project information and authors
  - `network-menu.sh` — networking menu
  - `packageManaging-menu.sh` — package management menu
  - `systemMaintenance-menu.sh` — system maintenance menu
  - `network/` — network test/diagnostic scripts
  - `packageManaging/` — package action scripts (install, remove, update, search, info, etc...)
  - `systemMaintenance/` — cache cleaning and orphan package removal

Scripts are written in Bash and separated by responsibility to facilitate learning and maintenance. Each script contains a header describing its purpose.

## How to use

1. Make scripts executable (if necessary):

```bash
chmod +x main.sh
chmod -R +x lib/
```

2. Run the main menu:

```bash
./main.sh
```

3. Use the menus to:

- Manage packages: install, remove, search, update, etc...
- Test networking: show configuration, test DNS, test access
- Perform maintenance: clean cache, remove orphan packages

4. Run a specific script directly (example):

```bash
./lib/packageManaging/install-package.sh <package-name>
```

Security notes:

- Scripts that change the system will call `sudo` internally; review them before running on production systems.

## Quick examples

- Update package lists:

```bash
./lib/packageManaging/update-packages-list.sh
```

- Install a package (example `htop`):

```bash
./lib/packageManaging/install-package.sh htop
```

## Contribution

Pull requests are welcome. To contribute:

1. Fork this repository
2. Create a branch for your feature: `git checkout -b feat-my-feature`
3. Open a pull request describing the change

Use ShellCheck to catch common shell-script bugs and security issues before committing.

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
