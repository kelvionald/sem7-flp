import System.IO
import Char
import qualified Data.List as List
import qualified Data.Map as Map

-- 1. Напишите функцию elemIndices :: Eq a => a -> [a] -> [Int], 
-- которая находит, под какими индексами в списке встречается заданный элемент #5
elemIndicesHelp :: Eq a => a -> [a] -> Int -> [Int] -> [Int]
elemIndicesHelp el [] pos indexes = indexes
elemIndicesHelp el (l:ls) pos indexes | l == el = elemIndicesHelp el ls (pos + 1) (indexes ++ [pos])
                                      | otherwise = elemIndicesHelp el ls (pos + 1) indexes

elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices el l = elemIndicesHelp el l 0 []

-- 2.Напишите функцию unevenHandWritingMy :: String-> String, которая берет строку
-- и возвращает ее же, но каждая третья буква  должна стать прописной, если была строчной и наоборот. #5
unevenHandWritingMy :: String -> String
unevenHandWritingMy s = take 2 s ++ [ch2] ++ drop 3 s
                        where ch = s !! 2
                              ch2 | isLower ch = toUpper ch
                                  | otherwise = toLower ch

-- 3.Напишите функцию, строящую список подсписков чисел: в первом подсписке будут 
-- степени единицы, во втором степени двойки, в третьем - тройки и так далее:
-- [[1,1,1,...],[2,4,8,...],[3,9,27 ,...],...]
-- Количество элементов в подсписках, а также максимальное число, участвующее в 
-- образовании подсписков степеней числа, являются параметрами функции.
-- Для предложенного примера [[1,1],[2,4],[3,9 ],[4,16]] количество элементов в 
-- подсписках= 2, мак число=4.
makeDegreeList :: Int -> [Int] -> [Int] -> [Int]
makeDegreeList base [] l = l
makeDegreeList base (d:ds) l = makeDegreeList base ds (l ++ [base ^ d])

makeDegreeListListHelp aInner [] result = result
makeDegreeListListHelp aInner (o:os) result = makeDegreeListListHelp aInner os (result ++ [makeDegreeList o aInner []])

makeDegreeListList :: Int -> Int -> [[Int]]
makeDegreeListList nInner nOuter = makeDegreeListListHelp [1..nInner] [1..nOuter] []

-- 4. Напишите функцию transpose :: [[a]]-> [[a]], которая берет список списков 
-- и транспонирует столбцы и строки.
-- Например, transpose [[1,2,3],[4,5,6]] ==[[1,4],[2,5],[3,6]].
-- #5
transpose :: [[a]] -> [[a]]
transpose [] = []
transpose ([]:xss) = transpose xss
transpose ((x:xs):xss) = [[x] ++ tailHeads] ++ (transpose ([xs] ++ tailTails))
                         where tailHeads = map head xss
                               tailTails = map tail xss

-- 5 . Напишите функцию, которая читает входной текстовый файл и выводит в выходной файл пары 
-- (слово:число), где слово - есть каждое уникальное слово файла, а число - количество 
-- вхождений этого слова. Пары должны быть отсортированы по убыванию чисел. #5
wordFrequencyHelp :: [[String]] -> Map.Map String Int -> Map.Map String Int
wordFrequencyHelp [] result = result
wordFrequencyHelp (g:gs) result = wordFrequencyHelp gs (Map.insert (head g) (length g) result)

wordFrequency :: String -> String -> IO ()
wordFrequency src dest = do
    content <- readFile src
    let groups = List.group $ List.sort (words content)
    --print groups
    let groupsMap = Map.toList $ wordFrequencyHelp groups Map.empty
    --print groupsMap
    let sortedGroupsMap = List.sortBy (\(_,a) (_,b) -> compare b a) groupsMap
    --print sortedGroupsMap
    let sortedGroupsMapStr = map (\(a,b) -> a ++ ":" ++ (show b)) sortedGroupsMap
    --print sortedGroupsMapStr
    writeFile dest $ unlines sortedGroupsMapStr

main = do
    putStr "1. elemIndices \n"
    print $ elemIndices 1 [1, 2, 3, 1, 4]
    print $ elemIndices 1 []
    print $ elemIndices 3 [1,2,3,4]
    print $ elemIndices 3 [1,3,2,3,3,4,3]
    print $ elemIndices 'a' "abbacca"
    
    putStr "\n"
    putStr "2. unevenHandWritingMy \n"
    print $ unevenHandWritingMy "Hello World!"
    print $ unevenHandWritingMy "ABCD"
    print $ unevenHandWritingMy "123456"
    
    putStr "\n"
    putStr "3. makeDegreeListList \n"
    print $ makeDegreeListList 2 4
    print $ makeDegreeListList 2 0
    print $ makeDegreeListList 0 4
    print $ makeDegreeListList 3 3
    
    putStr "\n"
    putStr "4. transpose \n"
    print $ transpose [[1,2,3],[4,5,6]]
    print $ transpose [[1,2],[3,4]]
    
    putStr "\n"
    putStr "5. wordFrequency \n"
    writeFile "src.txt" " 1 world hello hello hello i  \n i 2"
    wordFrequency "src.txt" "dest.txt"
    text <- readFile "dest.txt"
    putStr text

    
    
    
    