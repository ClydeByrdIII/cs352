#!/bin/bash
FILES=examples/*.java
CANONICAL=../project2C

make clean; make;
echo -e "\n"

for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
   $CANONICAL/bin/mjparse $f > canonicalParser.txt
  bin/mjparse $f > myParser.txt

  $CANONICAL/bin/mjparse-ast $f > canonicalParserAST.txt
  bin/mjparse-ast $f > myParserAST.txt
   
  $CANONICAL/bin/mjinterp-ast $f > canonicalInterp.txt
  bin/mjinterp-ast $f > myInterp.txt

  diff canonicalParser.txt myParser.txt
  if [ $? -ne 0 ]; then
    echo -e "Failed matching Parser $f"
  fi

  diff canonicalParserAST.txt myParserAST.txt
  if [ $? -ne 0 ]; then
    echo -e "Failed matching ParserAST $f"
  fi

  diff canonicalInterp.txt myInterp.txt 
  if [ $? -ne 0 ]; then
    echo -e "Failed matching Interp-ast $f"
  fi

  echo -e "\n";
done
rm -f *.txt
