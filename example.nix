let
  inherit (import ./nixesizer) mkSong insts ptrns scales;
in
  mkSong {
    tracks = [
      {vol = 0.7; inst = insts.tri;
      ptrn = ptrns.scale (
        ptrns.seq [
          12 14 15 17
          14 14 10 12
          12 12 12 12
        ] 380
      ) (scales.western 220);}
      {vol = 0.1; inst = insts.sqr;
      ptrn = ptrns.scale (
        ptrns.seq [
           8  8  8  8
          10 10 10 12
          12 12 12 12
        ] 380
      ) (scales.western 110);}
      {vol = 0.1; inst = insts.sqr;
      ptrn = ptrns.scale (
        ptrns.seq [
          12 12 12 12
          14 14 14 15
          15 15 15 15
        ] 380
      ) (scales.western 110);}
      {vol = 0.1; inst = insts.sqr;
      ptrn = ptrns.scale (
        ptrns.seq [
          15 15 15 15
          17 17 17 19
          19 19 19 19
        ] 380
      ) (scales.western 110);}
    ];
    duration = 8;
    rate = 48000;
    depth = 4;
  } "examplesong"
