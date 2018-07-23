#!/bin/bash
declare -a array
iloscPlikow=0
max=1
min=1
avr=1
naglowek=1
rozszerzenie=mod
skala=0
while test $1
do
	arg=0
	case $1 in
	'-h' | '--help') echo -e "\n\tSkrypt oblicza minimum, maximum i srednia z plikow CSV z pewna dokladnoscia [standardowo 0]."
	echo -e "\tZapisuje je do nowego pliku o takiej samej nazwie oraz z podanym rozszerzeniem [standardowo .mod] przypisujac wartosci do odpowiednich kolumn"
	echo -e "\n\t -N:\tSkrypt nie bedzie bral pod uwage naglowka (pierwszego wiersza)" 
	echo -e "\n\t -m:\tSkrypt nie obliczy wartosci minimum dla poszczegolnych kolumn" 
	echo -e "\n\t -M:\tSkrypt nie obliczy wartosci maximum dla poszczegolnych kolumn" 
	echo -e "\n\t -A:\tSkrypt nie obliczy sredniej arytmetycznej dla poszczegolnych kolumn" 
	echo -e "\n\t -s [parametr]:\tSkrypt dokona przyblizenia wartosci sredniej arytmetycznej do podanego miejsca po przecinku" 
	echo -e "\n\t -e [parametr]:\tSkrypt dokona zapisu obliczonych wartosci do pliku o podanym rozszerzeniu" 
	echo -e "\n\n Autor: Michal Lewinski inf122505 rok 2015" 
	exit;;
	"-s") shift 1
	skala=$1;;
	"-e") shift 1
	rozszerzenie=$1;;
	"-"*"N"*) naglowek=0
	arg=1;;&
	"-"*"m"*) min=0
	arg=1;;&
	"-"*"M"*) max=0
	arg=1;;&
	"-"*"A"*) avr=0
	arg=1;;&
	*)
	if (( $arg == 0 ))
		then
		array[$iloscPlikow]=$1
		iloscPlikow=`bc <<< $iloscPlikow+1`
	fi;;	
	esac
	shift 1
done

if (( $iloscPlikow == 0 ))
	then
	a=n
	read -p "Podaj nazwe pliku: " array[0]
	echo -n "" >${array[0]}
	iloscPlikow=`bc <<< $iloscPlikow+1`
	cat >${array[0]}
fi

if (( $naglowek == 1 ))
	then
	for (( i=0; $i < $iloscPlikow; i++ ))
	do
		cat ${array[$i]}|head -n 1 >${array[$i]}.$rozszerzenie
	done
	else
		echo -n "" >${array[$i]}.$rozszerzenie

fi
if (( $min == 1 ))
	then
	for (( i=0; $i < $iloscPlikow; i++ ))
	do
		kolumny=`cat ${array[$i]}|tail -n 1|tr -dc ','|wc -c`
		if (( $kolumny > 0))
			then
			kolumny=`bc <<<$kolumny+1`
		fi
		for (( j=1; $j <= $kolumny; j++ ))
		do
			if (( $naglowek == 1 ))
				then
				temp=`cat ${array[$i]}|tail -n +2|cut -d ',' -f $j|grep -E "^\"*[0-9.]+\"*$"|tr -d '"'|sort -n|head -n 1`
				else
				temp=`cat ${array[$i]}|cut -d ',' -f $j|grep -E "^\"*[0-9.]+\"*$"|tr -d '"'|sort -n|head -n 1`
			fi
			if (( $j == $kolumny ))
				then
				echo "$temp" >> ${array[$i]}.$rozszerzenie
				else	
				echo -n "$temp," >> ${array[$i]}.$rozszerzenie
			fi
		done
	done
fi
if (( $max == 1 ))
	then
	for (( i=0; $i < $iloscPlikow; i++ ))
	do
		kolumny=`cat ${array[$i]}|tail -n 1|tr -dc ','|wc -c`
		if (( $kolumny > 0))
			then
			kolumny=`bc <<<$kolumny+1`
		fi
		for (( j=1; $j <= $kolumny; j++ ))
		do
			if (( $naglowek == 1 ))
				then
				temp=`cat ${array[$i]}|tail -n +2|cut -d ',' -f $j|tr -d '"'|grep -E "^[0-9.]+$"|sort -rn|head -n 1`
				else
				temp=`cat ${array[$i]}|cut -d ',' -f $j|grep -E "^\"*[0-9.]+\"*$"|tr -d '"'|sort -rn|head -n 1`	
			fi
				if (( $j == $kolumny ))
					then
					echo "$temp" >> ${array[$i]}.$rozszerzenie
					else	
					echo -n "$temp," >> ${array[$i]}.$rozszerzenie
				fi
				done
	done
fi

if (( $avr == 1 ))
	then
	for (( i=0; $i < $iloscPlikow; i++ ))
	do
		kolumny=`cat ${array[$i]}|tail -n 1|tr -dc ','|wc -c`
		if (( $kolumny > 0))
			then
			kolumny=`bc <<<$kolumny+1`
		fi
		for (( j=1; $j <= $kolumny; j++))
		do
			if (( $naglowek == 1 ))
				then
				temp=`cat ${array[$i]}|tail -n +2|cut -d ',' -f $j|tr -d '"'|grep -E "^[0-9.]+$"|tr "\n" "+"|xargs -i\{\} echo \{\}0`
				else
				temp=`cat ${array[$i]}|cut -d ',' -f $j|tr -d '"'|grep -E "^[0-9.]+$"|tr "\n" "+"|xargs -i\{\} echo \{\}0`
			fi
			linie=`echo "$temp"|tr -dc "+"|wc -c`
			if (( $linie > 0))
				then
				temp=`echo "scale=$skala;($temp)/$linie"|bc`
				# echo "liczba linii: $linie"
				# echo "SREDNIA: $temp"
			fi
			# echo "liczba linii: $linie"
			# echo "suma: $temp"
			if (( $j == $kolumny ))
				then
				echo "$temp" >> ${array[$i]}.$rozszerzenie
				else	
				echo -n "$temp," >> ${array[$i]}.$rozszerzenie
			fi
			
		done
	done
fi














