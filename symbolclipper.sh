#!/bin/bash
declare -A symbol

# logic
symbol[exist]="Ǝ"
symbol[forall]="∀"
symbol[congruent]="≡"
symbol[nodiv]="∤"
symbol[and]="∧"
symbol[compose]="○"
symbol[iff]="↔"
symbol[qed]="∎"
symbol[approach]="⇒"

# set theory
symbol[null]="∅"
symbol[sss]="⊂"
symbol[ss]="⊆"
symbol[in]="∈"
symbol[intersect]="∩"
symbol[union]="∪"
symbol[real]="ℝ"
symbol[natural]="ℕ"
# misc
symbol[plusminus]="±"
symbol[inf]="∞"
symbol[nabla]="∇"
symbol[int]="∫"
symbol[about]="≈"
symbol[dot]="·"
symbol[sqrt]="√"
symbol[lte]="≤"
symbol[gte]="≥"

# greek alphabet
symbol[alpha]="α"
symbol[beta]="β"
symbol[triangle]="∆"
symbol[delta]="δ"
symbol[epsilon]="ε"
symbol[theta]="θ"
symbol[mu]="μ"
symbol[lambda]="λ"
symbol[pi]="π"
symbol[omega]="Ω"
symbol[sigma]="σ"
symbol[phi]="φ"
symbol[sum]="Σ"

# copy to clipboard, -n flag removes all newlines
# echo -n ${symbol[$1]} | xclip -selection clipboard

# same thing but with xclip
if [ -z ${symbol[$1]} ]; then
	echo "symbol not found!"
else
	echo -n ${symbol[$1]} | xclip -selection clipboard
	echo "copied ${symbol[$1]}"
fi

