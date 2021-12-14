module Lw4lib (
	list_group,
	char_isHexDigit,
	map_null,
	set_insert,
	list_splitAt
) where

import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.Map as Map
import qualified Data.Char as Char

{- Вспомогательная функция принимает список группируемых элементов и список уже сгруппированных 
   элементов, группирует оставшиеся соседние элементы в подсписки, если они равны -}
_list_group_helper :: Eq a => [a] -> [[a]] -> [[a]]
_list_group_helper [] n_l = n_l
_list_group_helper (x:xs) n_l | last(last(n_l)) == x = _list_group_helper xs (init(n_l) ++ [last(n_l) ++ [x]])
                              | otherwise = _list_group_helper xs (n_l ++ [[x]])

{- Принимает список и группирует соседние элементы в подсписки, если они равны -}
list_group :: Eq a => [a] -> [[a]]
list_group (x:xs) = _list_group_helper xs [[x]]

{- Проверяет входной символ на шестнадцатеричную цифру -}
char_isHexDigit :: Char -> Bool
char_isHexDigit ch = elem (Char.toLower ch) "0123456789abcdef"

{- Проверяет входной словарь на пустоту -}
map_null :: Map.Map k v -> Bool
map_null m = length(Map.elems m) == 0

{- Вставляет входной элемент во входное множество -}
set_insert :: (Ord a, Eq a) => a -> Set.Set a -> Set.Set a
set_insert el s = Set.fromList $ List.insert el $ Set.toList s

{- Принимает число и список. Затем он разбивает список на это количество элементов, 
   возвращая два результирующих списка в виде кортежа -}
list_splitAt :: Int -> [a] -> ([a],[a])
list_splitAt n l = (take n l, drop n l)
