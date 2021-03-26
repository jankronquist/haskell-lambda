module Lib where

import GHC.Generics
import Data.Aeson
import Aws.Lambda
import qualified System.Environment as Environment
import Data.Text (Text, pack, unpack)

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

data Person = Person
  { personName :: String
  , personAge :: Int
  } deriving (Generic)

instance FromJSON Person
instance ToJSON Person

data Strange = APerson Person | AnAddress Address deriving (Generic)

instance FromJSON Strange
instance ToJSON Strange

handler :: Person -> Context () -> IO (Either String String)
handler strange context = do
  msg <- readEnvironmentVariable "MESSAGE"
  return msg
