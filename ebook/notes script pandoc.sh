#/bin/bash

pandoc hpmor.tex -o hpmor_text.html
sed -i 's/\&lt\;\&lt\; /«\&nbsp\;/g ; s/ \&gt\;\&gt\;/\&nbsp\;»/g' hpmor_text.html
sed -i 's/\~: }\&amp\;\\hbox{\\scshape /\&nbsp\;: /g  ;  s/\\hbox{\\scshape //g  ;  s/\$\$\\begin{aligned}//g  ;  s/}\\end{aligned}\$\$//g  ;  s/}\\\\/<br\/>/g' hpmor_text.html

ligne 260 vide (writtennote)


ligne 7232 (la métamorphose…)

<div class="center">
<p>-1.7ex</p>
</div>

pandoc hpmor_text.html -o hpmor_text.epub







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





Autre essai, dans un tex…

pandoc hpmor.tex -o hpmor_text.tex

