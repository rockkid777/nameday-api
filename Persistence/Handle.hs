module Persistence.Handle where
import           Data.Text

data Handle = Handle {
    namesFor :: (Int, Int) -> [Text]
}
