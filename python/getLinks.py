import urllib3
import re


http = urllib3.PoolManager()

#connect to a URL
website = http.request('GET', "http://www.dice/com")

#read html code
html = website.read()

#use re.findall to get all the links
links = re.findall('"((http|ftp)s?://.*?)"', html)

print (links)
