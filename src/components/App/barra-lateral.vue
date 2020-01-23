<template lang="pug">
    div.lateral(:style="'min-height: ' + alto + 'px;'")
        h1 Horarios UNSA
        br
        br
        div.info
            p 2019-2
            p Facultad de Producción y Servicios
            p Escuela Profesional de Ingeniería de Sistemas
        br
        br
        modo-color
        h2 Inicio
        h2 Otros

    //
</template>

<script lang="coffee">
    import modoColor from "./modo-color.vue"

    export default
        name: "barra-lateral"
        components: { modoColor }
        data: ->
            alto: window.innerHeight
    
#
</script>

<style scoped lang="sass">

    .lateral
        display: block
        position: relative
        top: 0
        box-shadow: 2px 0 10px 0 lightgray

    h1
        text-align: center

    h2
        margin: 0
        padding: 15px 10px

    .info p
        margin: 10px 20px
        font-family: "Product Sans", Roboto, sans-serif

//
</style>
