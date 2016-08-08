A Collection of auxiliary and convenience functions, mostly
dealing with Word32 values.

\begin{code}
module Aux where
import Data.Word
import Data.Bits
import Debug.Trace
import Control.Exception.Base (assert)
import qualified Data.ByteString as BS

strBin :: (Integral a) => [Char] -> a
strBin bitstring =
  rbin (reverse $ fmap digitize bitstring) 0
  where rbin [] _ = 0
        rbin (b:bs) e = (b * (2)^e) + rbin bs (e+1)
        digitize c
          | c == '0' = 0
          | c == '1' = 1
          | otherwise = error "Invalid bitstring"

binStr :: (Integral a) => a -> [Char]
binStr w =
  (reverse . rbinstr) w
  where rbinstr 0 = ""
        rbinstr n = (if (rem n 2) == 0 then '0' else '1') : (rbinstr (quot n 2))

mask :: (Integral a, Bits a) => a -> Int -> Int -> a
mask w low high
  | low > high = error "Lower bound higher than upper bound"
  | low < 0 || high > 32 = error "Bit range out of bounds"
  | otherwise  = (highmask .&. w) `shiftR` low
  where highmask :: (Integral a) => a
        highmask = (2^high)-1

word32LEBytes :: Word32 -> [Word8]
word32LEBytes wrd = wrec wrd 4
  where wrec :: Word32 -> Int -> [Word8]
        wrec _ 0 = []
        wrec w n = (fromIntegral (0xFF .&. w)) :
                   (wrec (shiftR w 8) (n - 1))

w2bs :: [Word32] -> BS.ByteString
w2bs ws = (BS.pack . concat . map word32LEBytes) ws

\end{code}