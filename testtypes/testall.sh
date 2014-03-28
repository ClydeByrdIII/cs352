echo "------- RUNNING MANUAL TEST CASES --------"
for f in `ls test*.java | sort`
do
	echo -n $f ": "
	../bin/mjcompile-ssa -t $f 2> err > out
	if [ -s "err" ] 
	then
		echo "Passed."
	fi
	if [ -s "out" ] 
	then
		echo "Failed. (!)"
	fi
	if [ "$f" = "test023.java" ]
	then
		echo "(note: test023.java should fail.)"
	fi

	rm out err
done
