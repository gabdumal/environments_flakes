# Gabdumal's development environments

This repository contains my development environments for NixOS.

## Setup

You need to enable experimental features in your Nix configuration.

Follow the same procedure as described in the [README.md](https://github.com/gabdumal/flakes/blob/main/README.md#setup) file.

## Installing

The installation process is the same as described in the [README.md](https://github.com/gabdumal/flakes/blob/main/README.md#installing) file.

Now, enter the `environments` directory:

```bash
cd environments
```

Then, choose the environment you want to install, and enter its directory:

```bash
cd [environment]
```

For each, you need to construct the `flake.lock` file.
You can do that by running the following command:

```bash
sudo nix flake update
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

For example, to enter the `typescript` environment, you can use the following command.

```bash
nix develop ~/.dotfiles/[username]/environments/typescript
```

Or, you can use the following helper command instead for the pre-defined environments.\
`<environment>` is the name of one of the following: [latex, rust, typescript, typst].

```bash
develop <environment>
```

### Direnv

You can also use [`nix-direnv`](https://github.com/nix-community/nix-direnv).

This will automatically load the environment when you `cd` into the directory.
Also, it uses the same shell that you are using in your terminal.

If you use the configuration from the [`pure`](https://github.com/gabdumal/flakes/blob/main/pure/flake.nix) flake in the Gabdumal's NixOS repository, the `nix-direnv` will be already installed via `home-manager`.

For the first time you enable the environment, you have to `cd` into its folder, and run the following command:

```bash
direnv allow
```

#### Configuring projects

If you want to use `nix-direnv` in a project, can create a `.envrc` file in the root of the project with the following content:

```bash
use flake ./path/to/environment
```

If you have followed the suggestions in the [README.md](https://github.com/gabdumal/flakes/blob/main/README.md#installing) file, you can use the following content, replacing `[hostname]` and `[environment]` with the correct values:

```bash
use flake ~/.dotfiles/[hostname]/environments/[environment]
```

Then, enable the environment by running, the following command in the root of the project:

```bash
direnv allow
```
