let
  inherit (builtins) elemAt floor foldl' genList length;
  inherit (import ./utils.nix) abs mod pow;
  noiseDepth = 25;
  noiseConstants = genList (x: pow 1.03 (x + 1)) noiseDepth;
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
  # INSTRUMENT that uses layered saw waves to
  # create kind of random noise
  noise = f: t: foldl' (acc: elem: acc + saw (f * elem) (t + 1000)) 0 noiseConstants / noiseDepth;
}
