import System.IO
main :: IO ()

--параметром является число N. функция генерирует список из N элементов, начиная с указанного элемента N
do_my_list :: Int-> [Int]
do_my_list n = [n..n+n-1]

--функция перестановки местами соседних элементов списка L 
oddEven :: [a]-> [a]
oddEven [] = []
oddEven l
    | lenMod2 == 0 || lenMod2 == 1 && lenL > 1 = [head(tail(l))] ++ [head(l)] ++ oddEven(tail(tail(l)))
    | otherwise = l
    where
        lenL = length(l)
        lenMod2 = lenL `mod` 2
        
-- функция включения в список L заданного атома А на определенную позицию n
insert :: [a] -> a -> Int -> [a]
insert l a n = take n l ++ [a] ++ drop n l

-- функция сложения элементов двух списков. Возвращает список , составленный из сумм элементов списков - параметров L1, L2. Учесть, что переданные списки могут быть разной длины.
listSumm :: (Num a) => [a] -> [a] -> [a]
listSumm l1 [] = l1
listSumm [] l2 = l2
listSumm (x:xs) (y:ys) = (x + y) : listSumm xs ys

positionHelper :: (Eq a) => [a] -> a -> Int -> Int
positionHelper [] _ _ = -1
positionHelper (x:xs) y n 
    | x == y = n
    | otherwise = positionHelper xs y (n + 1)

position :: (Eq a) => [a] -> a -> Int
position l a = positionHelper l a 0

f5 :: Int -> Int
f5 n = sum [1..n]

f6 :: Int -> Int
f6 n = sum(map(\x -> n - x) [1..n])

main = do
    putStr "do_my_list:\n"
    print(do_my_list 5) -- [5,6,7,8,9]
    print(do_my_list 1) -- [1]
    print(do_my_list 0) -- []

    putStr "\noddEven:\n"
    print(oddEven (do_my_list 5)) -- [6,5,8,7,9]
    print(oddEven (do_my_list 4)) -- [5,4,7,6]
    print(oddEven (do_my_list 0)) -- []
       
    putStr "\ninsert:\n"
    print (insert [1, 2, 3] 0 0) -- [0, 1, 2, 3]
    print (insert [1, 2, 3] 4 3) -- [1, 2, 3, 4]
    print (insert [] 3 0) -- [3]
    
    putStr "\nlistSumm:\n"
    print(listSumm [1,2,3,4] [1,1]) -- [2,3,3,4]
    print(listSumm [1,2] [1,1]) -- [2,3]
    print(listSumm [1] []) -- [1]
    print(listSumm [] []) -- []
    
    putStr "\nposition:\n"
    print(position [1,2,3,4] 7) -- -1
    print(position [1,2,3,4] 3) -- 2
    print(position [] 3) -- -1
    
    putStr "\n5. F=:\n"
    print(f5 4) -- 10
    print(f5 3) -- 6
    
    putStr "\n6. F=:\n"
    print(f6 4) -- 6
    print(f6 3) -- 3
    
    