let
  inherit (builtins) elemAt floor length;
  inherit (import ./utils.nix) mod;
in {
  ## modifiers ##
  # apply a SCALE `s` to the outputs of a PATTERN `p`
  scale = p: s: t: s (p t);
  # plays PATTERN `p` for LENGTH `l` then returns 0
  timed = p: l: t: if t <= l then p t else 0;
  # loops a PATTERN `p` for LENGTH `l`
  loop = p: l: t: p (mod t l);
  # takes in two PATTERNs `p1` and `p2` and two LENGTHs
  # `l1` and `l2` and outputs a PATTERN that plays `p1`
  # for `l1` seconds, then `p2` for `l2` seconds
  concat = p1: p2: l1: l2: t:
    if t <= l1 then p1 t else
    if t <= (l1 + l2) then p2 (t - l1) else 0;

  ## base patterns ##
  # plays a single note at FREQUENCY `f`
  solid = f: t: f;
  # plays an arp at the FREQUENCIES `f` at `b` bpm
  arp = f: b: t: elemAt f (floor (mod (t * b / 60.0) (length f)));
}
