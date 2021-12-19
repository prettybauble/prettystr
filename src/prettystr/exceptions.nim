# author: Ethosa
## This module describes all exceptions.

{.push size: sizeof(int8).}
type
  ReadFromStringError* = object of CatchableError
{.pop.}
