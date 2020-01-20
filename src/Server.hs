{-# LANGUAGE OverloadedStrings #-}

module Server (runApp, app) where

import Service (storeUrl, getUrl)

import qualified Web.Scotty as S

import Network.HTTP.Types.Status (status500, status404, statusMessage)

import qualified Data.Text.Lazy as T
import qualified Data.Text.Encoding as T

type Port = Int

runApp :: Port -> IO ()
runApp port = runAppWith (S.scotty port)

runAppWith :: (S.ScottyM () -> IO a) -> IO a
runAppWith f = f app

app :: S.ScottyM ()
app = do
  S.get  "/healthcheck" $ S.text "I'm ok"

  S.post "/new-url" $
    S.param "long-url" >>= either serverError S.text . storeUrl

  S.get  "/:random_id" $
    S.param "random_id" >>= either serverError redirectTo . getUrl

  where
    serverError err = S.status $ status500 { statusMessage = T.encodeUtf8 (T.toStrict err) }
    redirectTo = maybe (S.status status404) S.redirect
