module Lib where

import GHC.Generics
import Data.Aeson
import Aws.Lambda
import qualified System.Environment as Environment
import Data.Text (Text, pack, unpack)
import DbStuff (doStuff)
import Data.Maybe (fromMaybe)

readEnvironmentVariable :: Text -> IO (Either String String)
readEnvironmentVariable envVar = do
  v <- Environment.lookupEnv (unpack envVar)
  case v of
    Just value -> return (Right value)
    Nothing -> return (Left "Env varialbe not set")

data Address = Address
  { streetName :: String
  , streetNumber :: Int
  , city :: String
  } deriving (Generic)

instance FromJSON Address
instance ToJSON Address

data Stuff = Stuff
  { message :: String
  , number :: Int
  } deriving (Generic)

instance FromJSON Stuff
instance ToJSON Stuff

handler :: String -> Context () -> IO (Either String Stuff)
handler strange context = do
    n <- doStuff
    return (Right (Stuff "msg" (fromMaybe 17 n)))
  -- case readEnvironmentVariable "MESSAGE" of
  --   Right m -> do
  --     n <- doStuff
  --     return (Right (Stuff m (fromMaybe 17 n)))
  --   Left m -> return (Left m)
