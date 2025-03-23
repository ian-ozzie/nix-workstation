{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default

    ../shared/programs/nvf
    ../workstation
  ];

  ozzie.workstation.nvf.enable = true;
}
