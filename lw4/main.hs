import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.Map as Map
import qualified Data.Char as Char
import Lw4lib

main = do
    putStr "List.group:\n"
    
    print $ List.group [1,1,2,2,2,3,3,2,2] -- [[1,1],[2,2,2],[3,3],[2,2]]
    print $ list_group [1,1,2,2,2,3,3,2,2] -- [[1,1],[2,2,2],[3,3],[2,2]]
    
    print $ List.group [1,2,1,2] -- [[1],[2],[1],[2]]
    print $ list_group [1,2,1,2] -- [[1],[2],[1],[2]]
    
    print $ List.group "aaabbcca" -- ["aaa","bb","cc","a"]
    print $ list_group "aaabbcca" -- ["aaa","bb","cc","a"]
    
    print $ List.group [1,1] -- [[1,1]]
    print $ list_group [1,1] -- [[1,1]]
    
    -- print $ List.group [] -- error require not empty list
    -- print $ list_group [] -- error require not empty list


    putStr "\nChar.isHexDigit:\n"
    print $ Char.isHexDigit 'A' -- True
    print $ char_isHexDigit 'A' -- True
    
    print $ Char.isHexDigit 'a' -- True
    print $ char_isHexDigit 'a' -- True
    
    print $ Char.isHexDigit '0' -- True
    print $ char_isHexDigit '0' -- True
    
    print $ Char.isHexDigit 'f' -- True
    print $ char_isHexDigit 'f' -- True
    
    print $ Char.isHexDigit 'g' -- False
    print $ char_isHexDigit 'g' -- True
    
    -- print $ Char.isHexDigit 1 -- error input type
    -- print $ char_isHexDigit 1 -- error input type
    
    
    putStr "\nMap.null:\n"
    print $ Map.null Map.empty -- True
    print $ map_null Map.empty -- True
    
    print $ Map.null $ Map.fromList [(2,3),(5,5)] -- False
    print $ map_null $ Map.fromList [(2,3),(5,5)] -- False
    
    print $ Map.null $ Map.fromList [(2,3),(2,5)] -- False
    print $ map_null $ Map.fromList [(2,3),(2,5)] -- False
    
    -- print $ Map.null [] -- error input type
    -- print $ map_null [] -- error input type
    
    
    putStr "\nSet.insert:\n"
    print $ Set.insert 3 $ Set.fromList [2,4,1] -- fromList [1,2,3,4]
    print $ set_insert 3 $ Set.fromList [2,4,1] -- fromList [1,2,3,4]
    
    print $ Set.insert '1' $ Set.fromList "12" -- fromList [1,2]
    print $ set_insert '1' $ Set.fromList "12" -- fromList [1,2]
    
    print $ Set.insert '3' $ Set.fromList "12" -- fromList [1,2,3]
    print $ set_insert '3' $ Set.fromList "12" -- fromList [1,2,3]
    
    print $ Set.insert 3 $ Set.empty -- fromList [3]
    print $ set_insert 3 $ Set.empty -- fromList [3]
    
    -- print $ Set.insert '3' $ Set.fromList [2,4,1] -- error input type
    -- print $ set_insert '3' $ Set.fromList [2,4,1] -- error input type
    
    
    putStr "\nList.splitAt:\n"
    print $ List.splitAt 3 "heymaks" -- ("hey","maks") 
    print $ list_splitAt 3 "heymaks" -- ("hey","maks") 
    
    print $ List.splitAt 3 [1,2,3,4,5] -- ([1,2,3],[4,5])
    print $ list_splitAt 3 [1,2,3,4,5] -- ([1,2,3],[4,5])
    
    print $ List.splitAt 5 [1,2,3] -- ([1,2,3],[])
    print $ list_splitAt 5 [1,2,3] -- ([1,2,3],[])
    
    -- print $ List.splitAt -1 [1,2,3] -- error input arg
    -- print $ list_splitAt -1 [1,2,3] -- error input arg
    
    