{-# LANGUAGE TypeApplications #-}

module Archive where

import Control.Arrow
import Data.Char
import Data.Function
import Data.List
import Data.Maybe
import Data.Bool
import Data.Bits
import Text.Printf
import qualified Data.Text.Internal.Read as DTIR

main0=interact$show.(`rem`10).foldr1(^).map read.words

main1=interact$(\(n:_:c)->let m=read n::Int;Just[_,_,s]=find(\[f,t,_]->read f<=m&&m<=read t)(words<$>c)in s).lines

main2=interact$(\[a,b]->[a-b,a+b]>>=show).map read.words

main3=interact$concat.map show.(\(x:y:_)->[(x-y),(x+y)]).map read.words

main4 = interact $ (concat . map (\xs -> (case length xs of 1 -> ""; l -> show l) ++ [head xs]) . group) . concat . tail . lines

main5 = interact $ (show . head . map head . filter (not . even . length) . group . sort . filter (/=0) . map read . words)

main6=interact$intercalate ", ".(\[xs,ys]->zipWith (\x y->concat ["(",x,", ",y,")"]) xs ys).map (map show.sort.map (read @Int).words).lines

main7=interact$concat.(>>=uncurry (replicate.read).span isDigit).words

main8=interact(\s->show$length$filter(\z->length z>1)$group$sort$words$last$lines s)

main9=putStrLn=<<pure.last.show<$>((^)<$>(read.pure.last<$>getLine)<*>(read<$>getLine))

h a=length . filter id . zipWith (==) a
g a=map (\b->((h a b * 100)`div`(length a)) > 90)
main10=interact$unlines.map (bool "fail" "pass").(g<$>head<*>drop 2).lines
-- "Your honor, my client is clearly innocent of all charges and should be released immediately\n2\nYour honor, my client is clearly innocent of all charges and should be relaesed immediately\nUour honir, my clisnt is cleerly innosent of all chargrs and shiuld be releesed innedietily"

main11=interact$return.((show=<<[1..])!!).subtract 1.read
main12=interact$pure.(([0..]>>=show)!!).read

main13=interact$head.sortOn length.group.sort.last.lines -- BAD
main14=interact$head.head.filter ((==1).length).group.sort.tail.words
-- 2 4 2 4 1
-- 1

main15=interact$show.popCount.(\c->read c::Int)

main16=interact$p16
p16 s=[last$printf"%b"$(`uncurry`(read&&&(DTIR.hexDigitToInt.last.printf"%08x".(\z->read z::Int))$s))(*)]::String
-- Given a number N, multiply it by the last character of its hexadecimal form, then print the last digit of its binary representation.
-- 142359
-- 1

-- What you want to achieve is getting the s to the end of the expression, so you can remove it, right. So you try to remove everything that is surrounding it. This might not be the best way to write it, but on way to get closer is first removing the []
-- p s=pure.last.printf"%b"$(`uncurry`(read&&&(D.hexDigitToInt.last.printf"%08x".(\z->read z::Int))$s))(*)::String
-- after that, you can remove more parantheses by applying the arguments to uncurry in their normal order
-- p s=pure.last.printf"%b".uncurry(*)$(read&&&(D.hexDigitToInt.last.printf"%08x".(\z->read z::Int))$s)::String
-- and then your basically done.
-- p=pure.last.printf"%b".uncurry(*).(read&&&(D.hexDigitToInt.last.printf"%08x".(\z->read z::Int)))

main17=interact$p17
p17 s=r
 where
  l=lines s
  x=words<$>(init$tail$l)
  t=last$l
  r=show$(x,t)

-- p "4\nShanghai 25\nMadrid 6\nBangkok 10\nManila 13\nMa"
-- 19

main18=interact$show.c18.read
c18 n=any(\i->i^i+i==n)[1..n]

c18_2 n=or[i^i+i==n|i<-[1..n]]

-- 6
-- True

main19=interact$p19
p19 s=show$product$sum.(digitToInt<$>)<$>words s
p19_2=show.product.map(sum.map digitToInt).words

-- Given a string of space separated numbers, calculate the product of all the sums of the digits of each number.
-- e.g. given "3 32 12 50", the answer would be (3)*(3+2)*(1+2)*(5+0)=3*5*3*5=225, so you would output 225

-- p "3 32 12 50"
-- 225

main20=interact$p20
p20 s=show$f20<$>(tail$lines s)
f20 s=d20<$>read<$>words s::[Int]
d20 [a,b]=min (y-x) (abs $ y-100+x)
  where
   x=min a b
   y=max a b

main20_2=interact$unlines.map (show.(\[a,b]->min (mod (a-b) 100) (mod (b-a) 100)).map read.words).tail.lines

-- p "3\n3 7\n0 99\n30 40"

-- 4
-- 1
-- 10


main21=interact$p21
p21 s=show$drop=<<subtract 2.length$s
d21="JFMAMJJASONDJF"
f21=drop=<<subtract 2.length

main21_2=interact$f21_2$cycle "JFMAMJJASOND"
f21_2 (y:ys) (x:xs)
 | x == y=f21_2 ys xs
 | True     =f21_2 ys (x:xs)
f21_2 (y:_) []=pure y

main21_3=interact$pure.head.foldl(\x y->tail$dropWhile(/=y)x)(cycle"JFMAMJJASOND")

-- JFMAMJJASON
-- D

-- main22=interact$p22
-- p22 s=show$c22$read<$>lines s
-- c22 [t,r]=(\i->(/10)$round$i*10)<$>[r * cos a, r * sin a]
--  where a=pi*t/180
-- You have to convert Polar coordinates (θ, r) to normal (x, y) coordinates.
-- One line: x, y separated by ", " (comma and space)
-- The x and y coordinates will have to be rounded of to one decimal place even if there are no decimals.

-- p "30\n12"
-- 10.4, 6.0

main22_2=interact$intercalate", ".map(printf"%0.1f").(\[a,r]->let a'=(a::Double)*pi/180in[r*cos a',r*sin a']).map read.words

main23=interact$unlines.(unwords.reverse<$>).transpose.map words.drop 2.lines

-- Take an NxM grid of numbers and return the MxN grid that results from rotating it 90 degrees clockwise.

-- p "2\n3\n1 2 3\n4 5 6"
-- 4 1
-- 5 2
-- 6 3

main24=interact$p24
p24 s=show$product$map signum$z$(\c->read c::Int)<$>words s
 where z [a,b]=enumFromTo a b

-- p "-9 -6"
-- 1

main25=interact$show.product.map signum.z25.(read<$>).words where z25[a,b]=enumFromTo a b

main26=interact$unlines.group.sort.map toLower.filter isAlpha.last.lines

-- p "10\nabcabcabcb"

-- aaa
-- bbbb
-- ccc

main27=interact$p27
p27 s=show$zip a (concat$repeat b)
 where(a,b)=(!!2)&&&(!!3)$lines s

-- p "9\n5\n2 29 18 19 17 6 15 27 15\nAPPLE"

-- CODINGAME

main28=interact$p28
p28 s=show$y
 where
  x=words s
  y=filter((=='c').head)x
  z=if null y then s++"covfefe"else""

u=unwords
g28_2 w i|i==w="covfefe"|1<2=i
k28_2 i|elem"covfefe"i=u i|1<2=(u i)++"covfefe"
h28_2 l=last$[" "]++[w|w<-l,(length w)==maximum(map length l)]
f28_2 i=k28_2$map(g28_2$h28_2(filter(\x->head x=='c')i))i
main28_2=interact$f28_2.words

-- Your task is to replace the longest word starting by c in a tweet by covfefe.
-- If no words starts by c, put covfefe at the end. If multiple words start by c and have the same length, choose the last to appear in the sentence.

-- p "I have good coverage of spray tan"

-- I have good covfefe of spray tan

-- main29=interact$p29
-- p29 s=show$unlines$map (\s->sort$filter (\c ->c `elem` "aeiouAEIOU") s)$tail$lines s

-- import Data.Maybe
-- import Data.List
-- import qualified Data.List.NonEmpty as N
-- import Data.Char
-- main=interact$unlines.map(fromMaybe"NONE".fmap(pure.N.head).N.nonEmpty.sortOn toLower.filter(`elem`"aeiouAEIOU")).tail.lines

-- p "3\nPLOP\nXPLDR\nLOLILOL"

-- O
-- NONE
-- I

main30=interact$p30
p30 s=head$last$sortOn length$group$sort$subsequences s

main31=interact$p31
p31 s=y
 where
  [a,b]=lines s
  x=take(length b)$concat$repeat a
  y=map(\c->b!!read [c])x

-- p "231450\n state below"
-- taste elbow

-- import qualified Data.Text as T
-- main=interact$p
-- p s=show$T.zipWith (T.append) x y
--  where
--   (x:y)=T.splitOn " " s

-- import Data.List.Split
-- g w(l,i)=[w!!i]++l
-- f(i:j)=unwords$map(g i)$zip j[0..]
-- main=interact$f.(splitOn" ")

-- p "Tiam his s  essage"
-- This is a message


-- import Data.List
-- w=words
-- g n(i,j)=div(j*100)n==i
-- f[n,l]=[i|(i,j)<-filter(g(read n))[(read v,length$filter(==v)$w l)|v<-(nub(w l))]]
-- main=interact$show.sum.f.lines


main32=interact$p32
p32 s=if any(`isInfixOf`(map read$nub$words s))[[1..4],[2..5],[3..6]]then"true"else"false"

-- p "3 4 4 5 6"
-- true

-- import Data.List
-- main=interact$p
-- p s=show$(m++concat x++concat xs)
--  where
--   (m:l:_:xs)=lines s
--   x=splitOn ',' l

-- p "10\nGum,Chips,Soda\n4\nChips,2\nIce Cream,5\nGum,1\nSoda,3"
-- true
-- 4

-- main=interact$p
-- p s=show$r
--  where
--   [w,p]=lines s
--   r=foldr (\a (w,r) -> if a`elem`("xX"::String)
--     then (tail w,head w:r)
--     else (w, r)) (w,"") p

-- p "sAmMyJr\nXxxxx, Xx."
-- Sammy, Jr.


-- main=interact$p
-- p s=show$r
--  where
--   (m:l:x)=lines s
--   r=(+1)$(*(read l))$(+1)$(`div`read m)$sum$map read x

-- p "50\n5\n30\n10\n5\n0\n3"
-- 6

-- main=interact$p
-- p s=show$h++concat l
--  where
--   (_:_:x)=lines s
--   (h:l)=reverse x

-- p "6\n2\nConnor HATES Miles\nMarion HATES Connor\nNeil Troy Marion Connor Miles Martin"
-- false

-- main=interact$p
-- p s=show$r
--  where
--   [h,d,n]=map read$lines s::[Int]
--   r=takeWhile 5$map x [1..]
--   x n=foldr (+) 0$concat$take n$repeat[d,n]

-- p "10\n3\n2"
-- 8

main33=interact$p33
p33 s=fromJust$find(\z->((==)`on`(sort.map toLower)) z w)l
 where(_:w:l)=lines s

-- p "3\nBannaa\nFive\nBanana\nTree"
-- Banana

main34=interact$unwords.map(\w->if even$length$filter isAlpha w then map toUpper w else w).words

mainmain34_2=interact$unwords.(map f34_2).words
f34_2 i|rem(length(filter isAlpha i))2>0=i|1<2=map toUpper i

-- p "I don't want you anymore! You are stressful."
-- I DON'T WANT you anymore! You are stressful.


main35=interact$p35
p35 s=unwords$map show$take(read s)$map f35[1..]
f35 1=1
f35 2=1
f35 n=f35(f35(n-1))+f35(n-f35(n-1))

-- a(1) = 1.
-- a(2) = 1.
-- a(n) = a(a(n - 1)) + a(n - a(n - 1)), for n > 2.


main36=interact$p36
p36 s=(show$sum$zipWith(\a b->if a==b then 0 else 1)x y)++" "++(show$3-(length$filter(=='.')s))where[x,y]=map (words.filter(\c->isAlpha c||c==' ')) [s,"I am not a good speller. Sometimes I mix up the spelling of words and sometimes I even forget to put periods. Please count the number of words I have misspelled and the number of periods I have missed."]

-- p "i am not a good speller sometimes i mix up the spelling of words and sometimes i even forget to put periods please count the number of words i have misspelled and the number of periods i have missed"
-- 7 3

main37=interact$f37.lines
f37[n,c,s]|odd(read n)=(p37(read n)c s)>>=(++"\n")|1<2=(reverse(p37(read n +1)c s))>>=(++"\n")
p37 n c s=[(([n-i-1,n-i-3..0])>>s)++(([1..i])>>c)++(([n-i-1,n-i-3..0])>>s)|i<-[1,3..n]]


-- main38=interact$p38
-- p38 s=show$r
--  where
--   l=map read$words s::[Int]
--   e=length l
--   r=if odd$e
--    then l!!(if odd e then e `div` 2 + 1 else e `div` 2)
--    else (fromIntegral$sum l)/(fromIntegral$e)

-- p "230 20 35 54 19 99"
-- 77


-- If the list contains even number of integers, return the average.
-- If the list contains odd number of integers, return the median.

main39=interact$p39
p39 s=show$r
 where
  l=reverse$map (read.(:[])) s::[Int]
  p=take 3$map ((-2)^)[0..]
  r=sum$zipWith (*) l p

-- p "11000101101"
-- 477

main40=interact$p40
p40 s=show$x
 where
  (l:_:d)=lines s
  x=map(fmap read.words)$d::[[Int]]
  r=foldr (\a b -> b) [1..read l] x

-- p "1000\n5\n0 4\n4 8\n1 5\n2 6\n3 7"
-- 992


main41=interact$p41
p41 s=c:" "++show l
 where
  a=sortOn length$group$s
  x=last$a
  l=length x
  b=map head$filter((==l).length)a
  c=fromJust$find(`elem`b)s


main42=interact$p42
p42 s=show$a$read d
 where
  [x,y,c,d]=lines s
  a 1 = read x
  a 2 = read y
  a n = (o$head c) (a (n-2)) (a (n-1))
  o '+'=(+)
  o '-'=(-)
  o '*'=(*)
  o '/'=(/)

-- p "-7\n19\n-\n36"
-- 563510987

-- There is a sequence a. The 1st input specifies a1, and the 2nd input specifies a2. Given an operator (the 3rd input), compute k+2th term in a, where a_n = a_{n-2} operator a_{n-1} (i.e. apply operator k times in the sequence). k is given as input 4.

main43=interact$p43
p43 s=unlines$r
 where
  x=tail$lines s
  r=transpose x

-- p "5 3\n.---.\n|---|\n.---."

main44=interact$p44
p44 s=show$r
 where
  x=read s::Int
  (d,t)=x`divMod`86400000
  (h,u)=t`divMod`3600000
  (m,z)=u`divMod`60000
  r=unwords$map(\(c,g)->show g++[c])$reverse$zip "zmhd" [z,m,h,d]



-- p "12000000"

-- 3h 20m

-- 0d 0h 0m 0s

main45=interact$p45
p45 s=show$f$read n
 where
  [x,n]=lines s
  [t,u]=map read$words x
  g=(map f[0..]!!)
  f 1=t
  f 2=u
  f m=g(m-1)+g(m-2)

-- p "0 1\n3"
-- 1

main46=interact$p46
p46 s=show$y
 where
  (_:x)=lines s
  y=fromJust$find ((=='A').head) x


-- p "4\nA------X\n*-+-+-+-+-+-+-#\nX====*\n#_____Z"
-- A------X====*-+-+-+-+-+-+-#_____Z


main47=interact$p47
p47 s=if (s =="0" || s=="1") then "NONE" else  r
 where
  i=read s
  r=show$fromJust$find (\n -> i `mod` n == 0) primes
  primes = map head $ iterate (\(x:xs) -> [y | y<-xs, y `mod` x /= 0 ]) [2..]

-- p "15"


-- main48=interact$p48
-- p48 s=map toLower$show$x
--  where
--   [o,a,b,r]=lines s
--   x=zipWith (\(j, k) -> (f48 o) j k) (map g48 a) (map g48 b)

g48 '1' = True
g48 '0' = False

f48 "AND"=(&&)
f48 "OR"=(||)
f48 "XOR"=(/=)

-- p "AND\n1\n0\n1"



main49=interact$p49
p49 s=show$g(n`mod`1000000007)
 where
  [n,a,b,c]=read<$>words s::[Integer]
  g :: Integer -> Integer
  g=genericIndex (map f[0..])
  f :: Integer -> Integer
  f 0=a
  f 1=b
  f 2=c
  f m=g(m-1)+g(m-2)+g(m-3)


-- p "3 4 5 6"
-- 15


-- g=(map f[0..]!!)
-- f 1=t
-- f 2=u
-- f m=g(m-1)+g(m-2)


main50=interact$p50
p50 s=x
 where
  r=length $ filter (`elem`("aeiou"::String)) s
  x=unlines$replicate r s

-- p ""

main51=interact$p51
p51 s=show$x
 where
  x=foldr (\a (t, u) -> f a t u) (0, "") (reverse s)
  f '.' t u=(t, u ++ [chr t])
  f '+' t u=(t+1, u)
  f '-' t u=(t-1, u)

-- p "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++.+++++++..+++."

main52=interact$concat.map g.group.map f52.words
 where
  g z =let l=length z in head z++if l>1 then show l else""

f52"up"="^"
f52"down"="v"
f52"left"="<"
f52"right"=">"


-- p "right right right up up up"
-- >3^3

f53(x:y:xs)=[x,y]:f53 xs
f53[]=[]
main53=interact$map(chr.read.("0x"++)).f53.concat.transpose.f53


g54[x,n]=product[(x-n+1)..x]
main54=interact$show.g54.map read.words

-- main=interact$p
-- p s=t
--  where
--   [c,z]=lines s
--   t=concat$map (\g->if head g==head c then show$length g else g)$group z

-- p "l\nHello world."
-- He2o wor1d.

main55=interact$f55.map read.words
f55 x|or[a>sum[b|b<-x,a/=b]|a<-x]="false"|0<1="true"

-- prime
f56 n=mod(product[1..n-1]^2)n>0

-- fibonacci
fib = (map fib' [0..] !!)
     where fib' 1 = 1
           fib' 2 = 1
           fib' n = fib (n-2) + fib (n-1)

-- list of bits [Int] to binary
f57 xs=foldl1((+).(2*)) xs