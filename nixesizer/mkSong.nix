{
  tracks,
  duration,
  rate,
  depth,
}: name:
let
  inherit (builtins) foldl' genList length;
  mkWav = import ./mkWav.nix;

  loudData = genList (
    x: let
      time = (x + 0.0) / rate;
    in
      foldl' (
        acc: track:
          acc + (track.inst (track.ptrn time) time)
      ) 0 tracks
  ) (duration * rate);
  data = map (x: x / (length tracks + 0.0)) loudData;
in
  mkWav {
    inherit data rate depth;
  } name
