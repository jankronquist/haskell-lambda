module Lib where

import GHC.Generics
import Data.Aeson
import Aws.Lambda

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
  , address :: Address
  } deriving (Generic)

instance FromJSON Person
instance ToJSON Person

data Strange = APerson Person | AnAddress Address deriving (Generic)

instance FromJSON Strange
instance ToJSON Strange

handler :: Strange -> Context () -> IO (Either String Address)
handler strange context =
  case strange of
    APerson p ->
      return (Right $ address p)
      -- if (personAge p > 0)
      --   return (Right $ address p)
      -- else
      --   Left "wrong"
    AnAddress a -> return (Right a)
