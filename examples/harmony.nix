let
  inherit (import ../nixesizer) mkWav mkSong insts ptrns scales;
  rate = 48000;
  tempo = 380;
in
  mkWav {
    data = mkSong {
      tracks = [
        {vol = 0.7; inst = insts.tri;
        ptrn = ptrns.scale (
          ptrns.seq [
            12 14 15 17
            14 14 10 12
            12 12 12 12
          ] tempo
        ) (scales.western 220);}
        {vol = 0.1; inst = insts.sqr;
        ptrn = ptrns.scale (
          ptrns.seq [
             8  8  8  8
            10 10 10 12
            12 12 12 12
          ] tempo
        ) (scales.western 110);}
        {vol = 0.1; inst = insts.sqr;
        ptrn = ptrns.scale (
          ptrns.seq [
            12 12 12 12
            14 14 14 15
            15 15 15 15
          ] tempo
        ) (scales.western 110);}
        {vol = 0.1; inst = insts.sqr;
        ptrn = ptrns.scale (
          ptrns.seq [
            15 15 15 15
            17 17 17 19
            19 19 19 19
          ] tempo
        ) (scales.western 110);}
      ];
      duration = 8;
      inherit rate;
    };
    depth = 4;
    inherit rate;
  } "nixesizer-harmony-example"
