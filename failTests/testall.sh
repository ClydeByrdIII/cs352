
echo "------- RUNNING EXAMPLE TEST CASES --------"
for f in `ls ../examples/*.java`
do
	echo -n $f ": "
	../../project-solution/bin/mjcompile-ssa -t $f > out1 2> err1
	/Development/cs352/project4/project/bin/mjcompile-ssa -t $f > out2 2> err2
	diff out1 out2 > out3

	if [ -s out3 ] 
	then
		echo "Failed. (!)"
	else
		if [ -s err1 ] 
		then
			echo "Failed. (!)"
		else
			if [ -s err2 ] 
			then
				echo "Failed. (!)"
			fi
		fi
	fi
	rm out1 out2 err1 err2
done
echo


echo "------- RUNNING MANUAL TEST CASES --------"
for f in `ls *.java | sort`
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
	if [ "$f" = "Pass23.java" ]
	then
	        echo "(note: Pass23.java should fail)"
	fi
	if [ "$f" = "Pass27.java" ]
	then
		echo "*(note: Pass27.java should fail"
	fi

	rm out err
done
