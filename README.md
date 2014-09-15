# Haskell codebase historian dojo

We're writing some sort of git log processor to do some historical analysis of our codebase. To get going:

    terminal$...
    sudo apt-get install ghc     # or however your platform does it
    ghci

    ghci>...
    :l historian.hs
    run "path/to/repo"           -- run the program over these logs (default: echo)
    -- finally, edit historian.hs... :l... run... repeat