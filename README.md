## Setup

Install dependencies

- Rigrep for grep finding in telescope
- Unzip for Mason to install LSPs
- GCC for LSP
- NPM For a bunch of LSPs
- Venv for Jedi LSP


```bash
sudo apt install -y ripgrep unzip gcc npm python3-venv
```

Install the unstable version of NeoVim

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim
```

Add the repository to your config folder

```bash
git clone git@github.com:JosefUtbult/neovim-config.git ~/.config/nvim
```
