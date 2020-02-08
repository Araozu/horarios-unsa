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
    import { resaltarGrupoCurso, removerResaltadoGrupo, activarGrupoCurso } from "./funcionesResaltado.coffee"

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
            resaltarCeldasGrupo: ->
                resaltarGrupoCurso @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab
            quitarResaltadoGrupo: ->
                removerResaltadoGrupo @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab
            toggleActivo: ->
                activarGrupoCurso @nombreAño, @cursoAbreviado, @nombreGrupo, @esLab


#
</script>

<style lang="sass">

    .elementoOpaco
        opacity: 0.3

//
</style>
