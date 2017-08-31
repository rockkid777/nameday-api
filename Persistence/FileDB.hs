{-# LANGUAGE OverloadedStrings #-}
module Persistence.FileDB (makeHandle) where

import           Data.List.Split    ()
import qualified Data.Text          as T
import           Model.NameDay      (NameDay)
import           Persistence.Handle
import           System.IO          ()

fromList :: [T.Text] -> NameDay
fromList str = (mkPair (take 2 (T.splitOn "." (head str))),
 map T.strip (T.splitOn "," (last str)))
    where
        mkPair :: [T.Text] -> (Int, Int)
        mkPair str' = (read $ T.unpack (head str'), read $ T.unpack (last str'))

processLine :: T.Text -> NameDay
processLine =  fromList . take 2 . map T.strip . T.splitOn "\t" . T.strip

namesForWithDb :: [NameDay] -> (Int, Int) -> [T.Text]
namesForWithDb db (m, d) = head $ map snd $ filter (\((m', d'), l) -> m == m' && d == d') db

makeHandle :: String -> IO Handle
makeHandle fileName = do
    content <- readFile fileName
    let dbList = map processLine $ T.lines $ T.pack content
    return Handle { namesFor = namesForWithDb dbList }
