{-# LANGUAGE ForeignFunctionInterface #-}

module Network.Email.Check where

import Foreign
import Foreign.C.Types
import Text.Email.Validate
import Foreign.C

#include "check-mx.h"

foreign import ccall "check-mx.h check_mx" checkMx
    :: CString -> IO CInt

-- | Check to see whether an email is (1) RFC-valid and (2) has an
-- existant MX record.
check :: String -> IO (Either String EmailAddress)
check email = do
  case validate email of
    Left e -> return $ Left $ show e
    Right e -> do exists <- withCString (domainPart e) checkMx 
                  if exists /= 0
                     then return $ Right e
                     else return $ Left $ "no MX record exists for domain "
                                          ++ (domainPart e)
    
