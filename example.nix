let
  inherit (import ./nixesizer) mkWav mkSong insts ptrns scales;
  rate = 48000;
  tempo = 110;
  row = tempo * 8; # tempo for the actual rows
  length = (60.0 / tempo * 8.0); # 64 rows
  
  bass = insts.sqr;
  harmony = insts.sqr;
  eek = insts.saw;

  base = 283.5859375;
  bassScale = scales.western (base / 8);
  harmonyScale = scales.western base;
  eekScale = scales.western (base * 4); # useless? maybe. silly? VERY

  n = null;

  intro = mkSong {
    tracks = [
      {vol = 0.1; inst = bass; scale = bassScale;
      ptrn = ptrns.concat [
        (ptrns.arp [12 12 12 12 n n n n 7 7 n n n n 7 n] row 3)
        (ptrns.seq [0 0 0 0] row)
      ];}
      {vol = 0.1; inst = harmony; scale = harmonyScale;
      ptrn = ptrns.concat [
        (ptrns.arp [0 n n n] row 12)
        (ptrns.seq [4 4 4 4] row)
      ];}
      {vol = 0.1; inst = harmony; scale = harmonyScale;
      ptrn = ptrns.concat [
        (ptrns.seq [3 n n n] row)
        (ptrns.arp [4 n n n] row 7)
        (ptrns.seq [3 n n n] row)
        (ptrns.arp [4 n n n] row 3)
        (ptrns.seq [7 7 7 7] row)
      ];}
      {vol = 0.1; inst = eek; scale = eekScale;
      ptrn = ptrns.concat [
        (ptrns.empty row 56)
        (ptrns.arp [0] row 4)
      ];}
    ];
    duration = length;
    inherit rate;
  };
in
  mkWav {
    data = intro;
    depth = 4;
    inherit rate;
  } "nixesizer-example"
