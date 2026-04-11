let
  inherit (import ../nixesizer) mkWav mkSong insts ptrns;
  rate = 48000;
  depth = 4;
  tempo = 120;

  n = null;
  k = 50.0;
  s = 150.0;
  h = 400.0;
in
  mkWav {
    data = mkSong {
      tracks = [
        {vol = 1.0; inst = insts.noise;
        ptrn = ptrns.arp [k k n n h n n n s s s s h n n n
                          k k n n h n h n s s s s h n n n] (tempo * 8) 2;}
      ];
      duration = 4;
      inherit rate;
    };
    inherit rate depth;
  } "nixesizer-noise-example"
