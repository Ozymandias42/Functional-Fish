#!/usr/bin/env fish

#Important: -a fun and -arr creates named parameters
#this allows to use dereferencing syntax $$var to correctly access supplied arrays
#IMPORTANT: Function expects a function of the form f(x)=>bool for fun.
#See: predicate function
function filter -a fun -a arr
      set func $argv[1]
      set ret
      set inc 1
      
      for i in $$arr
          if test ( eval $func $i ) -eq 0
              set ret[$inc] $i
              set inc (math "$inc+1")
          end
      end
      echo $ret
end

function map -a fun -a arr
    set func $argv[1]
    set res
    set inc 1
    for i in $$arr
        set res[$inc] ( eval $func $i )
        set inc (math "$inc+1")
    end
    echo $res
end

function foldr -a fun -a arr
  set func $argv[1]
  set res 0
  for i in $$arr
    set res ( eval $func $res $i )
  end
  echo $res
end

function unfold
  set func $argv[1]
  if set -q argv[3]
    set init $argv[2]
    set limit $argv[3]
  else
    set init 0
    set limit $argv[2]
  end
  if set -q argv[4]
    set step $argv[4]
  else
    set step 1
  end
  for i in (seq $init $step $limit)
    set out $out (eval $func $i)
  end
  echo $out
end

function zip -a arr1 -a arr2
  if expr (count $$arr1) '>' (count $$arr2)
    set arrlength (count $$arr1)
  else
    set arrlength (count $$arr2)
  end
  if expr (count $$arr1) = (count $$arr2)
    set use 1
  end

  function next -a lastindex -a arr
    if expr $lastindex != (count $$arr)
      echo (math $lastindex+1)
    else
      next (math $lastindex-(count $$arr)) arr
    end
  end

  set index1 1
  set index2 1
  set index 1
  set alice $$arr1
  set bob $$arr2
  set out (seq $arrlength )

  while expr $index != $arrlength
    set out[$index] "$alice[$index1] $bob[$index2]"
    set index1 (next $index alice)
    set index2 (next $index bob)
    set index (math $index+1)
  end
  echo $out
end

function forEach -a fun -a arr
    set func $argv[1]
    for i in $$arr
        eval $func $i
    end
end

function chain -a funcs -a arr
  set res $$arr
  for i in $$funcs
    for a in (seq (count $$arr))
      set res[$a] (eval $i $res[$a] )
    end
  end
  echo $res
end
