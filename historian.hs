import Data.List
import Data.Set
import Data.List.Split
import System.Process
import Data.MultiSet

freq :: Ord a => [a] -> [(a, Occur)]
freq = toOccurList . Data.MultiSet.fromList

listWords :: [String] -> [String]
listWords = concat . Data.List.map (words . last . splitOn "\t")

bannedWords = Data.Set.fromList ["'master'", "master", "in", "of", "for", "the", "Merge", "and", "when", "with", "is", "not",
 "a", "an", "branch", "to", "into", "on", "from", "-"]

freqWords :: (Set String) -> [String] -> [(Occur, String)]
freqWords banned log = (reverse (sort [(s, f) | (f, s) <- (freq [x | x <- (listWords log), (not (Data.Set.member x banned))])]))

-- The program - a function from a list of strings (git log) to another list of strings (output)
analyseHistory :: [String] -> [String]
----- YOUR CODE HERE -----
--analyseHistory log = log                                            -- echo
--analyseHistory log = [(show (length log)) ++ " commits"]            -- commit count
--analyseHistory = sort . concat . map (words . last . splitOn "\t")  -- sorted list of words in commit subjects

-- This will output a list of most common words ordered by use on the commit messages of the repo
analyseHistory log = Data.List.map show (take 20 (freqWords bannedWords log))
-- e.g.
-- > run "."
-- (2,"some")
-- (2,"Add")
-- (1,"tabs")
-- (1,"setup")
-- (1,"links")
-- (1,"instructions")
-- (1,"install")
-- (1,"input,")
-- (1,"example")
-- (1,"dojo")
-- (1,"de-ponce")
-- (1,"commit")
-- (1,"code")
-- (1,"Names,")
-- (1,"Minorly")
-- (1,"Initial")
-- (1,"'split'")

-- You could use/adapt this as sample input to 'analyseHistory'
egInput = ["aaaaaaa\t10000\tAlice\tInitial commit",
           "bbbbbbb\t20000\tBob\tBreak something",
           "ccccccc\t30000\tAlice\tFix it!"]

-- Customise this if you want different info from git (see "git log --help")
--   hash <tab> timestamp <tab> author <tab> subject
gitLogArgs = ["--pretty=%h%x09%at%x09%an%x09%s"]

--------------------------------------------------------------------------------

-- Runs everything (including 'git log') straight from Haskell (maybe useful for interactive testing).
-- Usage: ghci> run "path/to/repo"
run :: String -> IO ()
run repoDir = gitLog >>= (putStr . unlines . analyseHistory . lines)
  where gitLog = readProcess "git" (["-C", repoDir, "log"] ++ gitLogArgs) ""

-- Pipe in git logs, pipe out results
-- Usage: $ git log --pretty=... | runhaskell /path/to/historian.hs
main :: IO ()
main = interact (unlines . analyseHistory . lines)
