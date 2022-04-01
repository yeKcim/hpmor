#/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."
latexpand hpmor.tex -o hpmor_flatten.tex									# flatten tex
sed -i '1i\\\input{hp-header}\n' hpmor_flatten.tex							# + header pour les def \newcommand
sed -i '/\\begin{headlines}/d ; /\\end{headlines}/d' hpmor_flatten.tex		# - \headlines (can't generate epub)
pdftoppm -png -singlefile hpmor.pdf cover									# create cover from pdf
pandoc -s hpmor_flatten.tex -o hpmor.epub \									# tex to epub
   -f latex+latex_macros \														# convert \newcommand
   --metadata title="Harry Potter et les méthodes de la Rationalité" \			# title
   --epub-cover-image="cover.png" \												# cover png
   --epub-chapter-level=2														# new chapter each h2
rm cover.png																# remove tmp files


