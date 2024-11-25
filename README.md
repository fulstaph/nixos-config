# Personal NixOS Config

## Description of Files and Directories

- **flake.nix**: The main entry point for the flake, defining inputs, outputs, and configurations for NixOS and Home Manager.
- **hosts/**: Directory containing host-specific configurations.
  - **homepc/**: Directory for the `homepc` host.
    - **configuration.nix**: NixOS configuration for the `homepc` host.
  - **thinkpad/**: Directory for the `thinkpad` host.
    - **configuration.nix**: NixOS configuration for the `thinkpad` host.
- **home.nix**: Home Manager configuration for the user.
- **modules/**: Directory containing modular configurations.
  - **docker.nix**: Configuration for enabling Docker.
  - **swap.nix**: Configuration for setting up swap space.
  - **users.nix**: Configuration for user accounts and their packages.
  - **services.nix**: Configuration for various services.
- **shells/**: Directory containing shell-specific configurations.
  - **config.nu**: Configuration file for Nushell.
  - **nu.nix**: Home Manager configuration for Nushell.
- **hardware-configuration.nix**: Hardware configuration file generated by the NixOS installer.
- **README.md**: Documentation for the repository.

## Getting Started

### Prerequisites

- NixOS installed on your system.
- Basic understanding of Nix and NixOS configuration.

### Setting Up

1. **Clone the Repository**

   ```sh
   git clone https://github.com/fulstaph/nixos-config.git
   cd nixos-config
   ```

2. **Run system rebuild and home-manager rebuild**

    ```sh
    sudo nixos-rebuild switch --flake .#{hostname}
    home-manager switch --flake .#fulstaph
    ```
