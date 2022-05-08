#/bin/bash

title=$(grep "pdftitle=" hp-header.tex | awk -F '[{}]' '{print $2}')
author=$(grep "pdfauthor=" hp-header.tex | awk -F '[{}]' '{print $2}')

script_dir=$(cd `dirname $0` && pwd)
cd $script_dir/..

# ╔═╗╦╔═╗╔╦╗╦ ╦╦═╗╔═╗╔═╗
# ╠═╝║║   ║ ║ ║╠╦╝║╣ ╚═╗
# ╩  ╩╚═╝ ╩ ╚═╝╩╚═╚═╝╚═╝
echo "1. pictures: pdf to optimized png"
cp {hpmor,cover}.pdf
for file in "cover" "bubble" "Deathly_Hallows_Sign"; do 	# convert pdf to png
  pdftoppm -png -singlefile $file.pdf $file
  optipng -o7 $file.png
done

# ╔╦╗╔═╗═╗ ╦  ╔╦╗╔═╗╔╦╗╦╔═╗
#  ║ ║╣ ╔╩╦╝  ║║║║ ║ ║║║╠╣ 
#  ╩ ╚═╝╩ ╚═  ╩ ╩╚═╝═╩╝╩╚  
echo "2. modify hpmor_epub.tex"
sed '3i\\\input{hp-format}\n\\input{hp-markup}\n' hpmor.tex > hpmor_epub.tex
sed -i '/\\\input{hp-contents}/d' hpmor_epub.tex

# ╔╦╗╔═╗  ╔═╗╦  ╔═╗╔╦╗╔╦╗╔═╗╔╗╔
#  ║ ║ ║  ╠╣ ║  ╠═╣ ║  ║ ║╣ ║║║
#  ╩ ╚═╝  ╚  ╩═╝╩ ╩ ╩  ╩ ╚═╝╝╚╝
echo "3. to flatten.tex"
# convert multiple tex files to one flatten.tex
latexpand hpmor_epub.tex -o hpmor_flatten.tex

# ╔╦╗╔═╗╔╦╗╦╔═╗
# ║║║║ ║ ║║║╠╣ 
# ╩ ╩╚═╝═╩╝╩╚  
echo "4. modif flatten.tex"
sed -i '/\\begin{headlines}/d ; /\\end{headlines}/d' hpmor_flatten.tex		# - \headlines (can't generate epub)
sed -i 's/\.pdf/\.png/g' hpmor_flatten.tex

# Cant find a way to add directly font or class name in span… ⇒ hack: add color → class
sed -i 's/{Parseltongue.ttf}#1}/{Parseltongue.ttf}\\textcolor{YellowOrange}{#1}}/g' hpmor_flatten.tex
sed -i 's/{gabriele-bad.ttf}#1}/{gabriele-bad.ttf}\\textcolor{YellowGreen}{#1}}/g' hpmor_flatten.tex
sed -i 's/\\textcolor{blue}{\\Huge{\\underline{\\textcolor{red}{#1}}}}/\\textcolor{red}{#1}/g' hpmor_flatten.tex

sed -i 's/\\vskip .1\\baselineskip plus .1\\baselineskip minus .1\\baselineskip//g' hpmor_flatten.tex
sed -i 's/\\vskip 1\\baselineskip plus 1\\baselineskip minus 1\\baselineskip//g' hpmor_flatten.tex
sed -i 's/\\vskip 0pt plus 2//g' hpmor_flatten.tex

sed -i 's/\\begin{align\*}//g ; s/\\end{align\*}//g ; s/ }&\\hbox{/ }\\hbox{/g' hpmor_flatten.tex

sed -i 's/\\hplettrineextrapara//g' hpmor_flatten.tex

sed -i '/^\\def{\\ifnum\\prevgraf/,/^\\fi}/d;' hpmor_flatten.tex

# ╔╦╗╔═╗  ╦ ╦╔╦╗╔╦╗╦  
#  ║ ║ ║  ╠═╣ ║ ║║║║  
#  ╩ ╚═╝  ╩ ╩ ╩ ╩ ╩╩═╝
echo "5. to html"
pandoc -s hpmor_flatten.tex -o hpmor.html -f latex+latex_macros --metadata title="$title"

# ╔╦╗╔═╗╔╦╗╦╔═╗
# ║║║║ ║ ║║║╠╣ 
# ╩ ╩╚═╝═╩╝╩╚  
echo "6. modif hpmor.html"
sed -i 's/<span style=\"color: YellowOrange\">/<span class=\"parsel\">/g' hpmor.html
sed -i 's/<span style=\"color: YellowGreen\">/<span class=\"headline\">/g' hpmor.html
sed -i 's/<span style=\"color: red\">/<span class=\"mcgonagallboard\">/g' hpmor.html

sed -i '/<p>‘ ‘ ‘ ‘ ‘̇ ‘  ‘ ‘ ‘ ‘<\/p>/,/bubble.png/d' hpmor.html

# ╔╦╗╔═╗  ╔═╗╔═╗╦ ╦╔╗ 
#  ║ ║ ║  ║╣ ╠═╝║ ║╠╩╗
#  ╩ ╚═╝  ╚═╝╩  ╚═╝╚═╝
echo "7. modif hpmor.html"
pandoc -s hpmor.html -o hpmor.epub --metadata title="$title" --metadata author="$author" --epub-cover-image="cover.png" --epub-chapter-level=2 --epub-embed-font="./fonts/automobile_contest/Automobile Contest.ttf" --epub-embed-font="./fonts/graphe/Graphe_Alpha_alt.ttf" --epub-embed-font="./fonts/Parseltongue/Parseltongue.ttf" --epub-embed-font="./fonts/graphe/Graphe_Alpha_alt.ttf" --epub-embed-font="./fonts/gabriele_bad_ah/gabriele-bad.ttf" -c "./ebook/2epub.css"

# ╔╦╗╔═╗╦  ╔═╗╔╦╗╔═╗  ╔╦╗╔╦╗╔═╗  ╔═╗╦╦  ╔═╗╔═╗
#  ║║║╣ ║  ║╣  ║ ║╣    ║ ║║║╠═╝  ╠╣ ║║  ║╣ ╚═╗
# ═╩╝╚═╝╩═╝╚═╝ ╩ ╚═╝   ╩ ╩ ╩╩    ╚  ╩╩═╝╚═╝╚═╝
echo "8. cleanup"
for file in "cover" "bubble" "Deathly_Hallows_Sign"; do 	# del png
  rm -f $file.png
done
rm -f cover.pdf hpmor_epub.tex hpmor_flatten.tex hpmor.html


# TODO:
# passer par un dossier tmp…
# pourquoi lettrine a class dans span et pas parsel ??????? et pourquoi lettrinepara ne semble pas passer ?
# Essayer avec otf plutot que ttf ?
# Il y a encore quelques « plus 1» et peut-être d’autres…
# Quid des notes de bas de pages ?
# check dependencies
