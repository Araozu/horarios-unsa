# Horarios UNSA

[![Build Status](https://travis-ci.org/Araozu/horarios-unsa.svg?branch=master)](https://travis-ci.com/Araozu/horarios-unsa)

## ¿Horario erroneo/desactualizado?

Sigue los pasos a continuación para corregirlo en tu entorno local,
y luego envía un pull request `:D`


## Requisitos

- Node.js
- npm

## Instalación

- Descargar este repositorio.
- Instalar las dependencias de Node.js con `npm install`.

## Ejecución

- En un terminal ejecutar `npm run serve` y navegar al link que aparece.

## Compilación para deploy

- Ejecutar `npm run build`, luego en la carpeta dist/ se encontrará
el código compilado para deploy.

## Como cambiar/configurar/crear los horarios

En la carpeta public/horarios/ se encuentran los archivos para los
horarios en formato *.yaml.

### Formato del nombre de archivo

El formato de los nombres es 
`{año}_{periodo}_{facultad}_{escuela}.yaml`. Los nombres de las
facultades y escuelas son los los mismos de la pagina oficial
de la UNSA.

Por ejemplo, la página web de ing. de sistemas es
http://**fips**.unsa.edu.pe/**ingenieriadesistemas**/,
entonces el nombre del archivo será:

2020_1_fips_ingenieriadesistemas.yaml

### Formato del archivo .yaml

El formato del archivo .yaml es:

```yaml
titulo: string
años:
  {año}:                    # 1er año, 2do año, etc
    {curso}:                # Nombre del curso
      nombre: string        # Nombre del curso
      abreviado: string     # Nombre abreviado
      {tipo}:               # Teoria o Laboratorio
        {grupo}:            # A, B, C, etc
          Docente: string   # Nombre del docente
          Horas: string[]   # Las horas del curso
```

### Formato de Horas

Cada celda del horario tiene un id que muestra su posición exacta.
Su formato es `{DIA}{HORAS}{MINUTOS}`

Por ejemplo, si queremos referirnos a la primera hora del lunes
(Lunes a las 07:00) usaríamos `Lu0700`.

Para referirnos a las 15:50 del Jueves, usamos `Ju1550`.

Las horas están en formato de 24h, divididas en secciones de 50 m,
e incluyen los descansos de 10m.

## Herramientas usadas

- Vue.js 3 con:
    - Pug (Jade)
    - Coffeescript
    - SASS
- Vue Router
- Vue CLI
- pnpm

