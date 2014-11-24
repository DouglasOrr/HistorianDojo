import Data.List
import Data.List.Split
import Data.Function (on)
import System.Process

-- The program - a function from a list of strings (git log) to another list of strings (output)
analyseHistory :: [String] -> [String]
analyseHistory = sort . concat . map (words . last . splitOn "\t")

wordCloud :: [String] -> [(Int, String)]
wordCloud xs = zip (map length ys) (map head ys)
	where
		ys = sortBy (on compare length) (group (analyseHistory xs))
-- sorted list of words in commit subjects
----- YOUR CODE HERE -----
--analyseHistory log = log                                            -- echo
--analyseHistory log = [(show (length log)) ++ " commits"]            -- commit count

-- You could use/adapt this as sample input to 'analyseHistory'
egInput = ["aaaaaaa\t10000\tAlice\tInitial commit",
           "bbbbbbb\t20000\tBob\tBreak something",
           "ccccccc\t30000\tAlice\tFix it!",
           "ddddddd\t40000\tBob\tFix it properly!"]

-- Customise this if you want different info from git (see "git log --help")
--   hash <tab> timestamp <tab> author <tab> subject
gitLogArgs = ["--pretty=%h%x09%at%x09%an%x09%s"]

--------------------------------------------------------------------------------

-- Runs everything (including 'git log') straight from Haskell (maybe useful for interactive testing).
-- Usage: ghci> run "path/to/repo"
run :: String -> IO ()
run repoDir = gitLog >>= (putStr . unlines . (map show) . wordCloud . lines)
  where gitLog = readProcess "git" (["-C", repoDir, "log"] ++ gitLogArgs) ""

-- Pipe in git logs, pipe out results
-- Usage: $ git log --pretty=... | runhaskell /path/to/historian.hs
main :: IO ()
main = interact (unlines . analyseHistory . lines)
