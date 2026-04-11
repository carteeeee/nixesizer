let
  inherit (import ./nixesizer) mkWav mkSong insts ptrns scales utils;
  rate = 48000;
  depth = 4;
  tempo = 110;
  row = tempo * 8; # tempo for the actual rows
  length = (60.0 / tempo * 8.0); # 64 rows
  
  base = 36299 / (utils.pow 2 7);

  bass     = {vol = (1.0 / 16.0); inst = insts.sqr; scale = scales.western (base / 8);};
  harmony  = {vol = (1.0 / 16.0); inst = insts.sqr; scale = scales.western (base / 2);};
  eek      = {vol = (1.0 / 16.0); inst = insts.saw; scale = scales.western (base * 4);};
  lead     = {vol = (1.0 / 8.0); inst = insts.tri; scale = scales.western base;};
  leadEcho = lead // {vol = (1.0 / 32.0);};

  initialBass = [12 12 12 12 n n n n 7 7 n n n n 7 n];
  mainBass = ptrns.concat [
    (ptrns.arp initialBass row 3)
    (ptrns.seq [12 12 12 12 n n n n 11 11 11 11 n n n n] row)

    (ptrns.arp [9 9 9 9 n n n n 4 4 n n n n 4 n] row 2)
    (ptrns.seq [14 14 14 14 n n n n 9 9 n n n n 9 n
                7 7 7 7 n n n n 6 6 6 6 n n n n] row)

    (ptrns.arp [5 5 5 5 n n n n 0 0 n n n n 0 n] row 2)
    (ptrns.seq [8 8 8 8 n n n n 3 3 n n n n 3 n
                0 0 0 0] row)
  ];
  mainHarmony1 = ptrns.concat [
    (ptrns.arp [12 n n n] row 16)

    (ptrns.arp [9 n n n] row 8)
    (ptrns.arp [14 n n n] row 4)
    (ptrns.arp [7 n n n] row 4)

    (ptrns.arp [9 n n n] row 8)
    (ptrns.arp [15 n n n] row 4)
    (ptrns.hold 16 row 4)
  ];

  mainHarmony2 = ptrns.concat [
    (ptrns.seq [15 n n n] row)
    (ptrns.arp [16 n n n] row 7)
    (ptrns.seq [15 n n n] row)
    (ptrns.arp [16 n n n] row 7)

    (ptrns.arp [13 n n n] row 8)
    (ptrns.arp [17 n n n] row 4)
    (ptrns.arp [11 n n n] row 4)

    (ptrns.arp [12 n n n] row 8)
    (ptrns.arp [20 n n n] row 4)
    (ptrns.hold 19 row 4)
  ];

  mainLead = ptrns.seq [
    10 11 12 12 19 n  n  n  22 n  n  n  24 n  n  n
    19 n  18 n  17 17 17 17 n  n  n  n  12 12 15 n
    16 16 16 16 17 n  n  n  19 19 19 19 22 n  n  n
    16 16 16 16 n  n  n  n  n  n  n  n  n  n  n  n

    13 14 16 16 19 n  n  n  21 n  n  n  19 n  n  n
    25 n  21 n  19 19 19 19 n  n  n  n  19 19 18 n
    17 17 17 17 12 n  n  n  14 14 14 14 12 n  n  n
    11 11 11 11 n  n  n  n  n  n  n  n  n  n  n  n

    7  8  9  9  21 n  n  n  24 n  n  n  26 n  n  n
    21 n  20 n  19 19 19 19 n  n  n  n  17 17 19 n
    19 20 20 20 17 n  n  n  7  8  8  8  5  n  n  n
    12 12 12 12 n  n  n  n  n  n  n  n  n  n  n  n
  ] row;

  n = null;

  intro = mkSong {
    tracks = [
      (bass // {ptrn = ptrns.concat [
        (ptrns.arp initialBass row 3)
        (ptrns.hold 0 row 4)
      ];})
      (harmony // {ptrn = ptrns.concat [
        (ptrns.arp [12 n n n] row 12)
        (ptrns.hold 16 row 4)
      ];})
      (harmony // {ptrn = ptrns.concat [
        (ptrns.seq [15 n n n] row)
        (ptrns.arp [16 n n n] row 7)
        (ptrns.seq [15 n n n] row)
        (ptrns.arp [16 n n n] row 3)
        (ptrns.hold 19 row 4)
      ];})
      (eek // {ptrn = ptrns.concat [
        (ptrns.empty row 56)
        (ptrns.hold 0 row 4)
      ];})
    ];
    duration = length;
    inherit rate;
  };

  part1 = mkSong {
    tracks = [
      (bass // {ptrn = mainBass;})
      (harmony // {ptrn = mainHarmony1;})
      (harmony // {ptrn = mainHarmony2;})
      (lead // {ptrn = mainLead;})
      (leadEcho // {ptrn = ptrns.concat [(ptrns.empty row 8) mainLead];})
      (eek // {ptrn = ptrns.concat [
        (ptrns.empty row (64 * 2 + 56))
        (ptrns.hold 0 row 4)
      ];})
    ];
    duration = length * 3;
    inherit rate;
  };
in
  mkWav {
    data = [intro part1];
    inherit rate depth;
  } "nixesizer-example"
