import System.IO

listnums :: Int -> [Int]
listnums 1 = [1]
listnums n | n < 1 = [n] ++ listnums(n+1)
           | otherwise = [n] ++ listnums(n-1)

secondlastlist :: [[a]]-> [a]
secondlastlist [] = []
secondlastlist l = [last(head l)] ++ secondlastlist(tail l)

myunion :: [a] -> [a] -> [a]
myunion [] ys = ys
myunion (x:xs) ys = [x] ++ (myunion xs ys)

_exists :: Eq a => a -> [a] -> Bool
_exists a [] = False
_exists a (x:xs) | x == a = True
                 | otherwise = _exists a xs

mysubst :: Eq a => [a] -> [a] -> [a]
mysubst [] b = []
mysubst (x:xs) b | _exists x b == True = mysubst xs b
                 | otherwise = [x] ++ mysubst xs b

f5 :: [[a]] -> Int -> [a]
f5 a n = map(\e -> e !! n) a

main :: IO ()
  
main = do
    putStr "listnums:\n"
    print(listnums (-4)) -- [-4,-3,-2,-1,0,1]
    print(listnums 4) -- [4,3,2,1]
    print(listnums 0) -- []
    
    putStr "\nsecondlastlist:\n"
    print(secondlastlist [[1,2], [3,4], [5,6,7]]) -- [2,4,7]
    print(secondlastlist [[1,2], [3,4], [1]]) -- [2,4,1]
    
    putStr "\nmyunion:\n"
    print(myunion [1,2,3] [])  -- [1,2,3]
    print(myunion [1,2,3] [1]) -- [1,2,3,1]
    print(myunion [1,2,3] [4]) -- [1,2,3,4]
    print(myunion [] [1,2,3])  -- [1,2,3]
    print(myunion [1] [1,2,3]) -- [1,1,2,3]
    print(myunion [4] [1,2,3]) -- [4,1,2,3]
   
    putStr "\nmysubst:\n"
    print(mysubst [1,2,3,4] [1,2,3]) -- [4]
    print(mysubst [1,2,3] [])        -- [1,2,3]
    print(mysubst [1,2,3] [1,2,3,4]) -- []
    print(mysubst [] [1,2,3])        -- []
    
    putStr "\nf5:\n"
    print(f5 [[1,2,3], [4,5,6]] 0) -- [1,4]
    print(f5 [[1,2,3], [4,5,6]] 1) -- [2,5]
