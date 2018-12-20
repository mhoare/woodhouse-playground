-- Recursive sum of even numbers in list l with initial sum of n
-- Written in a traditional programming language apporach
accumSum :: Integer -> [Integer] -> Integer
accumSum n l = 
    if l == []
        then n
    else let x  = head l
             xs = tail l
         in 
            if even x
                then accumSum (n+x) xs
            else accumSum n xs

-- Recursive sum of even numbers in list l with initial sum of n
-- Written in a `Haskelly` approach
accumSum' :: Integer -> [Integer] -> Integer
accumSum' n []   = n
accumSum' n (x:xs)
    | even x    = accumSum' (n+x) xs
    | otherwise = accumSum' n xs
