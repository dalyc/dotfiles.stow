{-# LANGUAGE DeriveDataTypeable #-}
--
-- author: vodik
--
module DynamicTopic where

import Codec.Binary.UTF8.String
import Control.Applicative
import Control.Monad
import Data.Map (Map)
import Data.Maybe
import System.Directory (setCurrentDirectory)
import System.Posix.Process (createSession, executeFile, forkProcess)
import qualified Data.Map as M

import XMonad
import XMonad.Prompt ( XPConfig )
import XMonad.Prompt.Directory (directoryPrompt)
import qualified XMonad.StackSet as W
import qualified XMonad.Util.ExtensibleState as XS

topics :: Map String FilePath
topics = M.fromList
    [ ("web", "Downloads")
    , ("im", "Downloads")
    , ("dev", "dev/UNI")
    , ("doc", "dev/00-Elearn")
    ]

data TopicDirs = TopicDirs { dirs :: Map String FilePath } deriving (Read, Show, Typeable)

instance ExtensionClass TopicDirs where
    initialValue  = TopicDirs topics
    extensionType = PersistentExtension

spawnShell :: X ()
spawnShell = currentTopicDir >>= spawnShellIn

spawnShellIn :: FilePath -> X ()
spawnShellIn dir = asks (terminal . config) >>= \t -> safeSpawnIn dir t []

cleanPath :: FilePath -> FilePath
cleanPath ['~']        = []
cleanPath ('~':'/':xs) = xs
cleanPath xs           = xs

safeSpawnIn :: MonadIO m => FilePath -> FilePath -> [String] -> m ()
safeSpawnIn dir prog args = io . void . forkProcess $ do
    uninstallSignalHandlers
    _ <- createSession
    catchIO . setCurrentDirectory $ cleanPath dir
    executeFile (encodeString prog) True (map encodeString args) Nothing

currentTopicDir :: X String
currentTopicDir = do
    tag <- gets $ W.tag . W.workspace . W.current . windowset
    fromMaybe "~" . M.lookup tag . dirs <$> XS.get

updateTopicDir :: String -> X ()
updateTopicDir dir = do
    tag <- gets $ W.tag . W.workspace . W.current . windowset
    XS.modify $ TopicDirs . M.insert tag dir . dirs

changeDir :: XPConfig -> X ()
changeDir c = directoryPrompt c "Set working directory: " updateTopicDir
