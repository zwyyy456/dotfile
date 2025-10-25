vim9script

if !has('patch-9.1.1590')
  au TextChangedI * InsComplete()
endif

def InsComplete()
  if getcharstr(1) == '' && getline('.')->strpart(0, col('.') - 1) =~ '\k$'
    g:SkipTextChangedI()
    feedkeys("\<c-n>", "n")
  endif
enddef

def g:SkipTextChangedI(): string
  set eventignore+=TextChangedI
  timer_start(1, (_) => {
    set eventignore-=TextChangedI
  })
  return ''
enddef
