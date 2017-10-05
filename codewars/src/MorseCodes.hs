import Data.List
import Data.Char
import Data.Map.Strict ((!))
import qualified Data.Map.Strict as Map

morseCodes = Map.fromList [
        ("\·\·\·\·", "H"),
        ("·", "E"),
        ("−·−−", "Y"),
        ("·−−−", "J"),
        ("··−", "U"),
        ("−··", "D"),
        ("x", "D")
    ]

splitBy :: String -> String -> [String] -> [String]
splitBy delimeter "" result = result
splitBy delimeter str result =
    if take (length delimeter) str == delimeter
    then splitBy delimeter (drop (length delimeter) str) (result ++ [""])
    else splitBy delimeter (tail str) (if length result == 0 then [[head str]] else (init result) ++ ([(last result) ++ [head str]]))

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

main = print $ unwords . filter (not . null) . map (concatMap (morseCodes!) . words) $ splitBy "   " (trim " .... . -.--   .--- ..- -.. . ") []
