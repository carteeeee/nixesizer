# nixesizer
nixesizer (portmanteau of nix and synthesizer) is a (VERY) work in progress synthesizer/sequencer written almost entirely in nix.

it now works! (kind of).
see `nixesizer/test.nix` for usage and you can also run `nix-build` on it to see an example of it working.

the system is based on tracks that have instruments which play patterns. in the future, there will be more pattern types available and also functions to operate on them (such as cutting, joining, &c).
