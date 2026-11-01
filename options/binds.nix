{ lib, ... }:
{
  options.ozzie.binds = lib.mkEnableOption "whether to default my binds" // {
    default = true;
  };
}
