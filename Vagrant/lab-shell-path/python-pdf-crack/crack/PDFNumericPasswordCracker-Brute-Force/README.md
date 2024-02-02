# PDF Numeric Password Cracker
Technique used - Brute Force

## Requirements
Requires Python 3.* and pikepdf, recommend use env

If you use Windows create a env create a virtual environment in a folder shared from the host machine, not going to work.

```sh
python3.8 -m venv ~/env 
source ~/env/bin/activate
pip install pikepdf
``` 

## Usage
```sh
python crack.py PATH_TO_PDF_FILE [-m MIN_DIGITS] [-n MAX_DIGITS] [-r MATCHING_REGEX]
``` 

Example 1 - If the password is between 3 to 5 digits long
```sh
python crack.py /vagrant/files/test.pdf -m 3 -n 5
```

Example 2 - Same as above, but tests passwords containing the digits 1-3 **only**
```sh
python crack.py /vagrant/files/test.pdf -m 3 -n 5 -r ^[1-3]+$
```
