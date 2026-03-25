{ data, rate, depth }: name:
let
  inherit (import ./utils.nix) hex8 hex16 hex32 mod;
  inherit (builtins) floor length;
  pkgs = import <nixpkgs> {};

  dataBytes = toString (map (if depth == 1 then
    x: hex8 (floor (x * 255))
  else if depth == 2 then
    x: hex16 (mod (floor (x * 65535) + 32768) 65536) # sign
  else if depth == 4 then
    x: hex32 (mod (floor (x * 4294967295) + 2147483648) 4294967296) # sign
  else throw "depth must be 1, 2, or 4 !") data);

  header = "52494646" + hex32 (length data * depth + 36) + # "RIFF" [len-8B]
           "57415645" + "666D7420" + hex32 16 + # "WAVE" "fmt " [16B header len]
           hex16 1 + hex16 1 + # format 1 (PCM), 1 channel
           hex32 rate + hex32 (rate * depth) + # sample rate, bytes per second
           hex16 depth + hex16 (depth * 8) + # bytes per block, bits per sample
	   "64617461" + hex32 (length data * depth); # data [len]
  bytes = header + dataBytes;
in
  pkgs.writers.makeBinWriter {
    compileScript = "${pkgs.xxd}/bin/xxd -r -p $contentPath $out";
    strip = false;
  } name bytes
