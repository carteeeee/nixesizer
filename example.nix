let
  inherit (import ./nixesizer) mkSong insts ptrns;
in
  mkSong {
    tracks = [
      {vol = 0.3; inst = insts.saw;
        ptrn = ptrns.concat
          (ptrns.arp [110 220 330 440] 240)
          (ptrns.arp [82.5 165 247.5 330] 240)
          4 4;}
      {vol = 0.7; inst = insts.tri;
        ptrn = ptrns.concat
          (ptrns.arp [330 110 440 220] 360)
          (ptrns.arp [247.5 82.5 330 165] 360)
          4 4;}
    ];
    duration = 8;
    rate = 48000;
    depth = 1;
  } "examplesong"
