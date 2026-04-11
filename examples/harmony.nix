let
  inherit (import ../nixesizer) mkWav mkSong insts ptrns scales;
  rate = 48000;
  depth = 4;
  tempo = 380;

  scale = scales.western 110;
  scale2 = scales.western 220;
  lead = {vol = 0.7; inst = insts.tri; scale = scale2;};
  harmony = {vol = 0.1; inst = insts.sqr; scale = scale;};
in
  mkWav {
    data = mkSong {
      tracks = [
        (lead // {ptrn = ptrns.seq [
            12 14 15 17
            14 14 10 12
            12 12 12 12
          ] tempo;})
        (harmony // {ptrn = ptrns.seq [
             8  8  8  8
            10 10 10 12
            12 12 12 12
          ] tempo;})
        (harmony // {ptrn = ptrns.seq [
            12 12 12 12
            14 14 14 15
            15 15 15 15
          ] tempo;})
        (harmony // {ptrn = ptrns.seq [
            15 15 15 15
            17 17 17 19
            19 19 19 19
          ] tempo;})
      ];
      duration = 8;
      inherit rate;
    };
    inherit rate depth;
  } "nixesizer-harmony-example"
