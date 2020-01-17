module Server (runApp) where

type Port = Int

runApp :: Port -> IO ()
runApp port = putStrLn $ "Running server on localhost:" <> show port
