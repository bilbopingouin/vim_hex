"""
" Name: vim_hex.vim
" Date: 2020.07.15
" Author: bilbopingouin
"""

"""

function! vim_hex#UnsignedHex2dec(hexvalue)
  return str2nr(a:hexvalue, 16)
endfunction

"""

function! vim_hex#SignedHex2dec(hexvalue, bitsize)
  return float2nr(eval('0x'.a:hexvalue)-pow(2,a:bitsize))
endfunction

"""

function! vim_hex#UnsignedDec2hex(decvalue, size)
  return printf("%0".a:size."x", a:decvalue)
endfunction

"""

function! vim_hex#EchoResult(value, fn, xtr)
  ":echo 'Function: '.a:fn
  ":echo a:value
  " Initial: nan
  :let l:result = (0.0 / 0.0)

  " unsigned hex to dec
  if a:fn ==# 'uHD'
    
    :let l:result = vim_hex#UnsignedHex2dec(a:value)

  " unsigned dec to hex
  elseif a:fn ==# 'uDH'

    if a:xtr == ''
      :let l:result = vim_hex#UnsignedDec2hex(a:value, '8')
    else
      :let l:result = vim_hex#UnsignedDec2hex(a:value, a:xtr/4)
    endif

  " signed dec to hex
  elseif a:fn ==# 'sDH'
    
    if a:xtr == ''
      :let l:size = 8
    else
      :let l:size = a:xtr/4
    endif
    :let l:result = vim_hex#UnsignedDec2hex(a:value, l:size)
    if len(l:result) > l:size
      :let l:rsize = len(l:result)
      :let l:result = l:result[l:rsize-l:size:-1]
    endif
    :let l:result = '0x'.l:result

  " signed hex to dec
  elseif a:fn ==# 'sHD'
    
    if a:xtr == ''
      :let l:size = 32
    else
      :let l:size = str2nr(a:xtr)
    endif
    :let l:result = vim_hex#SignedHex2dec(a:value, l:size)

  endif

  :echo '= '.l:result
endfunction


"""

function! vim_hex#Convert(function, ...)
  :let l:value = a:1
  ":echo l:value
  ":echo a:function
  :let l:additional_info = ''
  if a:0>1
    :let l:additional_info = a:2
  endif

  :call vim_hex#EchoResult(l:value, a:function, l:additional_info)
endfunction

"""

" Examples
"   :UHex2Dec A
"     = 10
command! -nargs=1 UHex2Dec :call vim_hex#Convert('uHD', <f-args>)

" Examples
"   :UDec2Hex 10
"     = 0x0000000a
"   :UDec2HEw 10 8
"     = 0x0a
command! -nargs=+ UDec2Hex :call vim_hex#Convert('uDH', <f-args>)

" Examples
"   :SDec2Hex -10
"     = 0xffffffec
"   :SDec2HEw -10 8
"     = 0xec
command! -nargs=+ SDec2Hex :call vim_hex#Convert('sDH', <f-args>)

" Examples
"   :SHex2Dec ec
"     = -4294967060
"   :SHex2Dec ec 8
"     = -20
command! -nargs=+ SHex2Dec :call vim_hex#Convert('sHD', <f-args>)
