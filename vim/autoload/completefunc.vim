" 使用 s: (脚本局部) 来避免污染全局
function! s:ResetEventIgnore(timer_id)
    set eventignore-=TextChangedI
endfunction


function! completefunc#SkipTextChangedI() abort
    set eventignore+=TextChangedI
    
    " 3. 【转换】timer_start 现在调用那个具名函数
    "    我们传递函数的名字 (作为字符串)
    call timer_start(1, 's:ResetEventIgnore')
    
    return ""
endfunction