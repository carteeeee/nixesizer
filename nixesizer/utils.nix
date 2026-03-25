let
  inherit (builtins) floor concatMap elemAt;
in rec {
  clip = x: if x < 0.0 then 0 else if x > 1.0 then 1 else x;
  abs = x: if x < 0.0 then -x else x;
  mod = a: b: a - floor (a / b) * b;

  hexDigits = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f"];
  hex = concatMap (x: map (y: x + y) hexDigits) hexDigits;
  hex8 = x: elemAt hex x;
  hex16 = x: hex8 (mod x 256) + hex8 (floor x / 256);
  hex32 = x: hex16 (mod x 65536) + hex16 (floor x / 65536);
}
