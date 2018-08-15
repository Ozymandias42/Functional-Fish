# Functional Fish

#### _This is a collection of Fish functions to make Fish more functional. This is an attempt to recreate [Functional-Bash](https://github.com/AppleFoxUser42/Functional-Bash)_

Filter(_callback_,arr[]) => results[]
```fish
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
```

Map(_callback_,arr[]) => results[]
```fish
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
```

foldr(_callback_,arr[]) => result
```fish
function foldr -a fun -a arr
  set func $argv[1]
  set res 0
  for i in $$arr
    set res ( eval $func $res $i )
  end
  echo $res
end
```

ForEach(_callback_,arr[]) => void
```fish
function forEach -a fun -a arr
    set func $argv[1]
    for i in $$arr
        eval $func $i
    end
end
```
