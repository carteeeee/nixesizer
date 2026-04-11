{
  tracks,
  duration,
  rate,
}:
let
  inherit (builtins) floor foldl' genList;
  inherit (import ./utils.nix) clip ifNull;
in
  map clip (genList (
    x: let
      time = (x + 0.0) / rate;
    in
      foldl' (
        acc: track:
          acc + (ifNull (ifNull (track.ptrn time) null track.scale) (x: 0) track.inst time) * track.vol
      ) 0 tracks
  ) (floor (duration * rate)))
