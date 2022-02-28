#!/bin/bash
#Author: Tyler Vivian
#Creation Date: 26/2/22 
#Last Modified: 28/2/22
#Description: Used to scrape info off a website

#COLOURS
Black='\033[30m'
Red='\033[31m'
Green='\033[32m'
Brown='\033[33m'
Blue='\033[34m'
Purple='\033[35m'
Cyan='\033[36m'
Gray='\033[37m'
NC='\033[0m'

./passwordCheck.sh

if [ $? -eq 1 ]; then
    echo -e $Red"Please make sure to set your password by running setPassword.sh"
    echo -e $Green"Goodbye"
    exit 0
else
    
    #sets up our url
    url="https://kmtech.com.au/information-centre/top-10-cyber-security-statistics-and-trends-for-2021/"

    #pulls the url, /dev/null takes away some extra shell code out 
    curl -o htmlinfo.txt $url &>/dev/null

    #establishes the html file
    htmlinfo="htmlinfo.txt"

    ###### SCRAPING #######

    scraped="body.txt"
    #take any line with <x>, pull it out, then clean it up with this sed function
    grep "<p>\|<h2>\|<title>\|<li>\|<h3>" $htmlinfo| sed 's/<[^>]*>//g' > temp.txt && cp temp.txt $scraped

    #scraping the text to look better, adding in new lines to make it look better
    cat $scraped | sed 's/&nbsp;//g; /^$/ d; s/^[ \t]*//' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^1\./\n1./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^2\./\n2./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^3\./\n3./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^4\./\n4./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^5\./\n5./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^6\./\n6./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^7\./\n7./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^8\./\n8./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^9\./\n9./g' > temp.txt && cp temp.txt $scraped
    cat $scraped | sed 's/^10\./\n10./g' > temp.txt && cp temp.txt $scraped

    ###### MANIPULATION ########

    #Setting up variable for searching
    search="search.txt"
    #variable for the menu, taken from the HTML curl
    menu="menu.txt"
    grep "<h2>" $htmlinfo| sed 's/<[^>]*>//g; /^$/ d; /^\s/ d' > temp.txt && cp temp.txt $menu

    ###### START #######
    echo -e $Green"Hi! Welcome to the webscrape of KM Tech's 'Top 10 Cyber Security Statistics and Trends for 2021'"
fi
#set up loop for whole program
for (( ; ; ))
do
echo -e $Red"Please select an Analysis Method: $Brown
1.View Text
2.Search
3.Exit"
read opt1

#MENU
if [ $opt1 = 1 ]; then
    echo  "Would you like the Plain and Full text or Summarised text?
1. Plain Text
2. Summarised"
    read opt4
