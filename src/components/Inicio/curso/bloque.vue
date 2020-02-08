<template lang="pug">
    td
        span.ancho |&nbsp;
        | {{ profesor }}
        span.ancho.cursor_click(
            v-for="grupo in grupos"
                :class="obtenerClase(grupo)"
                @mouseenter="resaltarCeldasGrupo(grupo)"
                @mouseleave="quitarResaltadoGrupo(grupo)"
                @click="toggleActivo(grupo)"
        )
            |  {{ esLab? 'L': 'T' }}{{ grupo }}&nbsp;

    //
</template>

<script lang="coffee">
    import {
        obtenerClaseGrupoCurso
        resaltarGrupoCurso
        removerResaltadoGrupo
        activarGrupoCurso
        obtenerClaseCursoGeneral
    } from "../tablaHorarios/funcionesResaltado.coffee"

    export default
        name: "bloque"
        props:
            grupos:
                type: Array
                required: true
            profesor:
                type: String
                required: true
            esLab:
                type: Boolean
                default: false
            nombreAño:
                type: String
                required: true
            abreviado:
                type: String
                required: true
        methods:
            obtenerClase: (grupo) ->
                claseEspecifica = obtenerClaseGrupoCurso @nombreAño, @abreviado, grupo, @esLab
                claseGeneral = obtenerClaseCursoGeneral claseEspecifica

                [claseEspecifica, claseGeneral]

            resaltarCeldasGrupo: (grupo) ->
                resaltarGrupoCurso @nombreAño, @abreviado, grupo, @esLab

            quitarResaltadoGrupo: (grupo) ->
                removerResaltadoGrupo @nombreAño, @abreviado, grupo, @esLab
            toggleActivo: (grupo) ->
                activarGrupoCurso @nombreAño, @abreviado, grupo, @esLab

#
</script>

<style scoped lang="sass">


    .ancho
        font:
            family: "Fira Code", monospace
        user-select: none

    //
</style>