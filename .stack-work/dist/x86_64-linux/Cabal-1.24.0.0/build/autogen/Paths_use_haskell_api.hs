{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_use_haskell_api (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/dheg/Documents/Cs4032-use-haskell-api/.stack-work/install/x86_64-linux/lts-7.10/8.0.1/bin"
libdir     = "/home/dheg/Documents/Cs4032-use-haskell-api/.stack-work/install/x86_64-linux/lts-7.10/8.0.1/lib/x86_64-linux-ghc-8.0.1/use-haskell-api-0.1.0.0-3nD5NWCHf1N83LkkK3wDn9"
datadir    = "/home/dheg/Documents/Cs4032-use-haskell-api/.stack-work/install/x86_64-linux/lts-7.10/8.0.1/share/x86_64-linux-ghc-8.0.1/use-haskell-api-0.1.0.0"
libexecdir = "/home/dheg/Documents/Cs4032-use-haskell-api/.stack-work/install/x86_64-linux/lts-7.10/8.0.1/libexec"
sysconfdir = "/home/dheg/Documents/Cs4032-use-haskell-api/.stack-work/install/x86_64-linux/lts-7.10/8.0.1/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "use_haskell_api_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "use_haskell_api_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "use_haskell_api_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "use_haskell_api_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "use_haskell_api_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
