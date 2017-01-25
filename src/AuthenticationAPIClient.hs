{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeOperators      #-}

module AuthenticationAPIClient where

import           Data.Proxy
import           Servant.API
import           Servant.Client
import           AuthenticationAPI


authAPI :: Proxy API
authAPI = Proxy

-- | The function type of the interface here.
-- Each function matches one of the endpoints in type API from UseHaskellAPI.hs

register	::  UserInfo -> ClientM Bool
login 		::  LoginRequest -> Token

-- | The following provides the implementations of these types
-- Note that the order of the functions must match the endpoints in the type API from UseHaskell.hs

(register :<|> login) = client authAPI