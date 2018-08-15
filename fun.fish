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

function forEach -a fun -a arr
    set func $argv[1]
    for i in $$arr
        eval $func $i
    end
end


#function isEven
#    set erg (math "$argv[1] % 2")
#    if  test $erg -eq 0 
#        echo 0
#    else
#        echo 1
#    end
#end
#
#function timestwo
#    set res (math "$argv[1] * 2")
#    echo $res
#end
#
##Test lines
#set bob 7 8 2
#map timestwo bob
#forEach isEven bob
