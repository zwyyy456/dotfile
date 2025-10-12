" 设置 gui 字体，如果找不到字体，则使用下一个字体
function! guifont#SetGuiFontWithFallback(font_names, font_size)
    if !has('gui_running')
        return
    endif
    for font_name in a:font_names
        try
            let full_font_string = substitute(font_name, ' ', '\\ ', 'g') . ':h' . a:font_size
            execute 'set guifont=' . full_font_string
            return
        catch /E59[6-8]/
            continue
        endtry
    endfor
    echohl WarningMsg | echo "警告：字体列表中的所有字体都无法找到。" | echohl None
endfunction