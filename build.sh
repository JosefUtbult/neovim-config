#!/bin/bash

# Create a folder to store the vscode debug adapter in $HOME/.local/share/nvim
mkdir -p $HOME/.local/share/nvim/vscode-cpptools
pushd $HOME/.local/share/nvim/vscode-cpptools

# Pull the plugin from VSCode
wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.20.5/cpptools-linux.vsix

# Extract the plugin
unzip cpptools-linux.vsix

pushd $HOME/.local/share/nvim/vscode-cpptools/extension/debugAdapters/bin

# Make the debug application executable
chmod +x OpenDebugAD7

# Copy a config for nvim-dap to find it
cp cppdbg.ad7Engine.json nvim-dap.ad7Engine.json
popd

# Delete the plugin
rm cpptools-linux.vsix

popd
