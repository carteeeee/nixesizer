let
  inherit (import ./utils.nix) abs mod;
  inherit (builtins) elemAt floor length;
in rec {
  wavetable = table: f: t:
    elemAt table (floor (mod (t * f) (length table)));
  saw = f: t: mod (f * -t) 1.0;
  sqr = f: t: if saw f t < 0.5 then 0.0 else 1.0;
  tri = f: t: abs (saw f t - 0.5) * 2.0;
}
