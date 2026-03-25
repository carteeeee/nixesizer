let
  inherit (import ./utils.nix) mod;
  inherit (builtins) elemAt floor length;
in {
  ## modifiers ##
  # takes in a length `l` and a pattern `p` and outputs a
  # pattern that plays `p` for `l` seconds then outpus 0
  timed = l: p: t: if t <= l then p t else 0;
  # takes in two patterns `p1` and `p2` and two lengths
  # `l1` and `l2` and outputs a pattern that plays `p1`
  # for `l1` seconds, then `p2` for `l2` seconds
  concat = p1: p2: l1: l2: t:
    if t <= l1 then p1 t else
    if t <= (l1 + l2) then p2 (t - l1) else 0;

  ## patterns ##
  # plays a single note at frequency `f`
  solid = f: t: f;
  # plays an arp at the frequencies `f` at `b` bpm
  arp = f: b: t: elemAt f (floor (mod (t * b / 60.0) (length f)));
}
