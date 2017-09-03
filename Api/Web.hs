{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Api.Web(Api.Web.run) where

import           Control.Lens
import           Control.Monad.Trans.Except
import           Data.Aeson
import           Data.Aeson.Encode.Pretty   (encodePretty)
import           Data.Proxy
import           Data.Text                  (Text)
import           Data.Text.Encoding
import           Data.Typeable              (Typeable)
import           GHC.Generics
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Persistence.Handle
import           Servant

nameDayApi :: Proxy NameDayApi
nameDayApi = Proxy

type NameDayApi = Capture "month" Int :> Capture "day" Int :> Get '[JSON] [Text]

serveGetNamesFor :: Handle -> Int -> Int -> Handler [Text]
serveGetNamesFor h m d = return $ (namesFor h (m, d))

server :: Handle -> Server NameDayApi
server h =  (serveGetNamesFor h)

mkApp :: Handle -> Application
mkApp h = serve nameDayApi $ server h

run :: Int -> Handle -> IO ()
run p handle = do
    Network.Wai.Handler.Warp.run p $ mkApp handle
