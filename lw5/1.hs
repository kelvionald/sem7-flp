-- 1. Вывести на экран сформированный список, данные для которого вводятся 
-- с клавиатуры: начальное значение, количество элементов, кратность.
-- Например- [14,21,28] 3 элемента списка, начинающиеся с 14, кратные 7. #2

import System.IO

readInt :: IO Int
readInt = readLn
          
formList :: Int -> Int -> Int -> [Int]
formList a n m = take n [a, a + m ..]

main = do
    print "Начальное значение:"
    a <- readInt
    
    print "Количество элементов:"
    n <- readInt
    
    print "Кратность:"
    m <- readInt
    
    print $ formList a n m