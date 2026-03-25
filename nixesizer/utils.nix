let
  inherit (builtins) concatMap elemAt floor length;
in rec {
  # keeps `x` within [0.0, 1.0]
  clip = x: if x < 0.0 then 0 else if x > 1.0 then 1 else x;
  # absolute value of `x`
  abs = x: if x < 0.0 then -x else x;
  # c-like modulo function, keeps negatives
  mod = a: b: a - floor (a / b) * b;
  # index into a list `l` but loop
  index = l: i: elemAt l (mod i (length l));

  # natural log of 2
  ln2 = 0.69314718056; # thank you desmos
  # E to the Power of F (taylor series, only for Fractional part)
  epf = f: 1 + f * (1 + f / 2 * (1 + f / 3 * (1 + f / 4)));
  # Two to the Power of the Inverse of X
  tpix = x: epf (ln2 / x);
  # x^y for integers
  pow = x: y: if y <= 0 then 1 else x * (pow x (y - 1));

  # little-endian hex tools
  hexDigits = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f"];
  hex = concatMap (x: map (y: x + y) hexDigits) hexDigits;
  hex8 = x: elemAt hex x;
  hex16 = x: hex8 (mod x 256) + hex8 (floor x / 256);
  hex32 = x: hex16 (mod x 65536) + hex16 (floor x / 65536);
}
