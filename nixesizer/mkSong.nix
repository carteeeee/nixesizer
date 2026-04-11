{
  tracks,
  duration,
  rate,
}:
let
  inherit (builtins) foldl' genList;
  inherit (import ./utils.nix) clip ifNull;
in
  map clip (genList (
    x: let
      time = (x + 0.0) / rate;
    in
      foldl' (
        acc: track:
          acc + (ifNull (track.ptrn time) (x: 0) track.inst time) * track.vol
      ) 0 tracks
  ) (duration * rate))
