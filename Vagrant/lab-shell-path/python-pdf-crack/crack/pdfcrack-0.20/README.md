pdfcrack sólo usa un procesador

# Extraer

Se extrae a una carpeta en home

```sh
mkdir ~/crack
tar -xf /vagrant/crack/pdfcrack-0.20/pdfcrack-0.20.tar.gz -C ~/crack/
```

Se compila y se verifica

```sh
cd ~/crack/pdfcrack-0.20
make
./pdfcrack
```

## Ejemplos

proceso largo

```sh
./pdfcrack -f /vagrant/files/test.pdf
```

Ejecutar con caracteres de puntos de partida

```sh
./pdfcrack -f /vagrant/files/test.pdf -c abfgtopz12345
```

Para detener el proceso podemos hacerlo con Ctrl+C
pdfcrack intentará guardar el estado del proceso, el archivo suele guardarse con el nombre savedstat.sav

Ejecutar con el archivo de proceso -l
```sh
./pdfcrack -f /vagrant/files/test.pdf -l savedstate.sav
```

Ejecutar con un número mínimo de caracteres -n
```sh
./pdfcrack -f /vagrant/files/test.pdf -n=15
```

Ejecutar con un número máximo de caracteres -m
```sh
./pdfcrack -f /vagrant/files/test.pdf -m=15
```

Ejecutar combinando opciones
```sh
./pdfcrack -f /vagrant/files/test.pdf -n=5 -m=20 -c 100690
```

Ejecutar con tres procesos (como máximo)
```sh
./pdfcrack -f /vagrant/files/test.pdf & ./pdfcrack -f /vagrant/files/test.pdf -c test13590 & ./pdfcrack -f /vagrant/files/test.pdf -c 130690 -n=5
```

