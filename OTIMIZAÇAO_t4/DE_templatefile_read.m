## Copyright (C) 2006 Werner Hoch
## LICENCE: public domain
##
## THIS SOFTWARE IS PROVIDED AS IS AND ANY EXPRESS OR IMPLIED WARRANTIES, 
## INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
## AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
##
#
# generate a lookup table for parameters in a template file
#
# input:
#   filename: string of the filename
#   params:   cell array of strings containing the parameters
#             all parameters start with '#'
# output:
#   parse_table: {number of param, fileposition, parameter length, param}
#   file_content: vector containing the template file
#
function [parse_table, file_content] = DE_templatefile_read(filename, params)
  if iscellstr(params) <0
    error("templatefile_read: params is not a cellarray of strings")
  endif
  fid = fopen(filename,"rb");
  if fid < 0 
    error("templatefile_read: reading file failed");
  endif

  [file_content, file_len] = fread(fid,Inf,"char");
  ind = find(file_content == '#');
  min_ind_next=0;
  replacement_index=0;
  for i = (1:length(ind)-1)
    ind2=ind(i);
    if (ind2 < min_ind_next)
      continue
    endif
    for j = (1:length(params))
      para_len=length(params{j});
      if (ind2 + para_len - 1 <= file_len)
        para = char(file_content(ind2:ind2+para_len-1)');
        if strcmp(para, params{j})
          replacement_index++;
	  parse_table{replacement_index,1}=j;
	  parse_table{replacement_index,2}=ind2;
          parse_table{replacement_index,3}=length(params{j});
          parse_table{replacement_index,4}=params{j};
          min_ind_next = ind2 + para_len;
        endif
      endif
    endfor
  endfor
  fclose(fid);
endfunction
