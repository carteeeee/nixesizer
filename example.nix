let
  bassWavetable = map (x: x / 256.0) [44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 211 210 209 209 207 206 205 204 203 202 201 200 198 197 197 196 194 194 193 191 190 189 188 187 186 185 184 182 182 181 180 178 178 176 175 174 173 172 171 170 169 168 166 166 165 164 162 162 161 159 158 157 157 155 154 153 153 151 150 149 148 147 145 145 143 142 141 141 139 138 137 136 135 134 133 132 131 129 129];

  inherit (builtins) elemAt genList length;
  inherit (import ./nixesizer) mkWav mkSong insts ptrns scales utils;
  rate = 48000;
  depth = 4;
  tempo = 110;
  row = tempo * 8; # tempo for the actual rows
  duration = (60.0 / tempo * 8.0); # 64 rows
  
  base = 36299.0 / (utils.pow 2 7);

  mainScale = scales.western base;
  downScale = scales.western (base / 2);
  upScale = scales.western (base * 2);

  bass      = {vol = (1.0 / 8.0); inst = insts.wavetable bassWavetable; scale = scales.western (base / 8);};
  harmony   = {vol = (1.0 / 32.0); inst = insts.sqr; scale = downScale;};
  eek       = {vol = (1.0 / 16.0); inst = insts.saw; scale = upScale;};
  lead      = {vol = (1.0 / 8.0); inst = insts.tri; scale = mainScale;};
  lead2     = {vol = (1.0 / 8.0); inst = insts.tri; scale = upScale;};
  leadEcho  = lead // {vol = (1.0 / 32.0);};
  leadEcho2 = lead2 // {vol = (1.0 / 32.0);};

  n = null;

  echo = d: p: ptrns.concat [(ptrns.empty row d) p];

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
    0  0  0  0  n  n  n  n  n  n  n  n  n  n  n  n
  ] row;

  mainLeadEcho = echo 8 mainLead;

  bridgeLead = ptrns.seq [
    5  9  12 9  12 17 12 17 21 17 21 24 21 24 29 33
    8  12 15 12 15 20 15 20 24 20 24 27 24 27 32 36
    9  14 17 14 17 21 17 21 26 21 26 29 26 29 33 38
    11 14 19 14 19 23 19 23 26 23 26 31 26 31 35 38
  ] row;

  bridgeLeadEcho = echo 6 bridgeLead;

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
      (lead // {ptrn = ptrns.concat [
        (ptrns.empty row 60)
        (ptrns.hold 7 row 4)
      ];})
      (eek // {ptrn = ptrns.concat [
        (ptrns.empty row 56)
        (ptrns.hold 12 row 4)
      ];})
    ];
    inherit duration rate;
  };

  part1 = mkSong {
    tracks = [
      (bass // {ptrn = mainBass;})
      (harmony // {ptrn = mainHarmony1;})
      (harmony // {ptrn = mainHarmony2;})
      (lead // {ptrn = mainLead;})
      (leadEcho // {ptrn = mainLeadEcho;})
      (eek // {ptrn = ptrns.concat [
        (ptrns.empty row (64 * 2 + 56))
        (ptrns.hold 12 row 4)
      ];})
    ];
    duration = duration * 3;
    inherit rate;
  };

  partial2 = mkSong {
    tracks = [
      (lead2 // {ptrn = mainLead;})
      (leadEcho2 // {ptrn = mainLeadEcho;})
    ];
    duration = duration * 3;
    inherit rate;
  };

  # probably not best practice but it's faster
  part2 = map (x: (elemAt part1 x) + (elemAt partial2 x)) (genList (x: x) (length part1));

  bridge = mkSong {
    tracks = [
      (bass // {ptrn = ptrns.concat [
        (ptrns.hold 5 row 16)
        (ptrns.hold 8 row 16)
        (ptrns.hold 11 row 16)
        (ptrns.hold 7 row 4)
      ];})
      (harmony // {vol = (1.0 / 64.0); ptrn = ptrns.concat [
        (ptrns.hold 9 row 16)
        (ptrns.hold 12 row 16)
        (ptrns.hold 14 row 16)
        (ptrns.hold 17 row 2)
      ];})
      (harmony // {vol = (1.0 / 64.0); ptrn = ptrns.concat [
        (ptrns.hold 12 row 16)
        (ptrns.hold 15 row 16)
        (ptrns.hold 17 row 16)
        (ptrns.hold 19 row 2)
      ];})
      (lead // {ptrn = bridgeLead;})
      (leadEcho // {vol = (1.0 / 64.0); ptrn = bridgeLeadEcho;})
    ];
    inherit duration rate;
  };
in
  mkWav {
    data = [intro part1 part2 bridge];
    inherit rate depth;
  } "nixesizer-example"
