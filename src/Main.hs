module Main where

import Compendium.Beaneater
import Network.Beanstalk
import Control.Concurrent
import System.Environment



runEater  host port =  do
    		bs <- connectBeanstalk host port
    		eatBeans bs

main = do 
        argv <- getArgs
        let host : port : xs = argv
        mapM (\_  -> (forkIO (runEater host port))) [1..100] 
        runEater host port

