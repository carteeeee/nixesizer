{ data, rate, depth }: name:
let
  inherit (import ./utils.nix) hex8 hex16 hex32;
  pkgs = import <nixpkgs> {};

  dataBytes = toString (map (if depth == 1 then
    x: hex8 (builtins.floor (x * 255))
  else if depth == 2 then
    x: hex16 (builtins.floor (x * 65535))
  else if depth == 4 then
    x: hex32 (builtins.floor (x * 4294967295))
  else throw "depth must be 1, 2, or 4 !") data);

  header = "52494646" + hex32 (builtins.length data * depth + 36) + # "RIFF" [len-8B]
           "57415645" + "666D7420" + hex32 16 + # "WAVE" "fmt " [16B header len]
           hex16 1 + hex16 1 + # format 1 (PCM), 1 channel
           hex32 rate + hex32 (rate * depth) + # sample rate, bytes per second
           hex16 depth + hex16 (depth * 8) + # bytes per block, bits per sample
	   "64617461" + hex32 (builtins.length data * depth); # data [len]
  bytes = header + dataBytes;
in
  pkgs.writers.makeBinWriter {
    compileScript = "${pkgs.xxd}/bin/xxd -r -p $contentPath $out";
    strip = false;
  } name bytes
