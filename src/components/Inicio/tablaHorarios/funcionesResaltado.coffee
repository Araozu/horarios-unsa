#: Txt -> Txt -> ()
export resaltarCurso = (nombreAño, cursoAbreviado) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }"

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        nuevaClase =
            if (elemento.getAttribute "eslab") is "true"
                "celda__lab--resaltado"
            else
                "celda__teoria--resaltado"
        elemento.className += " #{nuevaClase}"


export removerResaltadoCurso = (nombreAño, cursoAbreviado) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }"

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        clases = elemento.className
        clasesNueva = clases.replace "celda__lab--resaltado", ""
        clasesNueva = clasesNueva.replace "celda__teoria--resaltado", ""

        elemento.className = clasesNueva


export resaltarGrupoCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }_#{ (if esLab then 'L' else '') + grupo }"

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        if (elemento.getAttribute "eslab") is esLab.toString()
            nuevaClase = "celda__#{ if esLab then 'lab' else 'teoria' }--resaltado"
            elemento.className += " #{nuevaClase}"


export removerResaltadoGrupo = (nombreAño, cursoAbreviado, grupo, esLab) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }_#{ (if esLab then 'L' else '') + grupo }"

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        if (elemento.getAttribute "eslab") is esLab.toString()
            clases = elemento.className
            clasesNueva = clases.replace "celda__lab--resaltado", ""
            clasesNueva = clasesNueva.replace "celda__teoria--resaltado", ""

            elemento.className = clasesNueva


export registrarCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }_#{ (if esLab then 'L' else '') + grupo }"

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        if (elemento.getAttribute "eslab") is esLab.toString()
            nuevaClase = "celda__#{ if esLab then 'lab' else 'teoria' }--activo"

            elemento.className += " #{nuevaClase}"


export desregistrarCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }_#{ (if esLab then 'L' else '') + grupo }"

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        if (elemento.getAttribute "eslab") is esLab.toString()
            clases = elemento.className
            clasesNueva = clases.replace "celda__lab--activo", ""
            clasesNueva = clasesNueva.replace "celda__teoria--activo", ""

            elemento.className = clasesNueva

