{
  mkSong = import ./mkSong.nix;
  utils = import ./utils.nix;
  insts = import ./insts.nix;
  ptrns = import ./ptrns.nix;
  scales = import ./scales.nix;

  # DEGREE: a value for a note in a scale as an int
  # FREQUENCY: a value in Hz as a float
  # TIME: a value from the start in seconds as a float
  # LENGTH: a relative value in seconds as a float
  # SAMPLE: a value for a sample in [0.0, 1.0] as a float
  # INSTRUMENT: a function that takes in a FREQUENCY `f`
  #             and a TIME `t` and returns a `SAMPLE`
  # PATTERN: a function that takes in a TIME `t` and
  #          returns a FREQUENCY
  # SCALE: a function that takes in a DEGREE `n` and
  #        returns the FREQUENCY of that note
}
