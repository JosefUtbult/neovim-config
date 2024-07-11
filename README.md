## Setup

## Install dependencies

- Rigrep for grep finding in telescope
- Unzip for Mason to install LSPs
- GCC for LSP
- cpplint and cppcheck for clangd
- NPM For a bunch of LSPs
- Venv for Jedi LSP
- Markdown for Markdown preview
- Codespell for spelling code using Null-ls
- FZY for fuzzy finding
- Fd-find for finding executables for the DAP
```bas
sudo apt install -y git ripgrep unzip gcc npm python3-venv cppcheck cpplint markdown codespell fzy fd-find
```

You will also need to install some python plugins
```bash
pip install --break-system-packages notebook nbclassic jupyter-console jupyterthemes
```
## Reinstall Firefox (Ubuntu only)

From [this guide](https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04)

If you are on Ubuntu, you may need to uninstall the Snap version of Firefox and install the DEB version, as this is required for Selenium to work, which is needed by Jupynium.

Uninstall Firefox snap
```bash
sudo snap remove firefox
```

Create an APT keyring (if one doesn’t already exist):
```bash
sudo install -d -m 0755 /etc/apt/keyrings
```

Import the Mozilla APT repo signing key
```bash
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
```

Add the Mozilla signing key to your sources.list
```bash
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
```

Set the Firefox package priority to ensure Mozilla’s DEB version is always default. If you don’t do this the Ubuntu transition package could/will replace it, reinstalling the Firefox snap
```bash
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
```

Finally, you can use APT to install the Firefox DEB in Ubuntu
```bash
sudo apt update && sudo apt install firefox
```

## Install NeoVim

Install the unstable version of NeoVim
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
```

```bash
sudo apt-get update
sudo apt-get install -y neovim
```

## Setup config repo

Add the repository to your config folder
```bash
git clone git@github.com:JosefUtbult/neovim-config.git ~/.config/nvim
```

Now, install the vscode-cpptools plugin to `~/local/share/nvim/vscode-cpptools`
```bash
unzip ~/.config/nvim/misc/cpptools-linux.vsix -d ~/.local/share/nvim/vscode-cpptools
```

And make sure that `extension/debugAdapters/bin/OpenDebugAD7` is executable
```bash
chmod +x ~/.local/share/nvim/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7
```

## Setup ZSH

Now, add an alias in your `.zshrc` config at the bottom
```bash
# Alias Vim to NeoVim
alias vim=nvim
alias vi=nvim
alias v=nvim
```
