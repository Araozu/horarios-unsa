<template lang="pug">
span.celda(:class="clases" :eslab="esLab? 'true': 'false'"
    @mouseenter="resaltarCeldasGrupo"
    @mouseleave="quitarResaltadoGrupo"
    @click="toggleActivo")
    | &nbsp;{{ cursoAbreviado }}
    span &nbsp;{{ (esLab? "L": "") + nombreGrupo }}&nbsp;

//
</template>

<script lang="coffee">
    import {ref, computed} from "vue"
    import {
        resaltarGrupoCurso
        removerResaltadoGrupo
        activarGrupoCursoStr
        obtenerClaseGrupoCurso
    } from "./funcionesResaltado.coffee"

    setup = (props) =>
        celdaCursoActiva = ref false

        clases = computed (=>
            res = []
            esLab = props.datos.esLab
            cursoAbreviado = props.datos.cursoAbreviado
            nombreGrupo = props.datos.nombreGrupo
            nombreAño = props.nombreAño.substring 0, (props.nombreAño.indexOf " ")

            res.push if esLab then "celda__lab" else "celda__teoria"

            # _PW1
            res.push "_#{ nombreAño }_#{ cursoAbreviado }"

            # _PW1_LB
            res.push "_#{ nombreAño }_#{ cursoAbreviado }_#{ if esLab then 'L' else '' }#{ nombreGrupo }"

            res
        )
        cursoAbreviado = computed (=> props.datos.cursoAbreviado)
        nombreGrupo = computed (=> props.datos.nombreGrupo)
        esLab = computed (=> props.datos.esLab)
        claseCursoGeneral = computed (=>
            obtenerClaseGrupoCurso props.nombreAño, cursoAbreviado.value, nombreGrupo.value, esLab.value
        )

        resaltarCeldasGrupo = =>
            resaltarGrupoCurso props.nombreAño, cursoAbreviado.value, nombreGrupo.value, esLab.value
        quitarResaltadoGrupo = =>
            removerResaltadoGrupo props.nombreAño, cursoAbreviado.value, nombreGrupo.value, esLab.value
        toggleActivo = =>
            activarGrupoCursoStr claseCursoGeneral.value

        {
            celdaCursoActiva
            clases
            cursoAbreviado
            nombreGrupo
            esLab
            claseCursoGeneral
            resaltarCeldasGrupo
            quitarResaltadoGrupo
            toggleActivo
        }

    export default {
        name: "celda-curso"
        props:
            datos:
                type: Object
                required: true
            nombreAño:
                type: String
                required: true
        setup
    }

#
</script>

<style lang="sass">

    .celda
        display: inline-block


    .elementoOpaco
        opacity: 0.3

//
</style>
