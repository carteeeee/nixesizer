let
  inherit (import ./nixesizer) mkSong insts ptrns scales;
in
  mkSong {
    tracks = [
      {vol = 1.0; inst = insts.sqr;
      ptrn = ptrns.concat [
        (ptrns.scale (ptrns.arp [0 3 7 10] 240 2) (scales.western 220))
        (ptrns.scale (ptrns.arp [0 3 7 10] 240 2) (scales.western 330))
        (ptrns.scale (ptrns.arp [0 3 7 10] 240 2) (scales.western 440))
      ];}
    ];
    duration = 8;
    rate = 48000;
    depth = 4;
  } "examplesong"
