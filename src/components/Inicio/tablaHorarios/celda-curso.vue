<template lang="pug">
    span.celda(:class="clases" :eslab="datos.esLab? 'true': 'false'"
        @mouseenter="resaltarCeldasGrupo"
        @mouseleave="quitarResaltadoGrupo"
        @click="toggleActivo")
        |  {{ datos.cursoAbreviado }}
        span  {{ (datos.esLab? "L": "") + datos.nombreGrupo }}&nbsp;

    //
</template>

<script lang="coffee">
    import { resaltarGrupoCurso, removerResaltadoGrupo } from "./funcionesResaltado.coffee"

    export default
        name: "celda-curso"
        props:
            datos:
                type: Object
                required: yes
            nombreAño:
                type: String
                required: yes
        data: ->
            celdaCursoActiva: no
        computed:
            clases: ->
                res = []
                esLab = @datos.esLab
                cursoAbreviado = @datos.cursoAbreviado
                nombreGrupo = @datos.nombreGrupo
                nombreAño = @nombreAño.substring 0, (@nombreAño.indexOf " ")

                res.push if esLab then "celda__lab" else "celda__teoria"

                # _PW1
                res.push "_#{ nombreAño }_#{ cursoAbreviado }"

                # _PW1_LB
                res.push "_#{ nombreAño }_#{ cursoAbreviado }_#{ if esLab then 'L' else '' }#{ nombreGrupo }"

                res
            cursoAbreviado: -> @datos.cursoAbreviado
            nombreGrupo: -> @datos.nombreGrupo
            esLab: -> @datos.esLab
        methods:
            resaltarCeldasGrupo: () ->
                resaltarGrupoCurso @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab
            quitarResaltadoGrupo: () ->
                removerResaltadoGrupo @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab
            activarGrupo: () ->
                resaltarGrupoCurso @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab
            desactivarGrupo: () ->
                removerResaltadoGrupo @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab
            # TODO: Hacer que el state se almacene en los elementos HTML en si
            toggleActivo: () ->
                @celdaCursoActiva = !@celdaCursoActiva
                if @celdaCursoActiva
                    @activarGrupo()
                else
                    @desactivarGrupo()


#
</script>

<style scoped lang="sass">
    $duracionTransicion: 100ms

    .celda
        white-space: pre
        font-family: "Fira Code", monospace
        cursor: pointer
        user-select: none
        transition: background-color $duracionTransicion linear, color $duracionTransicion linear

    .celda__teoria
        color: var(--colorTeoria)

    .celda__teoria:hover, .celda__teoria--resaltado, .celda__teoria--activo
        background-color: var(--colorTeoria)
        color: white

    .celda__lab
        color: var(--colorLab)

    .celda__lab:hover, .celda__lab--resaltado, .celda__lab--activo
        background-color: var(--colorLab)
        color: white

//
</style>
