#!/bin/bash
FILES=examples/*.java
CANONICAL=../project5C

make clean; make;
echo -e "\n"

for f in $FILES
do
    echo "Processing $f file..."
    # take action on each file. $f store current file name
    
    $CANONICAL/bin/mjcompile-mips $f > his.s
    spim -file his.s > can.txt
    bin/mjcompile-mips $f > mips.s
    spim -file mips.s > out.txt

    #$CANONICAL/bin/mjcompile-x8664 $f > canonicalx8664.txt
    #bin/mjcompile-x8664 $f > myX8664.txt

    #$CANONICAL/bin/mjcompile-mips $f > canonicalMIPS.txt
    #bin/mjcompile-mips $f > myMIPS.txt

    #$CANONICAL/bin/mjinterp-ssa $f > canonicalInterp.txt
    #bin/mjinterp-ssa $f > myInterp.txt

    diff out.txt can.txt
    if [ $? -ne 0 ]; then
        echo -e "Failed matching mjcompile-mips $f"
    fi

    #diff canonicalMIPS.txt myMIPS.txt
    #if [ $? -ne 0 ]; then
     #   echo -e "Failed matching mjcompile-mips $f"
    #fi

    #diff canonicalx8664.txt myX8664.txt
    #if [ $? -ne 0 ]; then
       # cat canonicalx8664.txt 
      #  echo "My output"
     #   cat myX8664.txt
    #    echo -e "Failed matching mjcompile-x8664 $f"
   # fi 
    
    #diff canonicalInterp.txt myInterp.txt 
    #if [ $? -ne 0 ]; then
    #    cat canonicalInterp.txt 
    #    echo "My output"
    #    cat myInterp.txt
    #    echo -e "Failed matching Interp-ssa $f"
    #fi
    
    
    echo -e "\n";
done
rm -f *.txt
