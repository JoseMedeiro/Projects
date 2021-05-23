## Copyright (C) 2006 Werner Hoch
## LICENCE: public domain
##
## THIS SOFTWARE IS PROVIDED AS IS AND ANY EXPRESS OR IMPLIED WARRANTIES, 
## INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
## AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
##
## -*- texinfo -*-
## @deftypefn {Function File} {[@var{data}] =} spice_readfile (@var{x}, @var{mode})
## Import a spice rawfile into octave.
## This function has reduced header reading abilities to improve the reading speed
## @var{data} holds the data of the spice file
## @var{filename} name of the spice rawfile
## @var{mode} mode name for future extensions
## @end deftypefn

## Author: Werner Hoch <werner.ho@gmx.de>
## Description: fast importfilter for spice rawfiles

function [data] = spice_readfile3(filename, mode)
	
  [fid,msg]=fopen(filename,"rb");
  if (fid == -1)
    error("spice_readfile: file reading failed");
  endif	

  ## defaultvalues
  realflag=1;    ## number type is real, not complex
  binaryflag=1;  ## binary data type
  s.no_points=0;
  s.no_variables=0;
  s.dimensions=0;

  ## read the file header of the file
  ## these are colonseperated key/value pairs
  while ((line=fgets(fid)) != -1)

    if line(1) == "F"  # Flag line
      if line(8) == "c" # complex flag
	realflag=0;
      else              # real data
        realflag=1;
      endif
    elseif line(1) == "N" # no points or no variables
      linelength = length(line);
      if line(5) == "V"   # number of variables
	[s.no_variables,n]=sscanf(line(15:linelength)," %d","C");
      else
	[s.no_points,n]=sscanf(line(12:linelength)," %d","C");
      endif
    elseif line(1) == "B"
      binaryflag=1;
      break;
    elseif line(1) == "V"  # variables or values
      if line(3) == "l" # values
	binaryflag=0;
	## data section begins, leave the header scanner
	break;
      endif
    endif
  endwhile


  ## FIXME: unpadded data is not handled
  if (binaryflag==1 && realflag==1)
    data=fread(fid,[s.no_variables,inf],"float64",0);
    data=data';
  elseif (binaryflag==0 && realflag==1)
    data=fscanf(fid," %e",[s.no_variables+1,inf]);
    data=data(2:s.no_variables+1,:)';
  elseif (binaryflag==1 && realflag==0)
    data=fread(fid,[2*s.no_variables,inf],"float64",0);
    ## convert data from real and imaginary to complex
    data=data';  ## change row/columns before combining to complex
    for n = 1:s.no_variables
      data(:,n)=data(:,2*n-1)+1i.*data(:,2*n);
    endfor
    data=data(:,1:s.no_variables);
  else ## (binaryflag==0 && realflag==0)
    data=[];
    while (1)
      [nr,n]=fscanf(fid,"%d","C");
      if (n != 1)
	break;
      endif
      [vals,n]=fscanf(fid,"%e,%e",[2,s.no_variables]);
      if (n != 2*s.no_variables)
	break;
      else
	data=[data;vals(1,:)+1i*vals(2,:)];  ## !!slow implementation
      endif
    endwhile
  endif

  fclose(fid);
endfunction


