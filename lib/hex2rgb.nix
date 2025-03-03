hex:
let
  r = toString (fromTOML "x = 0x${__substring 1 2 hex}").x;
  g = toString (fromTOML "x = 0x${__substring 3 2 hex}").x;
  b = toString (fromTOML "x = 0x${__substring 5 2 hex}").x;
in
"${r}, ${g}, ${b}"
