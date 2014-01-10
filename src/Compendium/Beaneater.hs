{-# LANGUAGE DeriveDataTypeable, OverloadedStrings #-}
module Compendium.Beaneater where

import Network.Beanstalk
import Control.Exception
import qualified Data.ByteString.Char8 as B



eatBeans :: BeanstalkServer -> IO ()
eatBeans bs = do 
				watchAllTubes bs
				eatNBeans bs 90





eatNBeans :: BeanstalkServer -> Int  -> IO ()
eatNBeans bs times  = if times <= 0 then return ()  else (eatBean bs 60) >>
														(eatNBeans bs (times -1))

ignoreBeanstalkError :: BeanstalkException -> IO ()
ignoreBeanstalkError ex = return ()

-- Takes a beanstalk and int
eatBean :: BeanstalkServer -> Int -> IO ()
eatBean bs timeout = handle ignoreBeanstalkError   (eatBean'  bs timeout)

eatBean' :: BeanstalkServer -> Int -> IO()
eatBean' bs timeout = do
			job <- reserveJobWithTimeout bs timeout 
			deleteJob bs (job_id job)


watchTubes :: BeanstalkServer -> [B.ByteString] -> IO ()
watchTubes bs (x:xs) = watchTube bs x >> watchTubes bs xs
watchTubes bs []   = return ()


watchAllTubes :: BeanstalkServer -> IO ()
watchAllTubes bs = listTubes bs >>= (watchTubes bs) >> return ()




