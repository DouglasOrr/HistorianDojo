import Data.List
import Data.Tuple
import Data.Set
import Data.Ord
import Data.List.Split
import Data.MultiSet
import Text.Regex.Posix
import System.Process
import Graphics.GD
import Graphics.WordCloud

freq :: Ord a => [a] -> [(a, Occur)]
freq = toOccurList . Data.MultiSet.fromList

listWords :: [String] -> [String]
listWords = concat . Data.List.map words

bannedWords = Data.Set.fromList ["'master'", "master", "in", "of", "for", "the", "Merge", "and", "when", "with", "is", "not",
 "a", "an", "branch", "to", "into", "on", "from", "-", "pull", "request", "Minor:"]
goodWord :: String -> Bool
goodWord w = not ((Data.Set.member w bannedWords) ||
                  (w =~ "(git@)?github.com:.*" :: Bool) ||
                  (w =~ "(richardtunnicliffe|tihancock)/.*" :: Bool))

freqWords :: (String -> Bool) -> [String] -> [(String, Occur)]
freqWords pred log = (reverse (sortBy (comparing swap)
                                        (freq (Data.List.filter pred (listWords log)))))

-- The program - a function from a list of strings (git log) to another list of strings (output)
analyseHistory :: [String] -> [String]
analyseHistory log = Data.List.map show (take 20 (freqWords goodWord log))

conf :: Config
conf = Config {
            confFontFamily = FontName "Arial"
          , confFontSize   = 60
          , confMaxWords   = 80
          , confFontSizeMin = 8
          , confCanvasSize = (1024,768)
          , confDefaultPos = (512,376)
          , confColor      = (100,230,180)
          , confBGColor    = (0,0,0)
          , confCloudAlgo  = Circular }

wordcloud :: [String] -> IO Image
wordcloud log = (makeCloud conf (take 100 (freqWords goodWord log)))

-- You could use/adapt this as sample input to 'analyseHistory'
egInput = ["Initial commit",
           "Break something",
           "Fix it!"]

-- Customise this if you want different info from git (see "git log --help")
--   hash <tab> timestamp <tab> author <tab> subject
gitLogArgs = ["--pretty=%s"]

--------------------------------------------------------------------------------

saveimg :: String -> IO Image -> IO ()
saveimg fname ioimg = do img <- ioimg
                         savePngFile fname img

-- Runs everything (including 'git log') straight from Haskell (maybe useful for interactive testing).
-- Usage: ghci> run "path/to/repo"
run :: String -> String -> IO ()
run fname repoDir = gitLog >>= (saveimg fname . wordcloud . lines)
  where gitLog = readProcess "git" (["-C", repoDir, "log"] ++ gitLogArgs) ""

-- Pipe in git logs, pipe out results
-- Usage: $ git log --pretty=... | runhaskell /path/to/historian.hs
main :: IO ()
main = do
    contents <- getContents
    saveimg "wordcloud.png" (wordcloud (splitOn "\n" contents))
