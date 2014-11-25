# Haskell codebase historian dojo

We're writing some sort of git log processor to do some historical analysis of our codebase. To get going:

    terminal$...
    sudo apt-get install ghc cabal-install   # or however your platform does it
    cabal update && cabal install split
    ghci

    ghci>...
    :l historian.hs
    run "path/to/repo"           -- run historian over commit log (default: echo)

    -- finally, edit historian.hs... :l... run... repeat

## Frankenstein's creations...

Links & a personal favourite snippet from each project...

 - Emlyn & David's [word cloud](https://github.com/DouglasOrr/HistorianDojo/blob/emlynAdamDavid/historian.hs#L27)
```haskell
[x | x <- (listWords log), (not (Data.Set.member x banned))]
```
 - Tommy, Chet & Kostas's [day counter](https://github.com/DouglasOrr/HistorianDojo/blob/tommy_chet_kostas/historian.hs#L17)
```haskell
countDays (map (precious . (\x -> read x :: Integer)) times)
```
 - Adam's [word cloud](https://github.com/DouglasOrr/HistorianDojo/blob/emlynAdamDavid/historian_adam.hs#L11)
```haskell
ys = sortBy (on compare length) (group (analyseHistory xs))
```
 - Marcin, Simon & Doug's [word count](https://github.com/DouglasOrr/HistorianDojo/blob/dougSimonMarcin/historian.hs#L8)
```haskell
ft (h:t) = M.insertWith (+) h 1 (ft t)
```

## Possibly helpful things

 - [git log pretty format](https://www.kernel.org/pub/software/scm/git/docs/git-log.html#_pretty_formats)
 - [Haskell Prelude](http://hackage.haskell.org/package/base-4.7.0.1/docs/Prelude.html)
 - [Haskell cheat sheet](http://cheatsheet.codeslower.com/CheatSheet.pdf)
