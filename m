#!/bin/bash

makefile=Makefile
applicationfile=app.out



echo "[create] \"$makefile\""

echo "# auto-make" > $makefile
echo >> $makefile

cppfilelist=()

for file in cpp/*.cpp
do
	if test -f $cppfile && test -r $cppfile
	then
		cppfilelist+=$(basename $file .cpp)
	fi
done

t=()
for file in ${cppfilelist[@]}
do
	t+=obj/$file.o
done
echo "$applicationfile: ${t[@]}" >> $makefile
echo "	g++ -o $applicationfile ${t[@]}" >> $makefile
echo >> $makefile

for file in ${cppfilelist[@]}
do
	objfile=obj/$file.o
	t=(cpp/$file.cpp $(sed -n "s/#include *\"\(.*\.hpp\)\"/hpp\/\1 /p" cpp/$file.cpp))
	echo ${t[@]}
	echo "$objfile: ${t[@]}" >> $makefile
	echo "	g++ -I hpp -o $objfile -c ${t[0]}" >> $makefile
done
echo >> $makefile

cat $makefile
echo "[make]"

make

echo "status($?)"

