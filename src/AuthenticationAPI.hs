{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE DeriveAnyClass       #-}
{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE StandaloneDeriving   #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE TypeSynonymInstances #-}

module AuthenticationAPI (ResponseData(..), API(..), UserInfo(..), LoginRequest(..), Token(..), LoginResponse(..)) where


import           Data.Aeson
import           Data.Aeson.TH
import           Data.Bson.Generic
import           GHC.Generics
import           Servant
import           Data.Time.Clock 

-- Note that in this version of the project, I have moved the REST API into a shared library called use-haskell-api
-- This library is imported here in order that the HackageAPI type is available to create the REST service of that
-- type. Note that there is no advantage in doing this if you are only building a servant REST service, but if you are
-- creating a corresponding REST client, then following this architectural pattern simplifies development considerably.

-- The relevant code is thus commented out here and the use-haskell-api library content is used instead


data UserInfo = UserInfo { username :: String
                         , password :: String
                         } deriving (Show, Generic, FromJSON, ToJSON, ToBSON, FromBSON)

data Token = Token { ticket     :: String
                   , sessionKey :: String
                   , timeout    :: String
                   , user       :: String
                   } deriving (Show, Generic, FromJSON, ToJSON, ToBSON, FromBSON)

data LoginResponse = LoginResponse { token :: String 
                                   } deriving (Generic, ToJSON, FromJSON,FromBSON, Show)

data LoginRequest = LoginRequest { userInfo :: String
                                 } deriving (Show, Generic, FromJSON, ToJSON, ToBSON, FromBSON)

deriving instance FromBSON String  -- we need these as BSON does not provide
deriving instance ToBSON   String

-- | We will also define a simple data type for returning data from a REST call, again with nothing special or
-- particular in the response, but instead merely as a demonstration.

data ResponseData = ResponseData { response :: String
                                 } deriving (Generic, ToJSON, FromJSON,FromBSON, Show)

-- | Next we will define the API for the REST service. This is defined as a 'type' using a special syntax from the
-- Servant Library. A REST endpoint is defined by chaining together a series of elements in the format `A :> B :> C`. A
-- set of rest endpoints are chained in the format `X :<|> Y :<|> Z`. We define a set of endpoints to demonstrate
-- functionality as described int he README.md file below.
--
-- Note in the API below that we can mix GET and Post methods. The type of call is determined by the last element in the
-- :> chain. If the method is Get, then the set of QueryParams determine the attributes of the Get call. If the method
-- is Post, then there will be a single ReqBody element that defines the type being transmitted. The return type for
-- each method is noted in the last element in the :> chain.

type API = "login"    :> ReqBody '[JSON] LoginRequest :> Get  '[JSON] (Maybe LoginResponse)
      :<|> "register" :> ReqBody '[JSON] UserInfo     :> Post '[JSON] Bool 



