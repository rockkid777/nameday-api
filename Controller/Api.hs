module Controller.Api(run) where

import           Control.Lens
import           Control.Monad.Trans.Except
import           Data.Aeson
import           Data.Aeson.Encode.Pretty   (encodePretty)
import           Data.Proxy
import           Data.Swagger
import           Data.Text                  (Text)
import           Data.Text.Encoding
import           Data.Time                  (UTCTime (..), fromGregorian)
import           Data.Typeable              (Typeable)
import           GHC.Generics
import           Model.Warranty
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Persistence.Handle
import           Servant
import           Servant.Swagger
