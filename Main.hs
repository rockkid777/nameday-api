module Main where

import           Persistence.FileDB
import           Persistence.Handle
import           System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    handle <- makeHandle $ head args
    print $ namesFor handle (read $ args !! 1, read $ args !! 2)
    -- print "hello"
