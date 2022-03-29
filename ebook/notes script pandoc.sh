#/bin/bash

`pandoc hpmor.tex -s -o hpmor_text.html`
* -s permet d’ajouter un entête html

Cette solution ne convient pas car les "\parsel" et "\McGonagallWhiteBoard", "\writtennote",… (newcommand/macro) sont vidés !

`pandoc -s ../hpmor.tex -o hpmor_flatten.html -f markdown-latex_macros --metadata title="HPMOR"`
essayé aussi avec -f markdown+latex_macros, aucun ne fonctionne… (que ce soit à partir du fichier hpmor.tex ou la version flatten…)

Créer un fichier latex unique :
`python ebook/latex-flatten.py hpmor.tex hpmor_flatten.tex`

Donne des erreurs :
* `tex4ebook -x hpmor.tex`
* `make4ht -ux hpmor.tex out.html`
* `hevea hpmor_flatten.tex -o hpmor.html`
* `plasTeX`
* `latexml --destination=out.html --includestyles hpmor_flatten.tex`



```
sed -i 's/\&lt\;\&lt\; /«\&nbsp\;/g ; s/ \&gt\;\&gt\;/\&nbsp\;»/g' hpmor_text.html
sed -i 's/\~: }\&amp\;\\hbox{\\scshape /\&nbsp\;: /g  ;  s/\\hbox{\\scshape //g  ;  s/\$\$\\begin{aligned}//g  ;  s/}\\end{aligned}\$\$//g  ;  s/}\\\\/<br\/>/g' hpmor_text.html
pandoc hpmor_text.html -o hpmor_text.epub
```




Essai peut-être envisageable en passant par une étape md…
```
python ebook/latex-flatten.py hpmor.tex hpmor_flatten.tex 	 		# flatten
pandoc hpmor_flatten.tex -f markdown+latex_macros -s -o hpmor.md	# md
```











<!DOCTYPE html>
<html lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="Eliezer Yudkowsky" />
<title>Harry Potter et les Méthodes de la Rationalité</title>
<style>
	div.letter { font-style: italic; margin-left: 1em; }
	div.verse { margin-left: 1em; }
	div.playdialog { text-indent: -1em; margin-left: 2em; }
	div.headlines { }
	div.center { text-align: center; }
	div.center_sc { text-align: center; font-variant: small-caps; }
	div.later { text-align: center; }
	div.emph { font-style: italic; }
	span.abbrev{ text-transform: lowercase; font-variant: small-caps; }
	span.prophesy { font-variant: small-caps; }
	span.scream { text-transform: uppercase; }
	span.shout { font-variant: small-caps; }
	span.parsel{ font-style: italic; }
	span.headline_header{ }
	span.headline{ font-style: italic; }
	span.headline_label{ font-variant: small-caps; }
	span.smallcaps{ font-variant: small-caps; }
	span.uppercase{ text-transform: uppercase; }
	h1 {color:#ff0000; page-break-before: always; page-break-after: always} # Ce n’est pas ça qui fonctionne mais après tout, pas de break est-ce grave ?
	h2 {color:#00ff00; page-break-before: always;} 
</style>
</head>
<body>



