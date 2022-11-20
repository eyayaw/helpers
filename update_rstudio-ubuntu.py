# update RStudio (Daily or Preview) on Ubuntu
import re
from urllib.request import urlopen, urlretrieve
from bs4 import BeautifulSoup
import subprocess

installed_version = subprocess.run(['rstudio' ,'--version'], capture_output=True, text=True).stdout.strip()

html = urlopen('https://dailies.rstudio.com/')
soup = BeautifulSoup(html, 'html.parser')
# find the download link
dlink = soup.find('a', {re.compile('btn btn-secondary platform-ubuntu.*')}).get('href')

fname = Path(dlink).name
version = re.sub("(?:rstudio[-+]?)?(\d{4}\.\d{1,2}\.\d{1,2})([-+]?[a-zA-Z]+)[+-](\d{1,})", "\\1-\\3", fname.rsplit('-', 1)[0])
installed_version = re.sub("(?:rstudio[-+]?)?(\d{4}\.\d{1,2}\.\d{1,2})([-+]?[a-zA-Z]+)[+-](\d{1,})", "\\1-\\3", installed_version)

if installed_version == version:
	print(f'The latest version `{installed_version}` is already installed.')
else:
	print(f"Trying to download Rstudio Daily version `{fname}`...")
	if Path(fname).exists():
		print('The file has been found, a new download may not be needed.')
	else:
		try:
			print(f'Downloading <{fname}> ...')
			urlretrieve(dlink, fname)
		except Exception as e:
			print('Download has not been successful! :(')
	print(f"You may install it with <sudo apt install ./{fname}> or <sudo dpkg -i {fname}>.")
	ans = input("Do you want to update RStudio now? [Y|n] ")
	if ans.capitalize() == "Y":
		subprocess.run(['sudo', 'dpkg', '-i', fname])
		ans = input(f'You have updated RStudio Daily successfuly!\nDo you want remove the downloaded file <{fname}>. [Y|n]? ')
		if ans.capitalize() == "Y":
			subprocess.run(['rm', fname])
	else:
		pass
