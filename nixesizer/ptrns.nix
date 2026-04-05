let
  inherit (builtins) elemAt floor foldl' length;
  inherit (import ./utils.nix) ifNull mod;
in rec {
  # takes a function `p` and a LENGTH `l` and
  # creates a PATTERN from it
  complete = p: l: {
    __functor = (self: t: if t < self.l then (self.p) t else null);
    inherit p l;
  };

  ## modifiers ##
  # apply a SCALE `s` to the outputs of a PATTERN `p`
  scale = p: s: complete (t: ifNull (p t) null s) p.l;
  # plays the PATTERNs `p1` and `p2` in sequence
  concat2 = p1: p2: complete
    (t: if t < p1.l then p1.p t else p2.p (t - p1.l))
    (p1.l + p2.l);
  # plays the PATTERN[] `p` in sequence
  concat = p: foldl' (acc: ptrn: if acc == null then ptrn else concat2 acc ptrn) null p;

  ## base patterns ##
  # plays a single note at FREQUENCY `f` for LENGTH `l`
  solid = f: complete (t: f);
  # plays an arp at the FREQUENCY[] `f` at `b` bpm for INT `l` times
  arp = f: b: l: complete
    (t: elemAt f (floor (mod (t * b / 60.0) (length f))))
    (60.0 / b * (length f) * l);
  # plays the sequence of FREQUENCY[] `f` at `b` bpm once
  seq = f: b: arp f b 1;
}
