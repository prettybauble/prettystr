# author: Ethosa
## This module describes all exceptions.

type
  ReadFromStringError* {.size: sizeof(int8).} = object of CatchableError
