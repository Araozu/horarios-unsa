<template lang="pug">
    div
        h3 {{ nombreAño }}
            div.reiniciar(@click="reiniciarTablaVue") Reiniciar

        tabla-horarios(:nombreAño="nombreAño")
        curso(v-for="(curso, nombre) in año" :key="nombre"
            :curso="curso"
            :nombreAño="nombreAño"
            :nombreCurso="nombre")

    //
</template>

<script lang="coffee">
    import curso from "./curso.vue"
    import tablaHorarios from "./tabla-horarios.vue"
    import { reiniciarTabla } from "./tablaHorarios/funcionesResaltado.coffee"

    export default
        name: "Anio"
        components: { curso, tablaHorarios }
        props:
            año:
                type: Object
                required: true
            nombreAño:
                type: String
                required: true
        methods:
            reiniciarTablaVue: ->
                nombreAño = "_" + (@nombreAño.substring 0, (@nombreAño.indexOf " "))
                reiniciarTabla nombreAño

#
</script>

<style scoped lang="sass">

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