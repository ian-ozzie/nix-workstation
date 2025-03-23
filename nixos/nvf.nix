{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.nixosModules.default

    ../shared/programs/nvf
    ../workstation
  ];

  ozzie.workstation.nvf.enable = true;
}
