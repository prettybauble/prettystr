# author: Ethosa
import exceptions


{.push inline.}

func add*(src: var string, val: SomeInteger) =
  ## Adds the number to the string.
  src.setLen(src.len() + sizeof(val))
  cast[ptr typeof(val)](addr src[src.len() - sizeof(val)])[] = val


func insert*(src: var string, pos: int, val: SomeInteger) =
  ## Inserts the number to the string.
  let size = sizeof(val)
  src.setLen(src.len() + size)
  for i in countdown(src.len()-1, pos+size):
    src[i] = src[i-size]
  cast[ptr typeof(val)](addr src[pos])[] = val


func read*[T](src: string, pos: int): T =
  ## Reads T from string. Can any integer.
  if T is SomeInteger:
    cast[ptr T](unsafeaddr src[pos])[]
  else:
    raise newException(
      ReadFromStringError,
      "Only integer can readed"
    )


func write*(src: var string, pos: int, val: SomeInteger) =
  ## Writes the number to the specified position in the string.
  cast[ptr typeof(val)](addr src[pos])[] = val

func pop*(src: var string, pos: int = -1): char {.discardable.} =
  ## Pops the char at specified position and returns this char.
  if pos < 0:
    let
      p = -pos
      length = src.len()
    result = src[^p]
    src = src[0..^(p+1)] & src[^(p-1)..^1]
  else:
    result = src[pos]
    src = src[0..pos-1] & src[pos+1..^1]

{.pop.}
