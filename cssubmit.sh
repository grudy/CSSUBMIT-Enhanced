#!/bin/bash
clear
###############################################################################
# GPL Notice
###############################################################################
echo "CSSUBMIT version 1.6.3, Copyright (C) 2012 Madison Solarana"
echo "This program is distributed in the hope that it will be useful,"
echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
echo -e "See the GNU General Public License v2 for more details.\n"
###############################################################################
# check to see if the command was called correctly
###############################################################################
if [ $# -ne 3 ]; then
    echo "Usage: cssubmit course number section letter assignment number"
    echo "For example the command: cssubmit 53 a 3"
    echo "would be for the third assignment in CS53 Section A"
    echo "and for example the command: cssubmit 74 c 9"
    echo "would be for the ninth assignment in CS74 Section C"
    exit 1
fi

course=$(echo "$1" | grep -E "^[[:digit:]]+$")

if [ $(echo ${#course}) -lt 1 ]; then
  echo "The course number you have entered is not in the proper format"
  echo "Please re-execute cssubmit with a valid course number"
  exit 1
fi

if [ $1 -lt 1 -o $1 -gt 499 ]; then
  echo "The course number you have entered is outside the CS Course Catalog"
  echo "This could be because the course number entered is too small or too large"
  echo "Please re-exectue cssubmit with a valid course number"
  exit 1
fi

section=$(echo "$2" | grep -E "^[[:lower:]]+$")

if [ $(echo ${#section}) -gt 1 -o $(echo ${#section}) -lt 1 ]; then
 echo "The section letter you have entered is not in the proper format"
 echo "Sections are defined as a single letter(lower case): a-z"
 echo "Please re-execute cssubmit with a valid section letter"
 exit 1
fi

assignment=$(echo "$3" | grep -E "^[[:digit:]]+$")

if [ $(echo ${#assignment}) -lt 1 ]; then
  echo "The assignment number you have entered is not in the proper format"
  echo "Assignments are defined as numbers: 0, 1, 2, etc."
  echo "Please re-execute cssubmit with a valid assignment number"
  exit 1
fi

###############################################################################
# compiling and executing
###############################################################################
user_random=$RANDOM
if [ $1 -eq 53 ]; then 
	echo -e "\\033[35m >>>>> Choose a compiler(#): (1) - GNU GCC, (2) - Clang-LLVM, (3) - Intel ICC\\033[0m"
	echo -e "\\033[35m > \\033[0m\c" && read compilerchoice
	compiler=$(echo "$compilerchoice" | grep -E "^[1-3]+$")
	if [ $(echo ${#compiler}) -gt 1 -o $(echo ${#compiler}) -lt 1 ]; then
	  echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	  echo -e "\033[31m >>>>> Make sure to pick a valid input(1 - 3).\033[0m"
	  echo -e "\033[31m >>>>> Bailing out...\033[0m"
	  exit 1
	fi
	if [ $compilerchoice -eq 1 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "g++ -Wall -W -pedantic-errors *.cpp -o driver"$user_random -q
	elif [ $compilerchoice -eq 2 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "clang++ -Wall -W -pedantic-errors *.cpp -o driver"$user_random -q
	elif [ $compilerchoice -eq 3 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "icpc -Wall -Werror *.cpp -o driver"$user_random -q
	fi
	
	if [ -f driver$user_random ]; then
                echo -e "\033[32m >>>>> Submit was successfully able to compile your program.\033[0m"
		echo -e "\033[35m >>>>> Submit will now attempt to execute your program.\033[0m"
		script -c "./driver"$user_random -q -a
	else
	    echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	fi
elif [ $1 -eq 73 ]; then
	echo -e "\\033[35m >>>>> Choose a compiler(#): (1) - GNU GFortran, (2) - Intel iFort\\033[0m"
	echo -e "\\033[35m > \\033[0m\c" && read compilerchoice
	compiler=$(echo "$compilerchoice" | grep -E "^[1-2]+$")
	if [ $(echo ${#compiler}) -gt 1 -o $(echo ${#compiler}) -lt 1 ]; then
	  echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	  echo -e "\033[31m >>>>> Make sure to pick a valid input(1 - 2).\033[0m"
	  echo -e "\033[31m >>>>> Bailing out...\033[0m"
	  exit 1
	fi
	if [ $compilerchoice -eq 1 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "gfortran -Wall -pedantic-errors -Werror *.f90 -o driver"$user_random -q
	elif [ $compilerchoice -eq 2 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "ifort -warn all -warn errors *.f90 -o driver"$user_random -q
	fi
	
	if [ -f driver$user_random ]; then
                echo -e "\033[32m >>>>> Submit was successfully able to compile your program.\033[0m"
		echo -e "\033[35m >>>>> Submit will now attempt to execute your program.\033[0m"
		script -c "./driver"$user_random -q -a
	else
	    echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	fi
elif [ $1 -eq 74 ]; then
	echo -e "\\033[35m >>>>> Choose a compiler(#): (1) - GNU GCC, (2) - Clang-LLVM, (3) - Intel ICC\\033[0m"
	echo -e "\\033[35m > \\033[0m\c" && read compilerchoice
	compiler=$(echo "$compilerchoice" | grep -E "^[1-3]+$")
	if [ $(echo ${#compiler}) -gt 1 -o $(echo ${#compiler}) -lt 1 ]; then
	  echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	  echo -e "\033[31m >>>>> Make sure to pick a valid input(1 - 3).\033[0m"
	  echo -e "\033[31m >>>>> Bailing out...\033[0m"
	  exit 1
	fi
	if [ $compilerchoice -eq 1 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "g++ -Wall -W -pedantic-errors *.cpp -o driver"$user_random -q
	elif [ $compilerchoice -eq 2 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "clang++ -Wall -W -pedantic-errors *.cpp -o driver"$user_random -q
	elif [ $compilerchoice -eq 3 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "icpc -Wall -Werror *.cpp -o driver"$user_random -q
	fi
	
	if [ -f driver$user_random ]; then
     	        echo -e "\033[32m >>>>> Submit was successfully able to compile your program.\033[0m"
		echo -e "\033[35m >>>>> Submit will now attempt to execute your program.\033[0m"
		script -c "./driver"$user_random -q -a
	else
	    echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	fi
elif [ $1 -eq 153 ]; then
	echo -e "\\033[35m >>>>> Choose a compiler(#): (1) - GNU GCC, (2) - Clang-LLVM, (3) - Intel ICC\\033[0m"
	echo -e "\\033[35m > \\033[0m\c" && read compilerchoice
	compiler=$(echo "$compilerchoice" | grep -E "^[1-3]+$")
	if [ $(echo ${#compiler}) -gt 1 -o $(echo ${#compiler}) -lt 1 ]; then
	  echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	  echo -e "\033[31m >>>>> Make sure to pick a valid input(1 - 3).\033[0m"
	  echo -e "\033[31m >>>>> Bailing out...\033[0m"
	  exit 1
	fi
	if [ $compilerchoice -eq 1 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "g++ -Wall -W -pedantic-errors *.cpp -I/usr/local/include -L/usr/local/lib -lcppunit -ldl -o driver"$user_random -q
	elif [ $compilerchoice -eq 2 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "clang++ -Wall -W -pedantic-errors *.cpp -I/usr/local/include -L/usr/local/lib -lcppunit -ldl -o driver"$user_random -q
	elif [ $compilerchoice -eq 3 ]; then
		echo -e "\033[35m >>>>> Submit will now attempt to compile your program files.\033[0m"
		script -c "icpc -Wall -Werror *.cpp -I/usr/local/include -L/usr/local/lib -lcppunit -ldl -o driver"$user_random -q
	fi
	
	if [ -f driver$user_random ]; then
     	        echo -e "\033[32m >>>>> Submit was successfully able to compile your program.\033[0m"
		echo -e "\033[35m >>>>> Submit will now attempt to execute your program.\033[0m"
		script -c "valgrind ./driver"$user_random -q -a
	else
	    echo -e "\033[31m >>>>> Submit was unable to compile your program.\033[0m"
	fi
fi

###############################################################################
# making a list of the files to copy to the server
###############################################################################
user_id=$(id -un)

mkdir $user_id$user_random

if [ -f typescript ]; then
	head -n 700 typescript > student_output
fi

cp student_output $user_id$user_random/ 2> /dev/null
###############################################################################
# C-Based Language Files and Headers
###############################################################################
cp *.c $user_id$user_random/ 2> /dev/null
cp *.i $user_id$user_random/ 2> /dev/null
cp *.ii $user_id$user_random/ 2> /dev/null
cp *.m $user_id$user_random/ 2> /dev/null                 #Also MATLAB Files
cp *.mm $user_id$user_random/ 2> /dev/null
cp *.M $user_id$user_random/ 2> /dev/null
cp *.mii $user_id$user_random/ 2> /dev/null
cp *.h $user_id$user_random/ 2> /dev/null
cp *.cpp $user_id$user_random/ 2> /dev/null
cp *.hpp $user_id$user_random/ 2> /dev/null
cp *.cp $user_id$user_random/ 2> /dev/null
cp *.cxx $user_id$user_random/ 2> /dev/null
cp *.CPP $user_id$user_random/ 2> /dev/null
cp *.c++ $user_id$user_random/ 2> /dev/null
cp *.C $user_id$user_random/ 2> /dev/null
cp *.hh $user_id$user_random/ 2> /dev/null
cp *.H $user_id$user_random/ 2> /dev/null
cp *.hp $user_id$user_random/ 2> /dev/null
cp *.hxx $user_id$user_random/ 2> /dev/null
cp *.HPP $user_id$user_random/ 2> /dev/null
cp *.h++ $user_id$user_random/ 2> /dev/null
cp *.tcc $user_id$user_random/ 2> /dev/null
###############################################################################
# FORTRAN Language Files
###############################################################################
cp *.f $user_id$user_random/ 2> /dev/null
cp *.for $user_id$user_random/ 2> /dev/null
cp *.FOR $user_id$user_random/ 2> /dev/null
cp *.F $user_id$user_random/ 2> /dev/null
cp *.fpp $user_id$user_random/ 2> /dev/null
cp *.FPP $user_id$user_random/ 2> /dev/null
cp *.f77 $user_id$user_random/ 2> /dev/null
cp *.f90 $user_id$user_random/ 2> /dev/null
cp *.f95 $user_id$user_random/ 2> /dev/null
cp *.f03 $user_id$user_random/ 2> /dev/null
cp *.f08 $user_id$user_random/ 2> /dev/null
cp *.F77 $user_id$user_random/ 2> /dev/null
cp *.F90 $user_id$user_random/ 2> /dev/null
cp *.F95 $user_id$user_random/ 2> /dev/null
cp *.F03 $user_id$user_random/ 2> /dev/null
cp *.F08 $user_id$user_random/ 2> /dev/null
cp *.i77 $user_id$user_random/ 2> /dev/null
cp *.i90 $user_id$user_random/ 2> /dev/null
cp *.i95 $user_id$user_random/ 2> /dev/null
cp *.i03 $user_id$user_random/ 2> /dev/null
cp *.i08 $user_id$user_random/ 2> /dev/null
cp *.I77 $user_id$user_random/ 2> /dev/null
cp *.I90 $user_id$user_random/ 2> /dev/null
cp *.I95 $user_id$user_random/ 2> /dev/null
cp *.I03 $user_id$user_random/ 2> /dev/null
cp *.I08 $user_id$user_random/ 2> /dev/null
cp *.ftn $user_id$user_random/ 2> /dev/null
cp *.FTN $user_id$user_random/ 2> /dev/null
###############################################################################
# Assembly Files
###############################################################################
cp *.s $user_id$user_random/ 2> /dev/null
cp *.sx $user_id$user_random/ 2> /dev/null
cp *.S $user_id$user_random/ 2> /dev/null
cp *.asm $user_id$user_random/ 2> /dev/null
cp *.ASM $user_id$user_random/ 2> /dev/null
###############################################################################
# Scripts
###############################################################################
cp *.sh $user_id$user_random/ 2> /dev/null
cp *.csh $user_id$user_random/ 2> /dev/null
cp *.zsh $user_id$user_random/ 2> /dev/null
cp *.ksh $user_id$user_random/ 2> /dev/null
cp *.bash $user_id$user_random/ 2> /dev/null
cp *.tcsh $user_id$user_random/ 2> /dev/null
cp *.command $user_id$user_random/ 2> /dev/null
###############################################################################
# Other Languages
###############################################################################
cp *.pl $user_id$user_random/ 2> /dev/null                  #Also Perl Files
cp *.ph $user_id$user_random/ 2> /dev/null
cp *.pm $user_id$user_random/ 2> /dev/null
cp *.pro $user_id$user_random/ 2> /dev/null
cp *.py $user_id$user_random/ 2> /dev/null
cp *.pyc $user_id$user_random/ 2> /dev/null
cp *.pyo $user_id$user_random/ 2> /dev/null
cp *.pyw $user_id$user_random/ 2> /dev/null
cp *.pyd $user_id$user_random/ 2> /dev/null
cp *.python $user_id$user_random/ 2> /dev/null
cp *.rpy $user_id$user_random/ 2> /dev/null
cp *.lisp $user_id$user_random/ 2> /dev/null
cp *.lsp $user_id$user_random/ 2> /dev/null
cp *.rb $user_id$user_random/ 2> /dev/null
cp *.rbw $user_id$user_random/ 2> /dev/null
cp *.rbx $user_id$user_random/ 2> /dev/null
cp *.ruby $user_id$user_random/ 2> /dev/null
cp *.go $user_id$user_random/ 2> /dev/null                  #Go (Google)
cp *.clj $user_id$user_random/ 2> /dev/null
cp *.ml $user_id$user_random/ 2> /dev/null
cp *.mli $user_id$user_random/ 2> /dev/null
cp *.cmi $user_id$user_random/ 2> /dev/null
cp *.cmo $user_id$user_random/ 2> /dev/null
cp *.cma $user_id$user_random/ 2> /dev/null
cp *.cmx $user_id$user_random/ 2> /dev/null
cp *.cmxa $user_id$user_random/ 2> /dev/null
cp *.erl $user_id$user_random/ 2> /dev/null
cp *.yrl $user_id$user_random/ 2> /dev/null
cp *.hrl $user_id$user_random/ 2> /dev/null
cp *.rel $user_id$user_random/ 2> /dev/null
cp *.idl $user_id$user_random/ 2> /dev/null
cp *.asn1 $user_id$user_random/ 2> /dev/null
cp *.asn1db $user_id$user_random/ 2> /dev/null
cp *.mib $user_id$user_random/ 2> /dev/null
cp *.cs $user_id$user_random/ 2> /dev/null
cp *.vb $user_id$user_random/ 2> /dev/null
cp *.vbs $user_id$user_random/ 2> /dev/null
cp *.jsl $user_id$user_random/ 2> /dev/null
cp *.cbl $user_id$user_random/ 2> /dev/null
cp *.cob $user_id$user_random/ 2> /dev/null
cp *.cpy $user_id$user_random/ 2> /dev/null
cp *.cobol $user_id$user_random/ 2> /dev/null
cp *.scala $user_id$user_random/ 2> /dev/null
cp *.d $user_id$user_random/ 2> /dev/null
cp *.hs $user_id$user_random/ 2> /dev/null
cp *.lhs $user_id$user_random/ 2> /dev/null
cp *.lua $user_id$user_random/ 2> /dev/null
cp *.groovy $user_id$user_random/ 2> /dev/null
cp *.gvy $user_id$user_random/ 2> /dev/null
cp *.gy $user_id$user_random/ 2> /dev/null
cp *.gsh $user_id$user_random/ 2> /dev/null
cp *.rs $user_id$user_random/ 2> /dev/null
cp *.rc $user_id$user_random/ 2> /dev/null
cp *.adb $user_id$user_random/ 2> /dev/null
cp *.ads $user_id$user_random/ 2> /dev/null
cp *.scm $user_id$user_random/ 2> /dev/null
cp *.ss $user_id$user_random/ 2> /dev/null
###############################################################################
# Text, Data, & Parser Files
###############################################################################
cp *.ps $user_id$user_random/ 2> /dev/null
cp *.ppt $user_id$user_random/ 2> /dev/null
cp *.pptx $user_id$user_random/ 2> /dev/null
cp *.pptm $user_id$user_random/ 2> /dev/null
cp *.pot $user_id$user_random/ 2> /dev/null
cp *.potm $user_id$user_random/ 2> /dev/null
cp *.potx $user_id$user_random/ 2> /dev/null
cp *.pps $user_id$user_random/ 2> /dev/null
cp *.ppsm $user_id$user_random/ 2> /dev/null
cp *.ppsx $user_id$user_random/ 2> /dev/null
cp *.sldm $user_id$user_random/ 2> /dev/null
cp *.sldx $user_id$user_random/ 2> /dev/null
cp *.doc $user_id$user_random/ 2> /dev/null
cp *.docx $user_id$user_random/ 2> /dev/null
cp *.docm $user_id$user_random/ 2> /dev/null
cp *.dot $user_id$user_random/ 2> /dev/null
cp *.dotm $user_id$user_random/ 2> /dev/null
cp *.dotx $user_id$user_random/ 2> /dev/null
cp *.xls $user_id$user_random/ 2> /dev/null
cp *.xlsx $user_id$user_random/ 2> /dev/null
cp *.xlsm $user_id$user_random/ 2> /dev/null
cp *.xlsb $user_id$user_random/ 2> /dev/null
cp *.xl $user_id$user_random/ 2> /dev/null
cp *.xlm $user_id$user_random/ 2> /dev/null
cp *.xlt $user_id$user_random/ 2> /dev/null
cp *.xltm $user_id$user_random/ 2> /dev/null
cp *.xltx $user_id$user_random/ 2> /dev/null
cp *.xlw $user_id$user_random/ 2> /dev/null
cp *.pdf $user_id$user_random/ 2> /dev/null
cp *.pages $user_id$user_random/ 2> /dev/null
cp *.numbers $user_id$user_random/ 2> /dev/null
cp *.key $user_id$user_random/ 2> /dev/null
cp *.odt $user_id$user_random/ 2> /dev/null
cp *.ott $user_id$user_random/ 2> /dev/null
cp *.ods $user_id$user_random/ 2> /dev/null
cp *.ots $user_id$user_random/ 2> /dev/null
cp *.odp $user_id$user_random/ 2> /dev/null
cp *.otp $user_id$user_random/ 2> /dev/null
cp *.wpd $user_id$user_random/ 2> /dev/null
cp *.qpw $user_id$user_random/ 2> /dev/null
cp *.shw $user_id$user_random/ 2> /dev/null
cp *.pdx $user_id$user_random/ 2> /dev/null
cp *.txt $user_id$user_random/ 2> /dev/null
cp *.text $user_id$user_random/ 2> /dev/null
cp *.rtf $user_id$user_random/ 2> /dev/null
cp *.rtfd $user_id$user_random/ 2> /dev/null
cp *.dat $user_id$user_random/ 2> /dev/null
cp *.csv $user_id$user_random/ 2> /dev/null
cp *.xml $user_id$user_random/ 2> /dev/null
cp *.l $user_id$user_random/ 2> /dev/null                  #Also Lisp Files
cp *.ll $user_id$user_random/ 2> /dev/null
cp *.lex $user_id$user_random/ 2> /dev/null
cp *.y $user_id$user_random/ 2> /dev/null
cp *.yy $user_id$user_random/ 2> /dev/null
cp *.epub $user_id$user_random/ 2> /dev/null
cp *.mobi $user_id$user_random/ 2> /dev/null
cp *.makefile $user_id$user_random/ 2> /dev/null
cp *.MAKEFILE $user_id$user_random/ 2> /dev/null
cp *.Makefile $user_id$user_random/ 2> /dev/null
cp *.MakeFile $user_id$user_random/ 2> /dev/null
cp *.md $user_id$user_random/ 2> /dev/null
cp *.markdown $user_id$user_random/ 2> /dev/null
cp *.mdown $user_id$user_random/ 2> /dev/null
cp *.mdwn $user_id$user_random/ 2> /dev/null
cp *.mpp $user_id$user_random/ 2> /dev/null
cp *.mpt $user_id$user_random/ 2> /dev/null
cp *.mpd $user_id$user_random/ 2> /dev/null
cp *.wps $user_id$user_random/ 2> /dev/null
cp *.xps $user_id$user_random/ 2> /dev/null
cp *.pub $user_id$user_random/ 2> /dev/null
cp *.puz $user_id$user_random/ 2> /dev/null
cp *.vsd $user_id$user_random/ 2> /dev/null
cp *.vss $user_id$user_random/ 2> /dev/null
cp *.vst $user_id$user_random/ 2> /dev/null
cp *.vsw $user_id$user_random/ 2> /dev/null
cp *.vdx $user_id$user_random/ 2> /dev/null
cp *.vsx $user_id$user_random/ 2> /dev/null
cp *.vtx $user_id$user_random/ 2> /dev/null
cp *.one $user_id$user_random/ 2> /dev/null
cp *.onepkg $user_id$user_random/ 2> /dev/null
cp *.xsf $user_id$user_random/ 2> /dev/null
cp *.xsn $user_id$user_random/ 2> /dev/null
cp *.xsd $user_id$user_random/ 2> /dev/null
cp *.rpt $user_id$user_random/ 2> /dev/null
cp *.rdlc $user_id$user_random/ 2> /dev/null
cp *.res $user_id$user_random/ 2> /dev/null
cp *.resx $user_id$user_random/ 2> /dev/null
cp *.cd $user_id$user_random/ 2> /dev/null
cp *.config $user_id$user_random/ 2> /dev/null
cp *.cfg $user_id$user_random/ 2> /dev/null
cp *.wsf $user_id$user_random/ 2> /dev/null
###############################################################################
# SQL & SQLite Files
###############################################################################
cp *.sql $user_id$user_random/ 2> /dev/null
cp *.cls $user_id$user_random/ 2> /dev/null                #Also LaTeX Files
cp *.db-journal $user_id$user_random/ 2> /dev/null
cp *.db3 $user_id$user_random/ 2> /dev/null
cp *.sqlite-shm $user_id$user_random/ 2> /dev/null
cp *.sqlite-wal $user_id$user_random/ 2> /dev/null
cp *.sqlite3 $user_id$user_random/ 2> /dev/null
cp *.sqlite3-journal $user_id$user_random/ 2> /dev/null
cp *.sqlitedb $user_id$user_random/ 2> /dev/null
cp *.sqlite $user_id$user_random/ 2> /dev/null
cp *.mdf $user_id$user_random/ 2> /dev/null
###############################################################################
# TeX & LaTeX Files
###############################################################################
cp *.aux $user_id$user_random/ 2> /dev/null
cp *.bibtex $user_id$user_random/ 2> /dev/null
cp *.dev $user_id$user_random/ 2> /dev/null
cp *.dtx $user_id$user_random/ 2> /dev/null
cp *.dvi $user_id$user_random/ 2> /dev/null
cp *.fd $user_id$user_random/ 2> /dev/null
cp *.fmt $user_id$user_random/ 2> /dev/null
cp *.glo $user_id$user_random/ 2> /dev/null
cp *.hlx $user_id$user_random/ 2> /dev/null
cp *.idx $user_id$user_random/ 2> /dev/null
cp *.ind $user_id$user_random/ 2> /dev/null
cp *.ist $user_id$user_random/ 2> /dev/null
cp *.lat $user_id$user_random/ 2> /dev/null
cp *.latex $user_id$user_random/ 2> /dev/null
cp *.lof $user_id$user_random/ 2> /dev/null
cp *.lot $user_id$user_random/ 2> /dev/null
cp *.lp $user_id$user_random/ 2> /dev/null
cp *.lpx $user_id$user_random/ 2> /dev/null
cp *.ltx $user_id$user_random/ 2> /dev/null
cp *.mf $user_id$user_random/ 2> /dev/null
cp *.odvi $user_id$user_random/ 2> /dev/null
cp *.pk $user_id$user_random/ 2> /dev/null
cp *.pkt $user_id$user_random/ 2> /dev/null
cp *.pxl $user_id$user_random/ 2> /dev/null
cp *.sty $user_id$user_random/ 2> /dev/null
cp *.tex $user_id$user_random/ 2> /dev/null
cp *.texi $user_id$user_random/ 2> /dev/null
cp *.texinfo $user_id$user_random/ 2> /dev/null
cp *.tfm $user_id$user_random/ 2> /dev/null
cp *.tm $user_id$user_random/ 2> /dev/null
cp *.toc $user_id$user_random/ 2> /dev/null
cp *.vf $user_id$user_random/ 2> /dev/null
cp *.vpl $user_id$user_random/ 2> /dev/null
cp *.xfi $user_id$user_random/ 2> /dev/null
###############################################################################
# Java Files
###############################################################################
cp *.class $user_id$user_random/ 2> /dev/null
cp *.ear $user_id$user_random/ 2> /dev/null
cp *.war $user_id$user_random/ 2> /dev/null
cp *.jar $user_id$user_random/ 2> /dev/null
cp *.apk $user_id$user_random/ 2> /dev/null
cp *.js $user_id$user_random/ 2> /dev/null
cp *.java $user_id$user_random/ 2> /dev/null
cp *.jsp $user_id$user_random/ 2> /dev/null
###############################################################################
# Web Files
###############################################################################
cp *.html $user_id$user_random/ 2> /dev/null
cp *.htm $user_id$user_random/ 2> /dev/null
cp *.xhtml $user_id$user_random/ 2> /dev/null
cp *.xht $user_id$user_random/ 2> /dev/null
cp *.mht $user_id$user_random/ 2> /dev/null
cp *.mhtml $user_id$user_random/ 2> /dev/null
cp *.asp $user_id$user_random/ 2> /dev/null
cp *.aspx $user_id$user_random/ 2> /dev/null
cp *.master $user_id$user_random/ 2> /dev/null
cp *.ascx $user_id$user_random/ 2> /dev/null
cp *.asax $user_id$user_random/ 2> /dev/null
cp *.ashx $user_id$user_random/ 2> /dev/null
cp *.cgi $user_id$user_random/ 2> /dev/null
cp *.php $user_id$user_random/ 2> /dev/null
cp *.phtml $user_id$user_random/ 2> /dev/null
cp *.shtml $user_id$user_random/ 2> /dev/null
cp *.stm $user_id$user_random/ 2> /dev/null
cp *.atom $user_id$user_random/ 2> /dev/null
cp *.rss $user_id$user_random/ 2> /dev/null
cp *.css $user_id$user_random/ 2> /dev/null
cp *.xslt $user_id$user_random/ 2> /dev/null
cp *.xsl $user_id$user_random/ 2> /dev/null
cp *.rhtml $user_id$user_random/ 2> /dev/null
cp *.sitemap $user_id$user_random/ 2> /dev/null
###############################################################################
# Archive Files
###############################################################################
cp *.bz $user_id$user_random/ 2> /dev/null
cp *.bz2 $user_id$user_random/ 2> /dev/null
cp *.bza $user_id$user_random/ 2> /dev/null
cp *.bzip2 $user_id$user_random/ 2> /dev/null
cp *.bzp $user_id$user_random/ 2> /dev/null
cp *.bzp2 $user_id$user_random/ 2> /dev/null
cp *.lz $user_id$user_random/ 2> /dev/null
cp *.lzma $user_id$user_random/ 2> /dev/null
cp *.gz $user_id$user_random/ 2> /dev/null
cp *.gzi $user_id$user_random/ 2> /dev/null
cp *.gzip $user_id$user_random/ 2> /dev/null
cp *.gza $user_id$user_random/ 2> /dev/null
cp *.gtar $user_id$user_random/ 2> /dev/null
cp *.tar $user_id$user_random/ 2> /dev/null
cp *.tgz $user_id$user_random/ 2> /dev/null
cp *.taz $user_id$user_random/ 2> /dev/null
cp *.tbz $user_id$user_random/ 2> /dev/null
cp *.tb2 $user_id$user_random/ 2> /dev/null
cp *.tlz $user_id$user_random/ 2> /dev/null
cp *.z $user_id$user_random/ 2> /dev/null
cp *.Z $user_id$user_random/ 2> /dev/null
cp *.zip $user_id$user_random/ 2> /dev/null
cp *.zipx $user_id$user_random/ 2> /dev/null
###############################################################################
# For Funsies: <http://lolcode.com/> LOLCODE is Bejujular 
###############################################################################
cp *.lol $user_id$user_random/ 2> /dev/null
cp *.lols $user_id$user_random/ 2> /dev/null

tar -cfz $user_id.tar.gz $user_id$user_random 1> /dev/null

###############################################################################
# copying the files to the server
###############################################################################
echo -e "\033[35m >>>>> Submit will now attempt to send your files to the server.\033[0m"
echo "progress" > sftp_batch
echo "put $user_id.tar.gz" >> sftp_batch
echo "exit" >> sftp_batch
sftp -o "batchmode no" -b sftp_batch $user_id@minersftp.mst.edu:/dfs/users/cpp/dropbox/$1/$2/$3/

###############################################################################
# cleaning up
###############################################################################
rm student_output 2> /dev/null
rm typescript 2> /dev/null
rm driver$user_random 2> /dev/null
rm -rf $user_id$user_random 2> /dev/null
rm $user_id.tar.gz 2> /dev/null
rm sftp_batch 2> /dev/null

###############################################################################
# finished
###############################################################################
echo -e "\033[35m >>>>> Submit is complete.\033[0m"
exit 0
