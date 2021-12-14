-- 3. Программа работы с файлом предусматривает: просмотр содержимого, добавление 
-- новой информации, удаление какой-либо строки, копирование содержимого в новый 
-- файл с использованием двух видов фильтрации ( фильтр выбираем самостоятельно).
-- Имена исходных файлов задаются в командной строке, вид работы с файлом вводится 
-- с клавиатуры, также, как и дополнительная информация (напр. строка ввода). #10

import System.Environment
import System.Directory
import System.IO
import Data.Char as Char
import Data.List as List

-- Нумерует с нуля строки указанного файла
view :: String -> IO ()  
view filepath = do  
    contents <- readFile filepath
    let fileLines = zipWith (\n line -> show n ++ ". " ++ line) [0..] (lines contents)
    putStr $ unlines fileLines``

-- Добавляет строку в конец файла
add :: [String] -> IO ()  ``
add [filepath, newline] = appendFile filepath $ newline ++ "\n"

-- Удаляет элемент по его индексу из списка
deleteAt l i = lft ++ rgt
               where (lft, (_:rgt)) = splitAt i l

-- Удаляет указанную строку из файла
remove :: [String] -> IO ()  
remove [filepath, linenum] = do
    contents <- readFile filepath
    let tmpFilepath = filepath ++ ".tmp"
    writeFile tmpFilepath $ unlines (deleteAt (lines contents) (read linenum))
    copyFile tmpFilepath filepath

-- Копирует файл с удалением пробелов и табуляции
filterSpaces :: [String] -> IO () 
filterSpaces [src, dest] = do
    text <- readFile src
    writeFile dest $ filter(\ch -> not (ch == ' ' || ch == '\t')) text

-- Проверка на английскую гласную
isVowel c = elem (toLower c) "aeiouy"

-- Копирует файл с удалением английских гласных букв
filterVowels :: [String] -> IO () 
filterVowels [src, dest] = do
    text <- readFile src
    writeFile dest $ filter (not.isVowel) text

main = do  
    let helpText = "Undefined command. Commands:\
    \\n  view - shows the contents of the file (view <filepath>); \
    \\n  add - appends a line to the end of the file (add <filepath> <newline>); \
    \\n  remove - removes a specific line from a file (remove <filepath> <linenum>); \
    \\n  filterSpaces - copies the file, removing spaces and tabs (filterSpaces <src> <dest>); \
    \\n  filterVowels - сopies the file with the removal of English vowels (filterVowels <src> <dest>)."

    (comand:args) <- getArgs
    case comand of
        "view" -> view (head args)
        "add" -> add args
        "remove" -> remove args
        "filterSpaces" -> filterSpaces args
        "filterVowels" -> filterVowels args
        _ -> putStr helpText