#!/bin/bash
FILES=examples/*.java

for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  ~/Downloads/project/bin/mjlex $f > out.txt

  java edu/purdue/cs352/minijava/parser/Lexer $f > out1.txt
  java edu/purdue/cs352/minijava/parser/LexerManual $f > out2.txt

  diff out.txt out1.txt
  diff out.txt out2.txt
  echo -e "\n";
done
