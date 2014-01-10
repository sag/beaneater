module Main where

import Compendium.Beaneater
import Network.Beanstalk
import System.Environment

main = do 
		argv <- getArgs
		let host : port : xs = argv
    		bs <- connectBeanstalk host port
    		eatBeans bs
