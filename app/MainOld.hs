{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE ScopedTypeVariables #-}

module MainOld where

import Aws.Lambda
import qualified Lib

-- Use this action if you want to have context that is shared between lambda calls.
-- It is called once per every cold start. We do not wish to have a shared context for our lambda, so we simply use Unit.
initializeContext :: IO ()
initializeContext = return ()

generateLambdaDispatcher StandaloneLambda defaultDispatcherOptions

-- main :: IO ()
-- main =
--   runLambdaHaskellRuntime
--     defaultDispatcherOptions
--     (pure ())
--     id
--     (addStandaloneLambdaHandler "handler" Lib.handler)

-- main :: IO ()
-- main = do
--   context <- getContext
--   input <- getInput
--   result <- Lib.handler input context
--   publish result
