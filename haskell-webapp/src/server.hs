{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Web.Scotty
import Data.Monoid
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import Control.Monad

infixl 0 |>
(|>) :: a -> (a -> b) -> b
a |> b = b $ a

-- Begin Users

data User = User {
    userId    :: Int,
    name      :: String,
    createdAt :: String
} deriving (Show, Generic)
instance ToJSON User
instance FromJSON User

matthew :: User
matthew =  User { userId = 1, name = "Matthew Hoare", createdAt = "Earlier" }

bob     :: User
bob     =  User { userId = 2, name = "Bob", createdAt = "Earlier"}

allUsers :: [User]
allUsers =  [bob, matthew]

-- End Users

-- Begin Routes

routes :: ScottyM ()
routes = do
    get  "/user"     user
    get  "/user/:id" userById
    post "/user"     createUser

createUser :: ActionM () 
createUser = do
    user <- jsonData :: ActionM User
    let newUser = updateCreated user
    json newUser 

updateCreated :: User -> User
updateCreated u = u {createdAt = "now"}

user :: ActionM ()
user = do
    json allUsers

userById :: ActionM ()
userById = do
    id <- param "id"
    json (filter (matchesId id) allUsers)
-- End Routes

matchesId :: Int -> User -> Bool
matchesId _id user = userId user == _id

main :: IO ()
main = do
    putStrLn "Starting server ..."
    scotty 3000 routes
