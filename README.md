# Practica con Linux

Ejercicios con lo aprendido en **MissingSemester[(https://missing.csail.mit.edu/)]**

## Creador de datos falsos

		source populator.sh
		populate <foldername> <filename> <extension> <records>

		# Ejemplo:
		populate test fake txt 50
		populate test fake json 50
		
		# <foldername>: nombre de la carpeta para agregar los datos falsos
		# <filename>: nombre del archivo que contendra los datos falsos. Default: <fakedata>
		# <extension>: extension para el archivo que contendra los datos falsos. Default: <txt>
		# <records>: cuantos registros se quieren agregar. Default: 20

