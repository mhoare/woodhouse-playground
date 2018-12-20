{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)
import Data.Monoid
import Data.Aeson (FromJSON, ToJSON, eitherDecode)
import GHC.Generics

data Person = Person { userId :: Int, name :: String, createdAt :: String } 
    deriving (Show, Generic)
instance ToJSON   Person
instance FromJSON Person

jsonURL :: String
jsonURL = "http://localhost:3000/user"

getJSON :: IO B.ByteString
getJSON = simpleHttp jsonURL

main :: IO ()
main = do
 -- Get JSON data and decode it
 d <- (eitherDecode <$> getJSON) :: IO (Either String [Person])
 -- If d is Left, the JSON was malformed.
 -- In that case, we report the error.
 -- Otherwise, we perform the operation of
 -- our choice. In this case, just print it.
 case d of
  Left err -> putStrLn err
  Right ps -> print ps
