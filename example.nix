let
  inherit (import ./nixesizer) mkSong insts ptrns scales;
  n = null;
  k = 50.0;
  s = 150.0;
  h = 400.0;
in
  mkSong {
    tracks = [
      {vol = 1.0; inst = insts.noise;
      ptrn = ptrns.arp [k k n n h n n n s s s s h n n n
                        k k n n h n h n s s s s h n n n] 960 2;}
    ];
    duration = 4;
    rate = 48000;
    depth = 4;
  } "examplesong"
