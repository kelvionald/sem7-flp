-- 2. Скопировать информацию из одного файла в другой, заменив знаки 
-- пунктуации заданным с клавиатуры символом. Имена файлов указываются 
-- в командной строке. #5

import System.IO
import Data.Char
import System.Environment

main = do
    [input, output, symbol] <- getArgs
    
    text <- readFile input
    writeFile output (map(\ch -> if isPunctuation ch then symbol !! 0 else ch) text)
    