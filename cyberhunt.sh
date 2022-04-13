red=$'\e[1;31m'
blue=$'\e[1;34m'
yellow=$'\e[1;33m'
meg=$'\e[1;35m'
cyan=$'\e[1;36m'
white=$'\e[1;37m'


echo "$cyan 	 .d8888b.           888                            888    888                   888    "
echo "$cyan 	d88P  Y88b          888                            888    888                   888    "
echo "$cyan 	888    888          888                            888    888                   888    "
echo "$meg	888        888  888 88888b.   .d88b.  888d888      8888888888 888  888 88888b.  888888 "
echo "$meg	888        888  888 888  88b d8P  Y8b 888P         888    888 888  888 888  88b 888    "
echo "$meg	888    888 888  888 888  888 88888888 888          888    888 888  888 888  888 888    "
echo "$meg	Y88b  d88P Y88b 888 888 d88P Y8b.     888          888    888 Y88b 888 888  888 Y88b.  "
echo "$cyan	  Y8888P     Y88888 88888P     Y8888  888          888    888   Y88888 888  888   Y888 "
echo "$cyan 			888                                                                    "
echo "$cyan 		   Y8b d88P                                                                    "
echo "$cyan 		     Y88P                                                                      "

echo -e "\n"
echo "$white Created By: HENIL SANJAYKUMAR GANDHI"
echo "$white Linkedin  : https://www.linkedin.com/in/henil-gandhi-102957218/"
echo "$white Instagram : https://www.instagram.com/fantastic_henil/"
echo "$white Twitter   : https://twitter.com/fantasticHENIL"

echo -e "\n"
echo "$red Enter the Domain name!"
read domain
echo "$blue Getting Subdomains for you, just wait for while !!!"
mkdir $domain
touch subdomain.txt
subfinder -silent -d $domain | httpx -silent -mc 200,301,302,303 > $domain/subdomain.txt
echo "$yellow Subdomain finding is Done"

echo -e "$blue Waybackurl finding....\n it may take time, so chill!!!"
cd $domain
#touch urls.txt
cat subdomain.txt | waybackurls > urls.txt
echo "$red for Which vulnerability you want shortlisted url?"
echo "$cyan ----------------------------------------"
echo "$blue   1.xss           2. ssrf "
echo "$blue   3.Open-Redirect 4.idor  "
echo "$blue   5.lfi           6. sqli "
echo "$blue   7.all above 6           "
echo "$cyan ----------------------------------------"
echo "$red Enter Number besides of vulnerability for specific urls."
read type
#XSS
if [ $type = 1 ];
then
   echo "$blue We are fetching shorten URL's for XSS vulnerability!!."
   cat urls.txt | gf xss > shortenurls_for_XSS.txt
   echo "$yellow Done for XSS!"
fi

#SSRF
if [ $type = 2 ];
then
   echo "$blue We are fetching shorten URL's for SSRF vulnerability!!."
   cat urls.txt | gf SSRF > shortenurls_for_SSRF.txt
   echo "$yellow Done for SSRF!"
fi

#OPEN-REDIRECT
if [ $type = 3 ];
then
   echo "$blue We are fetching shorten URL's for Open-Redirect vulnerability!!."
   cat urls.txt | gf redirect > shortenurls_for_Open-Redirect.txt
   echo "$yellow Done for Open-Redirect!"
fi

#idor
if [ $type = 4 ];
then
   echo "$blue We are fetching shorten URL's for idor vulnerability!!."
   cat urls.txt | gf idor > shortenurls_for_Idor.txt
   echo "$yellow Done for Idor!"
fi

#lfi
if [ $type = 5 ];
then
   echo "$blue We are fetching shorten URL's for lfi vulnerability!!."
   cat urls.txt | gf lfi > shortenurls_for_lfi.txt
   echo "$yellow Done for lfi !"
fi

#sqli
if [ $type = 6 ];
then
   echo "$blue We are fetching shorten URL's for Sqli vulnerability!!."
   cat urls.txt | gf sqli > shortenurls_for_Sqli.txt
   echo "$yellow Done for sqli !"
fi

if [ $type = 7 ];
then
   echo "$red Woww, fetching shorten urls for all vulnerabilities!"
   echo "$blue It may take some time!!"
   cat urls.txt | gf xss > shortenurls_for_XSS.txt
   echo "$yellow Done for XSS!"
   echo "$cyan ----------------------------------"
   cat urls.txt | gf SSRF > shortenurls_for_SSRF.txt
   echo "$yellow Done for SSRF!"
   echo "$cyan ----------------------------------"
   cat urls.txt | gf redirect > shortenurls_for_Open-Redirect.txt
   echo "$yellow Done for Open-Redirect!"
   echo "$cyan ----------------------------------"
   cat urls.txt | gf idor > shortenurls_for_Idor.txt
   echo "$yellow Done for idor!"
   echo "$cyan ----------------------------------"
   cat urls.txt | gf lfi > shortenurls_for_lfi.txt
   echo "$yellow Done for lfi !"
   echo "$cyan ----------------------------------"
   cat urls.txt | gf sqli > shortenurls_for_Sqli.txt
   echo "$yellow Done for Sqli !"
fi
echo -e "\n $cyan Congrats, All Done !"

#Reflected XSS
echo "$blue Here, we are looking Reflected XSS Bug through my own custom payload."
echo -e "\n"
cat shortenurls_for_XSS.txt | qsreplace "&gt;&lt;svg onload=confirm(1)&gt;" | airixss -payload "confirm(1)" > Reflected_XSS.txt

echo -e "$yellow Check reflected_XSS.txt file.\nIf any page of $domain is vulnerable to reflected XSS it will show in text file."
 
