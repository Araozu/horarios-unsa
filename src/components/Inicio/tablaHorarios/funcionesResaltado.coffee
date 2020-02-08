ejecutarEnElementos = (clase, funcion) =>
    elementos = document.getElementsByClassName clase
    for elemento in elementos
        funcion elemento



#: Txt -> Txt -> ()
export resaltarCurso = (nombreAño, cursoAbreviado) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }"

    ejecutarEnElementos clase, (elemento) =>
        nuevaClase =
            if (elemento.getAttribute "eslab") is "true"
                "celda__lab--resaltado"
            else
                "celda__teoria--resaltado"
        elemento.className += " #{nuevaClase}"



export removerResaltadoCurso = (nombreAño, cursoAbreviado) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    clase = "_#{ nombreAñoF }_#{ cursoAbreviado }"

    ejecutarEnElementos clase, (elemento) =>
        clases = elemento.className
        clasesNueva = clases.replace "celda__lab--resaltado", ""
        clasesNueva = clasesNueva.replace "celda__teoria--resaltado", ""

        elemento.className = clasesNueva


resaltarElemento = (elemento, esLab, etiqueta = "resaltado") =>
    nuevaClase = "celda__#{ if esLab then 'lab' else 'teoria' }--#{ etiqueta }"
    elemento.className += " #{nuevaClase}"



export obtenerClaseGrupoCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    "_#{ nombreAñoF }_#{ cursoAbreviado }_#{ (if esLab then 'L' else '') + grupo }"



export resaltarGrupoCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    clase = obtenerClaseGrupoCurso nombreAño, cursoAbreviado, grupo, esLab

    ejecutarEnElementos clase, (elemento) => resaltarElemento elemento, esLab


removerResaltadoElemento = (elemento, etiqueta = "resaltado") =>
    clases = elemento.className
    clasesNueva = clases.replace "celda__lab--#{ etiqueta }", ""
    clasesNueva = clasesNueva.replace "celda__teoria--#{ etiqueta }", ""

    elemento.className = clasesNueva


export removerResaltadoGrupo = (nombreAño, cursoAbreviado, grupo, esLab) =>
    clase = obtenerClaseGrupoCurso nombreAño, cursoAbreviado, grupo, esLab

    ejecutarEnElementos clase, (elemento) => removerResaltadoElemento elemento


export registrarCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    clase = obtenerClaseGrupoCurso nombreAño, cursoAbreviado, grupo, esLab

    ejecutarEnElementos clase, (elemento) =>
        nuevaClase = "celda__#{ if esLab then 'lab' else 'teoria' }--activo"

        elemento.className += " #{nuevaClase}"


export desregistrarCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    clase = obtenerClaseGrupoCurso nombreAño, cursoAbreviado, grupo, esLab

    ejecutarEnElementos clase, (elemento) =>
        clases = elemento.className
        clasesNueva = clases.replace "celda__lab--activo", ""
        clasesNueva = clasesNueva.replace "celda__teoria--activo", ""

        elemento.className = clasesNueva



export activarGrupoCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    clase = obtenerClaseGrupoCurso nombreAño, cursoAbreviado, grupo, esLab

    elementos = document.getElementsByClassName clase

    for elemento in elementos
        estaActivo = ((elemento.getAttribute "activo") ? "no") is "si"
        if estaActivo
            removerResaltadoElemento elemento, "activo"
            elemento.setAttribute "activo", "no"
        else
            resaltarElemento elemento, esLab, "activo"
            elemento.setAttribute "activo", "si"

