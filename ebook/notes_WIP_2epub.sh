# Essai Pandoc

```
pandoc hpmor.tex -s -o hpmor_text.html
```

* -s permet d’ajouter un entête html

Cette solution ne convient pas car les "\parsel" et "\McGonagallWhiteBoard", "\writtennote",… (newcommand/macro) sont vidés !

```
pandoc -s ../hpmor.tex -o hpmor_flatten.html -f markdown-latex_macros --metadata title="HPMOR"
```

essayé aussi avec -f markdown+latex_macros, aucun ne fonctionne… (que ce soit à partir du fichier hpmor.tex ou la version flatten…). Toutefois, à part ce gros problème, le fichier epub qu’on peut obtenir à partir du html ou même directement est le plus propre que j’ai pu voir

# Fichier latex unique

Je tente la création d’un fichier tex unique car certaines fonctions semblent ne pas fonctionner dans un 

```
python ebook/latex-flatten.py hpmor.tex hpmor_flatten.tex
```

Cette étape sera très probablement nécessaire

# Alternatives à Pandoc

* `tex4ebook -x hpmor.tex`
* `make4ht -ux hpmor.tex out.html`
* `hevea hpmor_flatten.tex -o hpmor.html`
* `plasTeX`
* `latexml --destination=out.html --includestyles hpmor_flatten.tex`

Tous ses essais donnent des erreurs.

# Pandoc avec étape intermédiaire md ?

Je constate qu’une conversion en md permet de garder les macros. 

```
python ebook/latex-flatten.py hpmor.tex hpmor_flatten.tex
pandoc -s hpmor_flatten.tex -f markdown+latex_macros -o hpmor.md
```

Hélas, la conversion md→html pose toujours le même problème

# Retour de Pandoc ! (2022-03-30) 

Je veux réessayer Pandoc, je dois juste comprendre pourquoi le contenu des macros disparaissent. Je cherche [ici](https://github.com/jgm/pandoc/issues/1426) et évidemment la [doc](https://pandoc.org/MANUAL.html)

Je fais un essai en ajoutant la définition d’une newcommand directement au début du fichier flatten.tex

```
pandoc hpmor_flatten.tex -f latex+latex_macros -o hpmor.html
```

Ne fonctionne pas car il y a un blocage pour 2 passages sous forme de code. Pour le test, je supprime simplement ces deux passages. Et cette macro est alors bien convertie ! Je fais le même essai en ajoutant toutes les définitions via `\input{hp-header}` au début de flatten ! (et qu’on supprime les 2 trucs qui gêne).
```

Je supprime le début du chapitre 86 :

```latex
\begin{headlines}
[…]
\end{headlines}

```

Il y a encore pas mal de problèmes dans le epub mais c’est déjà une grande avancée, avec cette solution le script de conversion serait largement simplifié, éviterai les traductions dans le scripts et simplifierai et l’epub est mieux structuré (le chapitrage semble propre dans fbreader) !


# Étape par étape…

J’ai remplacé << par « et >> par » directement dans les chapitres tex, cela n’empêche en rien d’obtenir un pdf correct et m’évite la ligne sed du script. Il est donc un petit peu simplifié.

# Latexpand

Latexpand est un logiciel ayant la même utilité que le script python latex-flatten. Le fichier de sortie étant un peu différent, je tente le coup pour voir si c’est mieux… Le résultat étant sensiblement identique, je supprime latex-flatten.py, remplacé par une commande latex fournie dans texlive…


# begin{headlines} / end{headlines}

En supprimant ces deux lignes, la conversion en epub se fait, ce sont les deux seules lignes du chapitres 86 qui semblent poser problème. Le script converti directement en epub sans modification

```sh
latexpand hpmor.tex -o hpmor_flatten.tex                                                                                            # flatten tex
sed -i '1i\\\input{hp-header}\n' hpmor_flatten.tex                                                                                  # + header pour les def \newcommand
sed -i '/\\begin{headlines}/d ; /\\end{headlines}/d' hpmor_flatten.tex                                                              # - \headlines (can't generate epub)
pandoc -s hpmor_flatten.tex -o hpmor.epub -f latex+latex_macros --metadata title="Harry Potter et les méthodes de la Rationalité" 	# tex to epub
```


# Reste à voir

* Les erreurs dans l’epub (il reste encore pas mal de \\)
* emph est souligné au lieu d’être en italique
* est-il possible d’incorporer les polices (obtenir 2 epub, un avec et l’autre sans polices)
* On pourra alors ensuite ajouter -s et modifier quelques trucs
* On pourra peut-être même faire une conversion directement en epub
* Il va falloir trouver comment faire des span avec nom pour jouer dans le css plutôt que de voir directement les modifs css dans le html
* Faut-il convertir les pdf en jpg
* Comment ajouter l’image de couverture ?
* Peut-on mettre les macros sous forme de css et pas directement dans le code html/epub ?
* Quid des lettrines ?
* Peut-on directement faire en sorte que Pandoc gère bien la conversion de certains caractères mal convertis par défaut ou faut-il Faire des sed pour <<~, \later,… ?
```
sed -i 's/\~: }\&amp\;\\hbox{\\scshape /\&nbsp\;: /g  ;  s/\\hbox{\\scshape //g  ;  s/\$\$\\begin{aligned}//g  ;  s/}\\end{aligned}\$\$//g  ;  s/}\\\\/<br\/>/g' hpmor_text.html
```







