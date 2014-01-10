--{ -# LANGUAGE TemplateHaskell #- }
--test.hs 
module Main 
 where
 
import Test.Framework (testGroup, Test, defaultMain)
import Test.Framework.Providers.HUnit
import Test.HUnit hiding (Test)

 

tests = [
			testGroup "Sanity Checks"
			[
				testCase "Sanity" testSanity
				,testCase  "Sanity2" testInSanity2
			]	
		]


-- Stupid sanity check mostly to make sure I figured out how to get the test suite running

testSanity = assertEqual "I don't even know what I'm doing" (1+1) 2

testInSanity2 = assertEqual "I don't even know what I'm doing" (2+1) 3

main = defaultMain tests