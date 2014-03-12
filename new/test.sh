#!/bin/bash
FILES=examples/Simple.java
CANONICAL=../project3C

make clean; make;
echo -e "\n"

for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
   $CANONICAL/bin/mjcompile-ssa $f > canonicalSSA.txt
  bin/mjparse $f > mySSA.txt

  $CANONICAL/bin/mjcompile-mips $f > canonicalMIPS.txt
  bin/mjparse-ast $f > myMIPS.txt
   
  $CANONICAL/bin/mjinterp-ssa $f > canonicalInterp.txt
  bin/mjinterp-ast $f > myInterp.txt

  diff canonicalSSA.txt mySSA.txt
  if [ $? -ne 0 ]; then
    echo -e "Failed matching mjcompile-ssa $f"
  fi

  #diff canonicalMIPS.txt myMIPS.txt
  #if [ $? -ne 0 ]; then
   # echo -e "Failed matching mjcompile-mips $f"
  #fi

  #diff canonicalInterp.txt myInterp.txt 
  #if [ $? -ne 0 ]; then
   # echo -e "Failed matching Interp-ssa $f"
  #fi

  echo -e "\n";
done
rm -f *.txt
