{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Model.Migration where

import System.Directory
import ClassyPrelude.Yesod
import Database.Persist.Quasi

mkMigrate "migrateAll" $(do
    files <- liftIO $ do
        dirContents <- getDirectoryContents "config/models/"
        pure $ map ("config/models/" <>) $ filter (".persistentmodels" `isSuffixOf`) dirContents
    persistManyFileWith lowerCaseSettings files
    )
