# Value conversions

Convert hexadecimal to decimal and the other way around.

## Install

Use a vim plugin manager.

## Usage

A few commands have been implemented

Examples
- `:UHex2Dec A`
  = 10
- `:UDec2Hex 10`
  = 0x0000000a
- `:UDec2HEw 10 8`
  = 0x0a
- `:SDec2Hex -10`
  = 0xffffffec
- `:SDec2HEw -10 8`
  = 0xec
- `:SHex2Dec ec`
  = -4294967060
- `:SHex2Dec ec 8`
  = -20
