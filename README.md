
# INDIVIDUAL OFFENDER DATASET

* * *

## Generalidades

Este proyecto cuenta con licencia conforme a los términos de la licencia MIT.

**Información de Contacto:**

-   Pinto Veizaga Daniela, [dapivei](https://github.com/dapivei)     
-   Rodríguez Sánchez Elizabeth, [erodriguezul](https://github.com/erodriguezul)
-   Muñoz Sancén Margarita,  [maggiemusa](https://github.com/maggiemusa)
-   Cadavid Sánchez Sebastían, [C1587S](https://github.com/C1587S)

**Procedimiento:**

<div align="justify">

-   [x] Crear el repositorio OffenderDS.
-   [x] Crear estructura de carpetas para un proyecto en python, duplicado del _template_ generado por [navdepp](https://github.com/navdeep-G/samplemod)
-   [x] Escoger una fuente de datos: [Sentencing Commision DataSets](https://github.com/khwilson/SentencingCommissionDatasets), desarrollado por `Kevin Wilson`.
-   [x] Crear un README.md: Describir la fuente de datos. Describir la entidad, estructura de la base de datos, pipeline, instalación, ejecución.
-   [x] Cargar la base de datos a raw
-   [x] Crear una versión limpia en cleaned
-   [x] Crear el esquema semantic
-   [ ] Crear features temporales ligados a la entidad dadas las fechas del evento. Guardarlos en el esquema features.
    </div>

**Índice:**

1.  [ Propósito del Proyecto. ](#PROP)
2.  [ Descripción del problema: sobrepoblación de las cárceles.](#SOBRE)
3.  [ Supuestos Básicos. ](#SUP)
4.  [ Guía para Replicabilidad. ](#REPLI)
5.  [Anexos.](#ANEXOS)

* * *

<a name="PROP"></a>

## 1. Propósito del proyecto

<div align="justify">

**1.1. Objetivo general:** emplear técnicas y herramientas de machine learning para predecir la tasa de encarcelamiento en los distintos distritos de Estados Unidos. La predicción sería a un plazo de 5, 10 y 15 años. _En este etapa del proyecto aún no se genera la predicción; únicamente se genera y procesa la información necesaria y de utilidad de la base de datos "sentencias.csv" para en un futuro próximo proceder con el cruce de la información con datos relevantes como ser: capacidad carcelaria de los distintos distritos de Estados Unidos, presupuesto necesario para la cobertura de las necesidades básicas de los encarcelados, entre otros aspectos._

**1.2. Objetivo inmediato:** generar la estructura de trabajo necesaria para cargar y analizar la base de datos por medio de consultas de tablas relevantes para la predicción futura. Para ello, se emplea bash, python, sql y PostgreSQL.

**1.3. Sentencing Commision DataSets:** compilada por la Comisión de Sentencias de Estados Unidos (USSC, por sus siglas en inglés) y dispuesta en un formato procesado por Kevin Wilson en [Sentencing Commision DataSets](https://github.com/khwilson/SentencingCommissionDatasets), cuya unidad observacional es la `sentencia`. En específico, a través de la base de datos dispuesta por Kevin Wilson se pueden consultar, por año fiscal, de delincuentes que fueron sentenciados:

-   culpables de todos los cargos;
-   de acuerdo con las directricez de la USCC.

No incluye sentencias relativas a:

-   acusados corporativos;
-   apelaciones;
-   acusados que NO fueron culpables de todos los cargos.

_Para esta etapa del proyecto, **únicamente emplearemos la base de datos correspondiente al año fiscal 2017**, misma que cuenta con `66,873` registros de sentencias._

<a name="SOBRE"></a>

**1.4. Sobre la Comisión de Sentencias de Estados Unidos_ (\_USSC_, por sus siglas en inglés)**: es una agencia independiente del órgano judicial que realiza un reporte anual donde incluye todas las sentencias resueltas en el sistema federal judicial.

Desde su origen, en 1984, el USCC tiene como misión de promoción de la unicidad en las sentencias emitidas en el sistema federal; entre las múltiples políticas que se implementaron desde su constitución, se encuentra la emisión de _líneas directricez_ para las sentencias (_sentencing guidelines_); y, la colección, análisis e investigación de información relacionada con crimen federal y problemas de sentencias. De esta manera, la información recolectada por la _USCC_  es la fuente de información primaria relativa al crimen federal y temas relacionados a las sentencias.

## 2. Descripción del problema: sobrepoblación de las cárceles.

<div align="justify">

La sobrepoblación en las cárceles, entendida como la situación en la cuál la cantidad de personas presas sobrepasa la capacidad instalada, es un problema inminente en muchos países, con mayor énfasis en Estados Unidos. De acuerdo con el _World Population Review_, Estados Unidos es el líder mundial en tasas de encarcelamiento, con alrededor de 2.2. millones de personas en carceles en el 2017.

<center>

**Gráfica 1.Tasa de Encarcelamiento Mundial**

<p align="center">
  <image width="600" height="400" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/map_incarceration_rate.png">
</p>

Referencia: Imágen tomada de [World Population Review](http://worldpopulationreview.com/countries/incarceration-rates-by-country/).

</center>

El hacinamiento carcelario en Estados Unidos repercute en las condiciones de salubridad de los reos quiénes, en su mayoría pertenencientes a comunidades marginadas, son sometidos a situaciones inhumanas carcelarias que acentúan sus condiciones de desigualdad. De acuerdo con [The Sentencing Project](https://www.sentencingproject.org/criminal-justice-facts/), en 2002, de la población carcelaria, alrededor de la tercera parte, era conformada por gente de color; quiénes tienen más probabilidades de ser arrestados, condenados culpables y con sentencias rigurosas. Solo por nombrar algunas cifras, los hombres negros son seis veces más propensos a ser encarcelados (y los hombres hispanos, dos veces más propensos), en comparación con los hombres blancos.

<center>

**Gráfica 2.Probabilidad de Encarcelamiento: Residentes estadounidenses nacidos en 2001**

<p align="center">
  <image width="600" height="400" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/probabilidad_encarcelamiento.png">
</p>

Referencia: Imágen tomada de [The Sentencing Project](https://www.sentencingproject.org/criminal-justice-facts/).

</center>

A su vez, los diversos distritos estadounidenses, enfrentan mayores presiones presupuestales, con el fin de cumplir con los requisitos mínimos de control y gestión de los diversos aspectos de la vida de los reclusos: seguridad, comida, oportunidades educativas y recreacionales, mantenimiento de la infraestructura, entre otros.

<a name="SUP"></a>

## 3. Supuestos Básicos

En la realización de este proyecto partimos de varios supuestos básicos:

**3.1.** Cada registro, correspondiente a las sentencias emitidas en un año fiscal determinado, corresponden a uno y SOLO UN acusado. Es decir, más de una sentencia en un mismo año no puede corresponder al mismo acusado. Con ese supuesto inicial, pero necesario, echamos a andar el _workflow_ de trabajo.

**3.2.** Al no contar con el día exacto de la sentencia (únicamente tenemos el mes y el año de cada sentencia), consideramos el primer día de cada mes como el día de la sentencia; dicha inclusión nos fue útil para la construcción de la variable _sentencing_date_, variable principal para el la construcción de eventos, asociadas a la entidad.

**3.3** Al no contar con el día exacto de nacimiento de la entidad (acusado) (únicamente tenemos el mes y el año de cada acusado), consideramos el primer día de cada mes como el día de nacimiento; dicha inclusión nos fue útil para la construcción de la variable _birth_date_.

<a name="REPLI"></a>

## 4. Guía para Replicabilidad

<div align="justify">

**4.0** Obtención de variables de interés

Considerando que el presente trabajo es un primer ejercicio para un futuro análisis más sólido, en el presente trabajo nos concentramos en solamente algunas variables de interés, corrrespondiente a las sentencias dictaminadas durante el año fiscal 2017. Las variables de interés fueron recabas a través de la terminal, con el siguiente comando:

```{bash}
cut -d',' -f72,73,87,132,158,182,128,126,191,328,213,79,
88,268,44,45,212,59,60,39,46,47,49,48,227,177,
189,248,181,197,86 opafy17nid.csv>sentencias2017.csv--
```

Para conocer el detalle de las variables seleccionadas, favor remitirse al *Anexo 1.*

**4.1** Inicializar vagrant:

```{bash}
    vagrant up
    vagrant ssh
```

**4.2** Crear la base de datos en SQLite


A continuación describimos los pasos que seguimos para obtener de manera sencilla los esquemas de las tablas que crearemos. Sin embargo, **no es necesario replicar esta sección**, pues el resultado ya se ha incluido en los archivos del repositorio.

Nos situamos en la carpeta donde tenemos el *.csv*, con la información a cargar y ejecutamos los siguientes comandos:

```
    ➜  ~ cd /data/OffenderDS/sentencias
```

Una vez ahí, vemos que nuestro cursor ha cambiado a `➜  sentencias` . Ahora, creamos la base `sentencias.db`.
```
`sqlite3 sentencias.db`
```

Vemos que el cursor cambia a `sqlite>`. Importamos el .csv que hemos preparado en el **4.0**

```
    sqlite> .mode csv
    sqlite> .separator ","
    sqlite> .import sentencias2017.csv sentencias2017
    sqlite> .tables
    sqlite> .schema
    sqlite>
```

Con esto podemos actualizar el archivo
create_raw_tables.sql, ubicado dentro de la carpeta data/sentencias/sql.

Usamos `Ctrl + D`,  para salir de SQLite y el cursor vuelve a ser `➜  sentencias`.


**4.3** Creación de base de datos en PostgreSQL

Cambiamos al usuario postgres

```
    sudo su postgres
```

Tecleamos `psql` para iniciar el cliente de base de datos.
```
psql
```

Con esto, el cursor ha cambiado a `postgres=#`.

Ahora creamos la base de datos sentencias, junto con el rol, al que asignamos los permisos necesarios:

```
    create database sentencias;
    create role sentencias login;
    alter role sentencias with encrypted password 'sentencias';
    grant all privileges on database sentencias to sentencias;
```
Para ver los roles actualmente creados en el servidor postgres usamos:
```
<https://github.com/C1587S/OffenderDS/blob/master/imagenes/raw.png>
```

`postgres=# \du+`

Usamos `Ctrl + D`, dos veces para volver a vagrant. El cursor es de nuevo `➜  sentencias`

**4.4.** Ambiente virtual

Ahora, crearemos un ambiente virtual. Tecleamos:

    pyenv virtualenv 3.7.3 sentencias
    echo 'sentencias' > .python-version

Nuestro cursor ahora ha cambiado a `(sentencias) ➜  sentencias`.

**4.5.** Instalación de librerías.

    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python
    source $HOME/.poetry/env
    poetry init
    poetry add toml
    poetry add click
    poetry add psycopg2
    poetry add dynaconf

**4.6.** Creación de esquemas y tablas raw

Actualizamos el archivo sentencias.py:

*  añadiendo las conexiones a la base de datos en cada función
*  cambiando la extensión de los archivos a cargar ( a *csv*)
*  actualizando el carácter separador (coma)


 lo llamamos para crear los esquemas y tablas raw, mismas que poblamos :

    python sentencias.py
    python sentencias.py create-schemas
    python sentencias.py create-raw-tables
    python sentencias.py load-sentencias

Nos conectamos a la base de datos desde vagrant:

    psql -U sentencias -d sentencias -h 0.0.0.0 -W

Consultamos los esquemas creados:

    \dn

Verificamos las tablas creadas:

    sentencias-> \dt raw.

Verificamos que hay información en la tabla:

     select * from raw.sentencias2017 limit 3;

Salimos con `Q`

**4.7.** Creando el *query* de cleaned									  

Salimos de postgres (`Ctrl+D`) para comenzar la carga de _cleaned_ , apoyándonos en las funciones de helpers.sql:

     python sentencias.py helpers
     python sentencias.py to-cleaned

Ahora podemos volver a conectarnos a la base de datos:
```
psql -U sentencias -d sentencias -h 0.0.0.0 -W
```

Y verificamos que la tabla ha sido creada en cleaned:

    sentencias-> \dt cleaned.

Y comprobamos que contiene información:					

```
select * from cleaned.sentencias2017 limit 3;
```

</div>

**4.8.** Creando el *query* de semantic


Desde vagrant ejecutamos:

```
python sentencias.py to-semantic
```
Volvemos a conectarnos a la base de datos en postgres:
```
psql- U sentencias -d sentencias -h 0.0.0.0 -W
```
Para acceder a la base ya con las tablas entidades cargadas y de eventos también

Verificamos las tablas creadas:

    sentencias-> \dt semantic.				

```
select * from semantic.entities limit 3;
````
*Ejemplo de output*
|offender|country_citizenship|birth_date|genre|race|
|--|--|--|--|--|
|1|united_states|1980-11-01|male|black or african american|
|2|united states|1987-07-01|female|white or caucasian|
|3|mexico|1992-06-01|male|american indian or alaskan native|


**4.9. Tarea futura: feature and Cohorts**

<div align="justify">
Construimos la estructura de *semantic* tomando como entidades a los *offenders* y, como eventos, a los sucesos en dimensión espacio-temporal que le suceden a los mismos, dada nuestra pregunta de investigación. En particular, ¿cuántos sentenciados tendrán una condena activa en los próximos seis meses para los diferentes estados?

Lo anterior, resulta relevante en la medida que, como se presentó anteriormente, el sistema penitenciario de Estados Unidos presenta graves problemas de hacinamiento en sus cárceles. Por lo cual, es importante para las administraciones de cada estado mantener un registro detallado del número de presos, y más aún, anticipar cuántas plazas por cárcel necesitará en el futuro con el fin de mejorar la gestión de recursos.

El esquema implementado, plantea las bases para desarrollar el problema mencionado, por medio de la especificación de distintas queries, y el futuro diseño de los esquemas del problema.

Por otor lado, en el diseño de los esquemas `cohorts` y `features`.  una pregunta de investigación adicional que surge del contexto presentado resulta de analizar que la tercera parte de la población carcelaria en EEUU es negra, y otra gran proporción corresponde a migrantes. En este sentido, también quisieramos responder ¿en los próximos 6 meses cuántos extranjeros tendran sentencias de prisión activas? Determinar dicho pronóstico permite a las autoridades anticipar la gestión de recursos no solo a nivel local, sino también en torno a políticas migratorias.

Dicha pregunta nos resulta interesante y a la vez polémica, por lo que se realizará un desarrollo de la misma en una extensión de este proyecto en la clase de _Ciencia de datos para Políticas públicas_.


</div>

<a name="ANEXOS"></a>
## 5. Anexos

*Anexo 1. Variables de la tabla en formato .raw*

<p align="center">
  <image width="200" height="600" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/raw.png">
</p>

*Anexo 2. Variables de la tabla en formato .cleaned*

<p align="center">
  <image width="200" height="600" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/clean.png">
</p>

*Anexo 3. Lista de Schemas*

<p align="center">
  <image width="400" height="400" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/list_schemas.jpg">
</p>

*Anexo 4. Lista de Relaciones*


<p align="center">
  <image width="500" height="700" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/list_relations.jpg">
</p>

*Anexo 5. Tabla de Entities*


<p align="center">
  <image width="600" height="300" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/entities.jpg">
</p>

*Anexo 6. Tabla de Evento: sentences*


<p align="center">
  <image width="600" height="300" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/event_sentences.jpg">
</p>


*Anexo 7. Tabla de Evento: reincidence*


<p align="center">
  <image width="600" height="300" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/event_reincidence.jpg">
</p>

*Anexo 8. Tabla de Evento: fine*

<p align="center">
  <image width="600" height="300" src="https://github.com/C1587S/OffenderDS/blob/master/imagenes/event_fine.jpg">
</p>


<div align="center">

</div>


*Anexo 9. Generación de atributos*

| categorías de la variable sentence_type | nombre de la variable asociada en raw o valor de asociado | nombre de la variable asociada en clean         |
| --------------------------------------- | ------------------------------------- | ----------------------------------------------- |
| 0. No prison/probation (fine only)| -|-|
| 1. prison only                          | SENTTOT| imprisonment_length                                        |                                                 |
| 2. prison + confinement                 | SENSPLT                               | sensplt                                         |
| 3. probation +confinement               | SENPLT0 minus SENTTOT                  | total_sentence_length minus imprisonment_length |
| 4. probation only                       | SENSPLT0=0                           | total_sentence_length=0                         |


<center>
</center>


<p align="justify">


*Anexo 10. Descripción de las variables seleccionadas para raw y su correspondiente en cleaned*

| Columnas raw 	| Columnas cleaned |Description                                                                                                                                                                                                                                                                                               	| Range                  	|
|-----------	|-|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|------------------------	|
| AMTTOTAL  	| total_amount                  | Sum of the imposed dollar amounts of fine (FINE), cost of supervision (COSTSUP), and restitution (TOTREST).                                                                                                                                                                                               	| 0 thru $9,999,999,996  	|
| SENTTOT   	| imprisonment_length           | The total prison sentence (excluding months of alternative confinement), in months, without zeros (probation). Zero terms and missing cases are set to "á".                                                                                                                                               	| 0.01 thru 9997         	|
| SENTTOT0  	| senttot0                      | The total prison sentence (excluding months of alternative confinement), in months, with zeros (probation).                                                                                                                                                                                               	| 0 thru 9997            	|
| SENSPLT   	| sensplt                       | The total prison sentence, in months, plus alternatives, without zeros (probation).                                                                                                                                                                                                                       	| 0.01 thru 9997         	|
| SENSPLT0  	| total_sentence_length         | The total prison sentence, in months, plus alternatives, with zeros (probation). Missing terms are set to "á" . This field includes sentences of time imposed, time served, and ¤5G1.3 credit.                                                                                                            	| 0 thru 9997            	|
| TIMSERVC  	| credited_months               | This is the total amount of time (in months) credited to the offender by the judge at the time of sentencing. It is attributed because the offender either remained in custody between arrest and sentencing or because the offender is serving time in state prison on a related charge. T               	| 0 thru 990 Months      	|
| TIMESERV  	| estimated_prison_time         | USSC estimated prison time the defendant will serve based on a mathematical formula. T                                                                                                                                                                                                                    	| 0.00 thru 1,500 Months 	|
| ALTDUM    	| alternative_sentence          | Dummy indicator of alternative sentence (home detention, community confinement, or intermittent confinement), as defined in ¤5C1.1. This variable is Òyes" when any of the alternative fields is coded as Ò97Ó to indicate that the alternative was specified, but the exact number of months is unknown. 	| 0 - 1                  	|
| ALTMO     	| alternative_time              | Total months of alternative incarceration (includes home detention, community confinement, and intermittent confinement).                                                                                                                                                                                 	| 0 thru 96              	|
| CITIZEN   	| citizenship_status            | Identifies the nature of defendant's citizenship with respect to the United States.                                                                                                                                                                                                                       	| 0 - 5                  	|
| CITWHERE  	| country_citizenship           | Identifies the defendant's country of citizenship.                                                                                                                                                                                                                                                        	| 20 thru 216            	|
| CRIMHIST  	| criminal_history              | Yes, There is Criminal History Missing, Indeterminable, orInapplicableIndication as to whether the defendant has any criminal history or law enforcement contacts, including behavior that is not eligible for the application of criminal history points (e.g. arrests).                                 	| 0-1                    	|
| DISPOSIT  	| sentence_disposition          | Disposition of the defendant's case.Note that if there is information that the case went to trial but it does not specify whether the trial was a jury trial or a bench trial, then USSC assumes jury trial since these are more common.                                                                  	| 0-5                    	|
| DISTRICT  	| district_sentence             | The district in which the defendant was sentenced. Use CIRCDIST for the districts in the same order in which they appear in the Sourcebook.                                                                                                                                                               	| 00 thru 96             	|
| DOBMON    	| birth_month                   | The defendant's month of birth. Field not on datafiles prior to FY2005. NO FORMAT.                                                                                                                                                                                                                        	| 1 a 12                 	|
| EDUCATN   	| non_prison_sentence           | Indicates the highest level of education completed by the defendant.                                                                                                                                                                                                                                      	| see coide attachment   	|
| HISPORIG  	| genre                         | Offender's ethnic origin. See MONRACE for race of the offender.                                                                                                                                                                                                                                           	| 0,1,2                  	|
| INOUT     	| education_level               | Indicates whether a defendant received a prison sentence (for defendants who were eligible for non-prison sentences). This variable is similar to PRISDUM but considers who is eligible for non-prison sentences.                                                                                         	| 0-1                    	|
| MONSEX    	| race                          | Indicates the offender's gender.                                                                                                                                                                                                                                                                          	| 0, 1                   	|
| NEWEDUC   	| num_dependents                | Highest level of education for offender (Recode of EDUCATN for the Sourcebook of Federal Sentencing Statistics publication).                                                                                                                                                                              	| 1, 2 , 3, 6..          	|
| NEWRACE   	| offense_type                  | Race of defendant (Recode of MONRACE and HISPORIG for the Sourcebook of Federal Sentencing Statistics publication).                                                                                                                                                                                       	| 1, 2 , 3, 6..          	|
| NUMDEPEN  	| presentence_detention_status  | Number of dependents whom the offender supports (excluding self).                                                                                                                                                                                                                                         	| 1 a 96                 	|
| OFFTYPSB  	| sentence_type                 | Primary offense type for the case generated from the count of conviction with the highest statutory maximum (in case of a tie, the count with the highest statutory minimum is used)                                                                                                                      	|                        	|
| PRESENT   	| sentencing_month              | Offender's pre-sentence detention status.                                                                                                                                                                                                                                                                 	| 1-4É                   	|
| SENTIMP   	| sentence_type_other           | Indicates what type of sentence was given (prison, probation, probation plus alternatives, or prison/split sentence).                                                                                                                                                                                     	| 0-4                    	|
| SENTMON   	| age_range                     | Sentencing month. Generated from SENTDATE.                                                                                                                                                                                                                                                                	| 1 a 12                 	|
| TYPEOTHS  	| birth_year                    | Other types of sentences ordered.                                                                                                                                                                                                                                                                         	| categories             	|
| YEARS     	| sentencing_year               | Categories of age ranges (Recode of AGE for USSC Sourcebook).                                                                                                                                                                                                                                             	| 1-5, categories        	|
| DOBYR     	| sentencing_date               | The defendant's year of birth. Field not on datafiles prior to FY2005.NO SAS FORMAT.                                                                                                                                                                                                                      	| Valid years since 1920 	|
| SENTYR    	| sentencing_end_date           | Sentencing year. Generated from SENTDATE.                                                                                                                                                                                                                                                                 	| Applicable Fiscal Year 	|
