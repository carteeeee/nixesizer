let
  mkSong = import ./mkSong.nix;
  insts = import ./insts.nix;
  ptrns = import ./ptrns.nix;
in
  mkSong {
    tracks = [
      {inst = insts.sqr;
        ptrn = ptrns.solid 110 3;}
      {inst = insts.tri;
        ptrn = ptrns.solid 220 2;}
      {inst = insts.saw;
        ptrn = ptrns.solid 330 1;}
    ];
    duration = 3;
    rate = 48000;
    depth = 1;
  } "test"
