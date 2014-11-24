import Data.List
import Data.List.Split
import System.Process
import qualified Data.Map as M

ft :: Ord a => [a] -> M.Map a Int
ft [] = M.empty
ft (h:t) = M.insertWith (+) h 1 (ft t)

extract :: String -> (String, [String])
extract x = (author, words comment)
	where [author, comment] = splitOn "\t" x 

-- The program - a function from a list of strings (git log) to another list of strings (output)
analyseHistory :: [String] -> [String]
--analyseHistory x = ft (concat (map ( snd . extract ) x))


----- YOUR CODE HERE -----
analyseHistory log = log                                            -- echo
--analyseHistory log = [(show (length log)) ++ " commits"]            -- commit count
--analyseHistory = sort . concat . map (words . last . splitOn "\t")  -- sorted list of words in commit subjects


-- You could use/adapt this as sample input to 'analyseHistory'
egInput = ["Alice\tInitial commit",
           "Bob\tBreak something",
           "Alice\tFix it!"]

-- Customise this if you want different info from git (see "git log --help")
--   hash <tab> timestamp <tab> author <tab> subject
gitLogArgs = ["--pretty=%an%x09%s"]


--------------------------------------------------------------------------------

-- Runs everything (including 'git log') straight from Haskell (maybe useful for interactive testing).
-- Usage: ghci> run "path/to/repo"
run :: String -> IO ()
run repoDir = gitLog >>= (putStr . unlines . analyseHistory . lines)
  where gitLog = readProcess "git" (["--git-dir", (repoDir ++ "/.git"), "log"] ++ gitLogArgs) ""

-- Pipe in git logs, pipe out results
-- Usage: $ git log --pretty=... | runhaskell /path/to/historian.hs
main :: IO ()
main = interact (unlines . analyseHistory . lines)