####### RAW MENU #########
    #Idea behind this menu is to give the full and 'raw' text scraped from the website. Nothing has been altered (other than the original scraping)
    if [ $opt4 = 1 ]; then
        echo -e $Green"--------------MENU------------------"
        echo -e $Red"Please select what you would like to read about" $Brown
        cat $menu
        read opt2
        
        #using the body.txt, was able to direct sed to only read certain lines
        if [ $opt2 = 1 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 11,14p 
        elif [ $opt2 = 2 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 16,31p
        elif [ $opt2 = 3 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 33,38p
        elif [ $opt2 = 4 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 40,43p
        elif [ $opt2 = 5 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 45,51p
        elif [ $opt2 = 6 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 53,56p
        elif [ $opt2 = 7 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 58,61p
        elif [ $opt2 = 8 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 63,67p
        elif [ $opt2 = 9 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 69,72p
        elif [ $opt2 = 10 ]; then
            echo -e $Blue ''
            cat $scraped | sed -n 74,75p
        else
            break
        fi
    fi
###### SUMMARY MENU ############
    #this menu is meant to take a key word from each section, and read a few of the words around it, highlighting key points from the section
    if [ $opt4 = 2 ]; then
        
        echo -e $Red"Please select if you would like sections Summarised or see more advanced options" $Brown
        echo -e $Brown"
1. Summarised
2. Advanced"   

        read optsum 
        if [ $optsum = 1 ]; then
            echo -e $Green"--------------SUMMARY------------------"
            cat $menu
            echo -e $Red"Please select an option"
            read opt5

            #Cybercrime costs
            if [ $opt5 = 1 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 11,14p > cybercrimecosts.txt
                
                #this code appears in every following option
                #This first line uses sed to put each word on a separate line and directs it into example.txt 
                cat cybercrimecosts.txt | sed "s/ /\n/g" > example.txt
                #grep uses the -C to take x number of words before and after the match criteria in example.txt. then it puts it into temp.txt
                grep -C 15 '\$' example.txt > temp.txt
                #the cat command puts the temp.txt into one line
                echo $(cat temp.txt) > oneline.txt
                #the earlier temp.txt had -- in between each "summary", using sed, we can separate each "summary" onto a new line, and indicate each new line with a *
                sed "s/--/\n\*/g" oneline.txt

            #Attacks on the rise
            elif [ $opt5 = 2 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 16,31p > attacksrise.txt
                
                cat attacksrise.txt | sed "s/ /\n/g" > example.txt
                #use the -A to get 12 lines after and -B to get 4 lines before
                grep -A 12 -B 4 '\%' example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt
            
            #Remote Work Challenges
            elif [ $opt5 = 3 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 33,38p > remotechallenge.txt
                
                cat remotechallenge.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 remote example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            #Impact and Severity of attacks
            elif [ $opt5 = 4 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 40,43p > attackimpact.txt
                
                cat attackimpact.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 attack example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            #Industry Wide Cyber Attacks
            elif [ $opt5 = 5 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 45,51p > industryattacks.txt
                
                cat industryattacks.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 attack example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            #Data Breaches
            elif [ $opt5 = 6 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 53,56p > databreaches.txt
                
                cat databreaches.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 breach example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            #Information Security Expenses
            elif [ $opt5 = 7 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 58,61p > expenses.txt
                
                cat expenses.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 $ example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            #Phishing Emails and Email security
            elif [ $opt5 = 8 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 63,67p > phishing.txt
                
                cat phishing.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 phishing example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            #Malware attacks
            elif [ $opt5 = 9 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 69,72p > malware.txt
                
                cat malware.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 malware example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt

                
            #Online payment fraud
            elif [ $opt5 = 10 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 74,75p > onlinepaymentfraud.txt
                
                cat onlinepaymentfraud.txt | sed "s/ /\n/g" > example.txt
                grep -C 7 fraud example.txt > temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n\*/g" oneline.txt


            else
                break
            fi
        elif [ $optsum = 2 ]; then
            echo -e $Green"--------------SUMMARY - ADVANCED------------------"
            #this summary advanced feature gives the user a little more narrowing down of their searches.
            #the following code used to make it work, is explained more in the search feature below!
            cat $menu
            read opt5
            echo -e $Blue"
This advanced summary feature allows you to search for a word in the section that you choose,
and the amount of surrounding text (field length)."
            echo -e $Red"
Please select term you are searching for:" $NC
            read term 
            echo -e $Red"Please enter field length:" $NC
            read length
           capterm="[${term^^}]"

            #Cybercrime costs
            if [ $opt5 = 1 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 11,14p > cybercrimecosts.txt
                cat cybercrimecosts.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt 
                                              
            #Attacks on the rise
            elif [ $opt5 = 2 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 16,31p > attacksrise.txt
                cat attacksrise.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt
            
            #Remote Work Challenges
            elif [ $opt5 = 3 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 33,38p > remotechallenge.txt               
                cat remotechallenge.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt

            #Impact and Severity of attacks
            elif [ $opt5 = 4 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 40,43p > attackimpact.txt               
                cat attackimpact.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt


            #Industry Wide Cyber Attacks
            elif [ $opt5 = 5 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 45,51p > industryattacks.txt              
                cat industryattacks.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt

            #Data Breaches
            elif [ $opt5 = 6 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 53,56p > databreaches.txt               
                cat databreaches.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt

            #Information Security Expenses
            elif [ $opt5 = 7 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 58,61p > expenses.txt               
                cat expenses.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt

            #Phishing Emails and Email security
            elif [ $opt5 = 8 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 63,67p > phishing.txt               
                cat phishing.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt

            #Malware attacks
            elif [ $opt5 = 9 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 69,72p > malware.txt                
                cat malware.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt
                
            #Online payment fraud
            elif [ $opt5 = 10 ]; then
                echo -e $Blue ''
                cat $scraped | sed -n 74,75p > onlinepaymentfraud.txt               
                cat onlinepaymentfraud.txt | sed "s/ /\n/g" > example.txt
                grep -C $length $term example.txt > temp.txt
                sed -i "s/$term/$capterm/g" temp.txt
                echo $(cat temp.txt) > oneline.txt
                sed "s/--/\n/g" oneline.txt

            else
                break
            fi
        else
            break
        fi
    fi
##### SEARCH #######
elif [ $opt1 = 2 ]; then
    #this allows for the user to search for their own words
    echo -e $Green"-----------------SEARCH---------------------"
    echo -e $Blue"
This search feature allows you to search for a word in the website,
and the amount of surrounding text (field length)."
    echo -e $Red"
Please select term you are searching for:" $NC
    read opt3 
    echo -e $Red"Please enter field length:" $NC
    read length
    #making a capitalized version with [] around, to make search entry stand out more in text
    capopt3="[${opt3^^}]"
    
    echo -e $Blue''
    #use similar "Summary" code from earlier.
    cat $scraped | sed "s/ /\n/g" > example.txt
    grep -C $length $opt3 example.txt > temp.txt
    #this replaces all search entries with the $capopt3 variable
    sed -i "s/$opt3/$capopt3/g" temp.txt
    echo $(cat temp.txt) > oneline.txt
    sed "s/--/\n/g" oneline.txt  

elif [ $opt1 = 3 ]; then
    #exit feature
    echo -e $Green"Goodbye!"
    break
fi
done


#REFERENCE/ACKNOWLEDGEMENT
#root tech Youtube Channel - How to Scrape a Web Page Using Bash Script - https://www.youtube.com/watch?v=DZ0WKRmUTm4
#Rajesh Soni - help on sed and grep commands