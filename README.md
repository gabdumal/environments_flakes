# Gabdumal's development environments

This repository contains my development environments for NixOS.

## Setup

You need to enable experimental features in your Nix configuration.

Follow the same procedure as described in the [README.md](https://github.com/gabdumal/nixos/blob/main/README.md#setup) file.

## Installing

Clone this repository as the `environments` directory in your dotfiles repository.

```bash
cd ~/dotfiles
git clone https://github.com/gabdumal/environments_flakes.git environments
```

Now, enter the `environments` directory:

```bash
cd ~/dotfiles/environments
```

For each, you need to construct the `flake.lock` file.
You can do that by running the following command:

```bash
./update.sh
```

## Running

After having created the `flake.lock` file, you have two options to execute the environment.

### `nix develop`

This is the most traditional way to run a development environment.
You have to `cd` into the environment directory and run the following command:

```bash
nix develop
```

The problem with this approach is that the used shell is always `bash`.
If you want to use another shell, you can use the following command:

```bash
nix develop --impure --command zsh
```

You can also specify a flake where the environment is defined:

```bash
nix develop <flake_path>
```

For example, to enter the `pnpm` environment, you can use the following command.

```bash
nix develop ~/dotfiles/environments/pnpm
```

Or, you can use the following helper command instead for the pre-defined environments.\
`<environment>` is the name of one of the following: [c_cpp, java, latex, nix, pnpm, prisma, python, rust, typst].

```bash
develop <environment>
```

### Direnv

You can also use [`nix-direnv`](https://github.com/nix-community/nix-direnv).

This will automatically load the environment when you `cd` into the directory.
Also, it uses the same shell that you are using in your terminal.

If you use the configuration from the [`pure`](https://github.com/gabdumal/nixos/blob/main/common/flake.nix) flake in the Gabdumal's NixOS repository, the `nix-direnv` will be already installed via `home-manager`.

For the first time you enable the environment, you have to `cd` into its folder, and run the following command:

```bash
direnv allow
```

#### Configuring projects

If you want to use `nix-direnv` in a project, can create a `.envrc` file in the root of the project with the following content:

```bash
use flake ./path/to/environment
```

If you have followed the suggestions in the [README.md](https://github.com/gabdumal/nixos/blob/main/README.md#installing) file, you can use the following content, replacing `[environment]` with the correct values:

```bash
use flake ~/dotfiles/environments/[environment]
```

Then, enable the environment by running, the following command in the root of the project:

```bash
direnv allow
```
