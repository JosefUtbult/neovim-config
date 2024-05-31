## Setup

Install dependencies

- Rigrep for grep finding in telescope
- Unzip for Mason to install LSPs
- GCC for LSP
- cpplint and cppcheck for clangd
- NPM For a bunch of LSPs
- Venv for Jedi LSP
- Markdown for Markdown preview
- Codespell for spelling code using Null-ls
- FZY for fuzzy finding

```bas
sudo apt install -y git ripgrep unzip gcc npm python3-venv cppcheck cpplint markdown codespell fzy
```

Install the unstable version of NeoVim

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
```

```bash
sudo apt-get update
sudo apt-get install -y neovim
```

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

Now, add an alias in your `.zshrc` config at the bottom

```bash
# Alias Vim to NeoVim
alias vim=nvim
alias vi=nvim
alias v=nvim
```
