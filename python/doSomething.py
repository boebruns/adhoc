import requests
import re

response = requests.get('https://www.dice.com/')
website = response.text

# use re.findall to get all the links
# links = re.findall(' "((http|ftp)s?://.*?)" ', website)

links = re.findall('meta', website)

print (links)
# print (website)

# print(response.text)
