## Copyright (C) 2006 Werner Hoch
## LICENCE: public domain
##
## THIS SOFTWARE IS PROVIDED AS IS AND ANY EXPRESS OR IMPLIED WARRANTIES, 
## INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
## AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
##
# fill in test values into a file template
#
# input:
#   filename: name of the output file
#   template_file: content_vector of the template file
#   parse_table:   lookup table containing the replacement patterns
#   test_vektor:   vector of test values

function DE_templatefile_write(filename, template_file, parse_table, test_vector)
  fid = fopen(filename,"wb");
  # postition in of the virtual filepointer in the templatefile
  cursor=1;  
  for i = (1:rows(parse_table))
    if cursor < parse_table{i,2}
      fwrite(fid, template_file(cursor:parse_table{i,2}-1));
    endif
    val_str=sprintf("%e",test_vector(parse_table{i,1}));
    fwrite(fid,val_str);
    cursor=parse_table{i,2}+parse_table{i,3};
  endfor
  fwrite(fid, template_file(cursor:length(template_file)));
  fclose(fid);
endfunction
