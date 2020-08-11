ejecutarEnElementos = (clase, funcion) =>
    elementos = document.getElementsByClassName clase
    for elemento in elementos
        funcion elemento


#: Txt -> Txt -> ()
export ocultar_mostrarCurso = (nombreAnio, cursoAbreviado) =>
    nombreAnioF = nombreAnio.substring 0, (nombreAnio.indexOf " ")
    clase = "_#{ nombreAnioF }_#{ cursoAbreviado }"

    ejecutarEnElementos clase, (el) =>
        clases = el.className
        if (clases.indexOf "cursor_click") == -1
            if (el.getAttribute "oculto") == "true"
                el.removeAttribute "oculto"
                clases = clases.replace "celda-oculta", ""
                el.className = clases
            else
                el.setAttribute "oculto", "true"
                el.className += " celda-oculta"


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



opacarElemento = (elemento) =>
    elemento.className += " elementoOpaco"


desopacarElemento = (elemento) =>
    clases = elemento.className
    clasesNueva = clases.replace "elementoOpaco", ""

    elemento.className = clasesNueva



export obtenerClaseGrupoCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    nombreAñoF = nombreAño.substring 0, (nombreAño.indexOf " ")
    "_#{ nombreAñoF }_#{ cursoAbreviado }_#{ (if esLab then 'L' else '') + grupo }"



export obtenerClaseCursoGeneral = (claseGrupoCurso) =>
    posPrimerRaya = claseGrupoCurso.indexOf "_"
    primerRaya = claseGrupoCurso.substr (posPrimerRaya + 1)
    posSegundaRaya = primerRaya.indexOf "_"
    segundaRaya = primerRaya.substr (posSegundaRaya + 1)
    posFinal = (segundaRaya.indexOf "_") + posPrimerRaya + posSegundaRaya + 2
    claseGrupoCurso.substr 0, posFinal



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



cursosActivos = {}


obtenerNombreAño = (claseObjetivo) =>
    primerRaya = claseObjetivo.substr 1
    res = primerRaya.indexOf "_"
    claseObjetivo.substring 0, (res + 1)



registrarCursoActivo = (claseObjetivo) =>
    nombreAño = obtenerNombreAño claseObjetivo

    unless cursosActivos[nombreAño]?
        cursosActivos[nombreAño] = new Set()

    cursosActivos[nombreAño].add(claseObjetivo)



desregistrarCursoActivo = (claseObjetivo) =>
    nombreAño = obtenerNombreAño claseObjetivo

    if cursosActivos[nombreAño]?
        cursosActivos[nombreAño].delete(claseObjetivo)



export reiniciarTabla = (nombreAño) =>
    datos = cursosActivos[nombreAño]
    if datos?
        ```
        for (const nombre of datos) {
            activarGrupoCursoStr(nombre);
        }
        ```
        datos.clear()



export activarGrupoCurso = (nombreAño, cursoAbreviado, grupo, esLab) =>
    claseObjetivo = obtenerClaseGrupoCurso nombreAño, cursoAbreviado, grupo, esLab
    activarGrupoCursoStr claseObjetivo



export activarGrupoCursoStr = (claseObjetivo) =>
    claseGeneral = obtenerClaseCursoGeneral claseObjetivo
    esLab = (claseObjetivo.substr -2, 1) is "L"

    elementos = document.getElementsByClassName claseGeneral

    elementosObjetivo = []
    elementosAOpacar = []

    for elemento in elementos
        clases = elemento.classList
        i = 0
        agregarAOpaco = no
        while i < clases.length
            claseActual = clases[i]

            if claseActual is claseObjetivo
                elementosObjetivo.push elemento
                agregarAOpaco = no
                break
            else
                if esLab and claseActual is "celda__lab"
                    agregarAOpaco = yes
                else if esLab and claseActual is "celda__teoria"
                    break
                else if !esLab and claseActual is "celda__teoria"
                    agregarAOpaco = yes
                else if !esLab and claseActual is "celda__lab"
                    break

            i++

        if agregarAOpaco then elementosAOpacar.push elemento

    opacarElementos = no

    for elemento in elementosObjetivo

        estaActivo = ((elemento.getAttribute "activo") ? "no") is "si"
        if estaActivo
            removerResaltadoElemento elemento, "activo"
            elemento.setAttribute "activo", "no"
        else
            opacarElementos = yes
            resaltarElemento elemento, esLab, "activo"
            elemento.setAttribute "activo", "si"

    if opacarElementos
        registrarCursoActivo claseObjetivo
        for elemento in elementosAOpacar
            opacarElemento elemento

    else
        desregistrarCursoActivo claseObjetivo
        for elemento in elementosAOpacar
            desopacarElemento elemento



