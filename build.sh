#!/bin/bash

mkdir -p $HOME/.local/share/nvim/vscode-cpptools
cd $HOME/.local/share/nvim/vscode-cpptools

wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.20.5/cpptools-linux.vsix

unzip cpptools-linux.vsix
chmod +x $HOME/.local/share/nvim/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7
