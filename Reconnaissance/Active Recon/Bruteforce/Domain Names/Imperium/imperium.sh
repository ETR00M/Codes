#!/bin/bash

get_domain="$1"
get_wordlist="$2"
get_host=""

if [ -z "$3" ]
then
	if [ ! -z "$get_domain" ] && [ ! -z "$get_wordlist" ]
	then	
		if [ ! -e banner.txt ]
		then
			echo -e
			echo "================================================================================"
			echo "                                   SUBDOMAIN ENUMERATION: BY ETR00M"
		else
			cat banner.txt
			echo "                                                  SUBDOMAIN ENUMERATION: BY ETR00M"
		fi

		echo -e
		echo "Target: $get_domain"
		echo "Wordlist: $get_wordlist"
		echo "        STARTING BRUTE FORCE ON SUBDOMAINS"
		echo "         `date`"
		echo -e
		echo "                ++++++++++"

		cat $get_wordlist 2> imperium.log | while IFS= read -r line
		do
			if [ ! -z "$line" ]
			then
				get_host=`host $line"."$get_domain 2> /dev/null | grep has | cut -d " " -f 1 | uniq`
				if [ ! $? -eq 0 ]
				then
					sleep 1s
				fi

				if [ "$get_host" != "Host" ] && [ ! -z "$get_host" ]
				then
					echo $get_host >> $get_domain.txt
				fi

			fi
		done

		if [ -s imperium.log ]
		then
			echo -e
			echo "ERROR: WORDLIST PATH OR FILENAME IS INCORRECT!"
			echo -e
			echo "Usage: You need to set a target DOMAIN and a WORDLIST for subdomain BRUTE FORCE"
	                echo "Ex: ./imperium.sh DOMAIN WORDLIST.TXT"
		else
			echo -e
			echo "Found: `wc -l $get_domain.txt | cut -d ' ' -f 1` subdomains saved on Path:"
			echo "`pwd`/$get_domain.txt"
		fi

		rm -rf imperium.log 2> /dev/null
		echo "         `date`"
                echo -e
                echo "======================================================[E][T][R][0][0][M]========"

	else
		echo "Usage: You need to set a target DOMAIN and a WORDLIST for subdomain BRUTE FORCE"
		echo "Ex: ./imperium.sh DOMAIN WORDLIST.TXT"
	fi
else	
	echo "Usage: You need to set a target DOMAIN and a WORDLIST for subdomain BRUTE FORCE"
	echo "Ex: ./imperium.sh DOMAIN WORDLIST.TXT"
fi
