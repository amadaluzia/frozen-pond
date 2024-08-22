{
  mkShell,
  nil,
  lua-language-server,
  vscode-langservers-extracted,
  nodePackages,
}:
mkShell {
  name = "lsp-land";
  packages = [
    nil
    lua-language-server
    vscode-langservers-extracted
    nodePackages.bash-language-server
  ];
}
