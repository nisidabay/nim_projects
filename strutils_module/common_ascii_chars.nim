# Sets off commonly used ASCII characters
import strutils

echo Whitespace # {' ', '\t', '\v', '\r', '\l', '\f'}
echo Letters # {'A'..'Z', 'a'..'z'}
echo Digits # {'0'..'9'}
echo HexDigits # {'0'..'9', 'A'..'F', 'a'..'f'}
echo IdentChars # Letters + Digits + {'_'}
echo IdentStartChars # Letters + {'_'}
echo Newlines # {'\r', '\n'}
echo PrintableChars # Letters + Digits + Punctuation + Whitespace
echo AllChars # {'\x00'..'\xFF'}

