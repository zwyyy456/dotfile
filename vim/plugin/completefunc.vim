vim9script

au TextChangedI * InsComplete()
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
