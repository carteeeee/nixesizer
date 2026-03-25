let
  inherit (import ./nixesizer) mkSong insts ptrns scales;
in
  mkSong {
    tracks = [
      {vol = 1.0; inst = insts.sqr;
        ptrn = ptrns.scale (ptrns.concat
          (ptrns.arp [0 3 7 10] 240.0)
          (ptrns.arp [2 5 9 12] 240.0)
          4.0 4.0) (scales.western 220.0);}
    ];
    duration = 8;
    rate = 48000;
    depth = 4;
  } "examplesong"
