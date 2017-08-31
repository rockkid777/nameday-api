{-# LANGUAGE OverloadedStrings #-}
import           Data.List.Split    ()
import qualified Data.Text          as T
import           System.Environment
import           System.IO          ()

type NameDay = ((Int, Int), [T.Text])

fromList :: [T.Text] -> NameDay
fromList str = (mkPair (take 2 (T.splitOn "." (head str))),
 map T.strip (T.splitOn "," (last str)))
    where
        mkPair :: [T.Text] -> (Int, Int)
        mkPair str' = (read $ T.unpack (head str'), read $ T.unpack (last str'))

processLine :: T.Text -> NameDay
processLine =  fromList . take 2 . map T.strip . T.splitOn "\t" . T.strip

main :: IO ()
main = do
    args <- getArgs
    content <- readFile $ head args
    mapM_ (print . processLine) $ T.lines $ T.pack content
