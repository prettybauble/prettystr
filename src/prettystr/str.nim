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
    return cast[ptr T](unsafeaddr src[pos])[]
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

func swap*(val: uint16): uint16 =
  ## Splits uint16 to two uint8 parts and swaps it.
  let tmp = cast[array[2, uint8]](val)
  (uint16(tmp[0]) shl 8) or uint16(tmp[1])

func swap*(val: uint32): uint32 =
  ## Splits uint32 to two uint16 parts and swaps it.
  let tmp = cast[array[2, uint16]](val)
  (uint32(swap(tmp[0])) shl 16) or swap(tmp[1])

func swap*(val: uint64): uint64 =
  ## Splits uint64 to two uint32 parts and swaps it.
  let tmp = cast[array[2, uint32]](val)
  (uint64(swap(tmp[0])) shl 32) or swap(tmp[1])

func swap*(val: int16): int16 =
  cast[int16](swap(cast[uint16](val)))
func swap*(val: int32): int32 =
  cast[int32](swap(uint32(val)))
func swap*(val: int64): int64 =
  cast[int64](swap(cast[uint64](val)))

{.pop.}
