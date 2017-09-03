module Main where

import           Api.Web            (run)
import           Persistence.FileDB
import           Persistence.Handle
import           System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    print args
    -- handle <- makeHandle $ head args
    -- run (read $ args !! 1) handle
    -- print $ namesFor handle (read $ args !! 1, read $ args !! 2)
