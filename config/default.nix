{ pkgs, ... }:
{
  imports = [
    ./plugins/ui/default.nix
    ./plugins/cmp/default.nix
    ./plugins/lsp/lsp.nix
    ./keybinds.nix
    ./plugins/utils/utils.nix
    ./opts.nix
    ./auto_cmds.nix

  ];
}
