positionalMatches :: [Int] [Int] -> Int
positionalMatches secretCode guess = length (filter (\x -> fst x == snd x) (zip2 secretCode guess))
 
matches :: [Int] [Int] -> Int         
matches secretCode guess = matchesCount secretCode guess 0
	where 	
		matchesCount [] _ matchCount 
				= matchCount
		matchesCount [x:xs] b matchCount
			| isMember x b 
				= matchesCount xs (removeMember x b) (matchCount + 1)
			//
				= matchesCount xs b matchCount

readCode :: String -> Maybe [Int] 
readCode string
    | (length charList <> 4) || (any (not o isDigit) charList)
		= Nothing
	// 
		= Just (map digitToInt charList)
			where  
				charList = fromString string
					
maybe :: (a -> b) b (Maybe a) -> b
maybe function default Nothing = default
maybe function default value   = function (fromJust value)

allMatches :: [Int] String -> (Int, Int)
allMatches secretCode guess  = ( checkGuess matches, checkGuess positionalMatches )
	where
		checkGuess guessComparator = maybe (guessComparator secretCode) 0 (readCode guess)
