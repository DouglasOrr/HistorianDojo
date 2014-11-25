# Haskell codebase historian dojo

## Wordclouds:

![SwiftKey-Android wordcloud](/DouglasOrr/HistorianDojo/blob/emlyn/SwiftKey-Android.png?raw=true "Wordcloud for SwiftKey Android")
![SwiftKey-iOS wordcloud](/DouglasOrr/HistorianDojo/blob/emlyn/SwiftKey-Android.png?raw=true "Wordcloud for SwiftKey iOS")
![Fluency wordcloud](/DouglasOrr/HistorianDojo/blob/emlyn/Fluency.png?raw=true "Wordcloud for Fluency")
![Clarity wordcloud](/DouglasOrr/HistorianDojo/blob/emlyn/Clarity.png?raw=true "Wordcloud for Clarity")

We're writing some sort of git log processor to do some historical analysis of our codebase. To get going:

    terminal$...
    sudo apt-get install ghc cabal-install   # or however your platform does it
    cabal update && cabal install split
    ghci

    ghci>...
    :l historian.hs
    run "path/to/repo"           -- run historian over commit log (default: echo)

    -- finally, edit historian.hs... :l... run... repeat

## Possibly helpful things

 - [git log pretty format](https://www.kernel.org/pub/software/scm/git/docs/git-log.html#_pretty_formats)
 - [Haskell Prelude](http://hackage.haskell.org/package/base-4.7.0.1/docs/Prelude.html)
 - [Haskell cheat sheet](http://cheatsheet.codeslower.com/CheatSheet.pdf)
