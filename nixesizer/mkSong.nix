{
  tracks,
  duration,
  rate,
  depth,
}: name:
let
  inherit (builtins) foldl' genList;
  inherit (import ./utils.nix) clip ifNull;
  mkWav = import ./mkWav.nix;

  loudData = genList (
    x: let
      time = (x + 0.0) / rate;
    in
      foldl' (
        acc: track:
          acc + (ifNull (track.ptrn time) (x: 0) track.inst time) * track.vol
      ) 0 tracks
  ) (duration * rate);
  data = map clip loudData;
in
  mkWav {
    inherit data rate depth;
  } name
