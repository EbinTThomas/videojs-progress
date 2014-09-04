"use strict"

$ = jQuery

evoClass = ( className, hasDot ) ->
  return "#{if hasDot then "." else ""}vjs-#{className}"
