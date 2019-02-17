module OAuth.Core
  ( generateAuthUrl
  , getToken
  , createOAuth
  , OAuth
  ) where

import Prelude
import Data.Either (Either(..))
import Data.Function.Uncurried (Fn4) as Fn
import Data.Function.Uncurried (runFn4)
import Effect (Effect)
import Effect.Aff (Aff, Canceler, makeAff)
import Effect.Exception (Error)

foreign import data OAuth :: Type

foreign import createOAuth :: String -> String -> String -> Effect OAuth

foreign import generateAuthUrl :: OAuth -> Array String -> Effect String

foreign import _getToken :: Fn.Fn4 (Error -> Effect Unit) (String -> Effect Unit) OAuth String (Effect Canceler)


getToken :: OAuth -> String -> Aff String
getToken oauth code = makeAff (\cb -> runFn4 _getToken (cb <<< Left) (cb <<< Right) oauth code)