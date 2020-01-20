module Service (storeUrl, getUrl) where

import Data.Text.Lazy (Text)

storeUrl :: Text -> Either Text Text
storeUrl = undefined

getUrl :: Text -> Either Text (Maybe Text)
getUrl = undefined
