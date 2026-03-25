let
  inherit (builtins) genList length;
  inherit (import ./utils.nix) index tpix pow;
in rec {
  # NOTE: functions such as `edo` or `inverse` still need
  #       the base frequency `b` input from `octave`!

  # creates a SCALE that repeats at the octave (doubling of frequency)
  # using the table `t` in range of [1.0, 2.0) and a base frequency `b`
  octave = t: b: n: index t n * (pow 2 (n / (length t))) * b;
  # create a SCALE with `d` equal divisions of the octave
  edo = d: octave (genList (x: pow (tpix d) x) d);
  # create a SCALE where each note is a multiple of the inverse of
  # `d` (useful for JI)
  inverse = d: octave (genList (x: x / d) d);

  # shortcut for standard western 12 notes per octave
  western = edo 12;
}
