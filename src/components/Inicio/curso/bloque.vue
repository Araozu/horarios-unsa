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
        | &nbsp;{{ esLab? 'L': 'T' }}{{ grupo }}&nbsp;

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

    setup = (props) =>

        obtenerClase = (grupo) =>
            claseEspecifica = obtenerClaseGrupoCurso props.nombreAño, props.abreviado, grupo, props.esLab
            claseGeneral = obtenerClaseCursoGeneral claseEspecifica

            [claseEspecifica, claseGeneral]

        resaltarCeldasGrupo = (grupo) =>
            resaltarGrupoCurso props.nombreAño, props.abreviado, grupo, props.esLab

        quitarResaltadoGrupo = (grupo) =>
            removerResaltadoGrupo props.nombreAño, props.abreviado, grupo, props.esLab
        toggleActivo = (grupo) =>
            activarGrupoCurso props.nombreAño, props.abreviado, grupo, props.esLab

        {
            obtenerClase
            resaltarCeldasGrupo
            quitarResaltadoGrupo
            toggleActivo
        }

    export default {
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
        setup
    }

#
</script>

<style scoped lang="sass">

    .ancho
        font:
            family: "JetBrains Mono", monospace
        user-select: none

    //
</style>
