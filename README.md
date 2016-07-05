# Pico y Placa

This is a pico y placa predictor for the City of Quito.

To Run different plate numbers please add them to the data folder. In the following format 
{"plate": "ABC-0121", "date": "2016-07-04"  , "hour": "7:30"}


# Pico y placa Rules

7:00 a las 9:30 en la mañana 
16:00 a 19:30 en la tarde

( This program assumes that the car can start circulating at 9:30:00 and 19:30:00 )

La restricción del Pico y Placa está determinada por el último número de la placa en el siguiente cronograma:

- Lunes, los automotores cuyo último dígito de la placa termine en 1 y 2
- Martes, los automotores cuyo último dígito de la placa termine en 3 y 4
- Miércoles, los automotores cuyo último dígito de la placa termine en 5 y 6
- Jueves, los automotores cuyo último dígito de la placa termine en 7 y 8
- Viernes, los automotores cuyo último dígito de la placa termine en 9 y 0


# How to run

- `bundle exec rake`  : Runs the application and prints the output to the terminal.
- `bundle exec rspec` : Runs the test suite;

