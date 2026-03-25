let
  inherit (builtins) elemAt floor length;
  inherit (import ./utils.nix) abs mod;
in rec {
  # creates an INSTRUMENT that uses a wavetable
  # algorithm with `table`
  wavetable = table: f: t:
    elemAt table (floor (mod (t * f) (length table)));
  # basic sawtooth INSTRUMENT
  saw = f: t: mod (f * -t) 1.0;
  # basic square INSTRUMENT
  sqr = f: t: if saw f t < 0.5 then 0.0 else 1.0;
  # basic triangle INSTRUMENT
  tri = f: t: abs (saw f t - 0.5) * 2.0;
}
