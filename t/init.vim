let s:sections = ['a', 'b', 'c', 'gutter', 'x', 'y', 'z', 'warning']

function! s:clear()
  for key in s:sections
    unlet! g:airline_section_{key}
  endfor
endfunction

describe 'init'
  before
    call s:clear()
    call airline#init#bootstrap()
    call airline#init#sections()
  end

  after
    call s:clear()
  end

  it 'section a should have mode, paste, iminsert'
    Expect g:airline_section_a =~ 'mode'
    Expect g:airline_section_a =~ 'paste'
    Expect g:airline_section_a =~ 'iminsert'
  end

  it 'section b should be blank because no extensions are installed'
    Expect g:airline_section_b == ''
  end

  it 'section c should be file'
    Expect g:airline_section_c == '%<%f%m'
  end

  it 'section x should be filetype'
    Expect g:airline_section_x =~ '&filetype'
  end

  it 'section y should be fenc and ff'
    Expect g:airline_section_y =~ 'ff'
    Expect g:airline_section_y =~ 'fenc'
  end

  it 'section z should be line numbers'
    Expect g:airline_section_z =~ '%3p%%'
    Expect g:airline_section_z =~ '%3l'
    Expect g:airline_section_z =~ '%3c'
  end

  it 'should not redefine sections already defined'
    for s in s:sections
      let g:airline_section_{s} = s
    endfor
    call airline#init#bootstrap()
    for s in s:sections
      Expect g:airline_section_{s} == s
    endfor
  end

  it 'all default statusline extensions should be blank'
    Expect airline#parts#get('hunks').raw == ''
    Expect airline#parts#get('branch').raw == ''
    Expect airline#parts#get('tagbar').raw == ''
    Expect airline#parts#get('syntastic').raw == ''
  end
end

