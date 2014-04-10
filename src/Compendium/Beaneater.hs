{-# LANGUAGE DeriveDataTypeable, OverloadedStrings #-}
module Compendium.Beaneater where

import Network.Beanstalk
import Control.Exception
import qualified Data.ByteString.Char8 as B



eatBeans :: BeanstalkServer -> IO ()
eatBeans bs = do 
            watchAllTubes bs
            eatNBeans bs 10000
            eatBeans bs

eatNBeans :: BeanstalkServer -> Int  -> IO ()
eatNBeans bs times  = if times <= 0 then return ()  else (eatBean bs 60) >>
                                                (eatNBeans bs (times -1))

ignoreBeanstalkError :: BeanstalkException -> IO ()
ignoreBeanstalkError err =  putStr ("Error Caught " ++ (show err) ++" \n") 


                            
-- Takes a beanstalk and int
eatBean :: BeanstalkServer -> Int -> IO ()
eatBean bs timeout = catch  (eatBean'  bs timeout) ignoreBeanstalkError
            where 
                eatBean' bs timeout = do 
			job <- reserveJobWithTimeout bs timeout 
                        --putStr ("Eating Job " ++ show (job_id job) ++ "\n")
			deleteJob bs (job_id job)



watchAllTubes :: BeanstalkServer -> IO ()
watchAllTubes bs = listTubes bs >>= watchTubes bs  >> return ()
                   where 
                        watchTubes bs (x:xs) = watchTube bs x  >> watchTubes bs xs
                        watchTubes _ []   = return ()



