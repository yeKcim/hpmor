#/bin/bash
latexpand hpmor.tex -o hpmor_flatten.tex																							# flatten tex
sed -i '1i\\\input{hp-header}\n' hpmor_flatten.tex																					# + header pour les def \newcommand
sed -i '/\\begin{headlines}/d ; /\\end{headlines}/d' hpmor_flatten.tex																# - \headlines (can't generate epub)
pandoc -s hpmor_flatten.tex -o hpmor.epub -f latex+latex_macros --metadata title="Harry Potter et les méthodes de la Rationalité"	# tex to epub
