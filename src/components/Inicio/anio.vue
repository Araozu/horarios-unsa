<template lang="pug">
div
    v-checkbox(:txt="''" v-model="abierto")
    h3.titulo_anio {{ nombreAño }}
        div.reiniciar(@click="reiniciarTablaVue") Reiniciar

    div(v-show="abierto")
        tabla-horarios(:nombreAño="nombreAño")
        curso(v-for="(curso, nombre) in año" :key="nombre"
            :curso="curso"
            :nombreAño="nombreAño"
            :nombreCurso="nombre")

//
</template>

<script lang="coffee">
    import {ref} from "vue"
    import curso from "./curso.vue"
    import tablaHorarios from "./tabla-horarios.vue"
    import vCheckbox from "../v-checkbox.vue"
    import { reiniciarTabla } from "./tablaHorarios/funcionesResaltado.coffee"

    setup = (props) =>
        abierto = ref true

        reiniciarTablaVue = =>
            nombreAño = "_" + (props.nombreAño.substring 0, (props.nombreAño.indexOf " "))
            reiniciarTabla nombreAño

        {
            abierto
            reiniciarTablaVue
        }

    export default {
        name: "Anio"
        components: {curso, tablaHorarios, vCheckbox}
        props:
            año:
                type: Object
                required: true
            nombreAño:
                type: String
                required: true
        setup
    }

#
</script>

<style scoped lang="sass">

    .titulo_anio
        position: relative
        left: 35px


    .reiniciar
        margin-left: 1rem
        padding: 0.25rem
        display: inline-block
        border-radius: 3px
        background-color: var(--colorTexto)
        color: var(--colorFondo)
        cursor: pointer
        user-select: none
        opacity: 0.75
        font:
            size: 1rem
            weight: normal


//
</style>
