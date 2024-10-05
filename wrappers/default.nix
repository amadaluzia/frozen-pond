{
  inputs,
  pkgs,
}:
pkgs.lib.concatMapAttrs (n: v: {"${n}-wrapped" = v;})
(inputs.wm.lib {
  inherit pkgs;
  specialArgs = {inherit inputs;};
  modules = map (n: ./${n}) (builtins.attrNames (pkgs.lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.)));
})
.config
.build
.packages
