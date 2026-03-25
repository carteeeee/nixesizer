{
  tracks,
  duration,
  rate,
  depth,
}: name:
let
  inherit (builtins) foldl' genList;
  inherit (import ./utils.nix) clip;
  mkWav = import ./mkWav.nix;

  loudData = genList (
    x: let
      time = (x + 0.0) / rate;
    in
      foldl' (
        acc: track:
          acc + (track.inst (track.ptrn time) time) * track.vol
      ) 0 tracks
  ) (duration * rate);
  data = map clip loudData;
in
  mkWav {
    inherit data rate depth;
  } name
