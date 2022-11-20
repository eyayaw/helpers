from bs4 import BeautifulSoup
import requests
from pathlib import Path
import re
import subprocess
def abs_link(x: str):
    return f'https://github.com/{x}'

installed_version = subprocess.run(['quarto' ,'--version'], capture_output=True, text=True).stdout.strip()
url = "https://github.com/quarto-dev/quarto-cli/releases/"
headers = {'User-Agent': "Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0"}

r = requests.get(url, headers=headers)
soup = BeautifulSoup(r.content, 'html.parser')
latest = soup.find('a', class_="Link--primary").get('href', None)
version_num = latest.split("/")[-1][1:]
if installed_version == version_num:
	print(f'The latest version `{installed_version}` is already installed.')
else:
    url = abs_link(latest).replace('tag', 'expanded_assets')
    r = requests.get(url, headers=headers)
    soup = BeautifulSoup(r.content, 'html.parser')
    dlink = soup.find('a', {'class': 'Truncate', 'href': re.compile('quarto.*[.]deb$')})['href']
    dlink = abs_link(dlink)
    fname = Path(dlink).name
    print(f"Trying to download Rstudio Daily version `{fname}`...")
    if Path(fname).exists():
        print('The file has been found, a new download may not be needed.')
    else: 
        r = requests.get(dlink)
        with open(fname, 'wb') as f:
            print(f"Downloading {dlink} ...")
            f.write(r.content)

    ans = input("Would you like to update now? [Y/n] " )
    if ans.lower() == "y":
        subprocess.run(['sudo', 'dpkg', '-i', fname])
