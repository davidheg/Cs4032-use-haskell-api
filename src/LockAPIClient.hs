{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeOperators      #-}

module LockAPIClient where

import           Data.Proxy
import           Servant.API
import           Servant.Client
import           UseHaskellAPI


lockAPI :: Proxy API
lockAPI = Proxy

-- | The function type of the interface here.
-- Each function matches one of the endpoints in type API from UseHaskellAPI.hs


requestLock :: LockRequest -> ClientM (Maybe Lock)
releaseLock :: Lock -> ClientM Bool

-- | The following provides the implementations of these types
-- Note that the order of thes functions must match the endpoints in the type API from UseHaskell.hs

(requestLock :<|> releaseLock) = client lockAPI
