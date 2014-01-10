module Paths_beaneater (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/sgregory/Library/Haskell/ghc-7.6.3/lib/beaneater-0.1.0.0/bin"
libdir     = "/Users/sgregory/Library/Haskell/ghc-7.6.3/lib/beaneater-0.1.0.0/lib"
datadir    = "/Users/sgregory/Library/Haskell/ghc-7.6.3/lib/beaneater-0.1.0.0/share"
libexecdir = "/Users/sgregory/Library/Haskell/ghc-7.6.3/lib/beaneater-0.1.0.0/libexec"
sysconfdir = "/Users/sgregory/Library/Haskell/ghc-7.6.3/lib/beaneater-0.1.0.0/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "beaneater_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "beaneater_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "beaneater_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "beaneater_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "beaneater_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
