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

handler :: Person -> Context () -> IO (Either String Address)
handler person context =
  if personAge person > 0 then
    return (Right $ address person)
  else
    return (Left "A person's age must be positive")
