<template lang="pug">
    div.lateral(:style="'height: ' + alto + 'px;'")
        div.mostrar-bajo-1000.boton-lateral(:style="'height: ' + alto + 'px;'")
            div »
        div.barra
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
        computed:
            alto: -> @$store.state.altoPantalla
    
#
</script>

<style scoped lang="sass">

    .boton-lateral
        position: absolute
        left: 0
        top: 0
        display: table
        font-size: 2.5rem
        width: 1.75rem

        div
            display: table-cell
            vertical-align: middle


    .barra
        position: absolute
        right: 2rem



    .lateral
        display: block
        position: relative
        top: 0
        box-shadow: 2px 0 10px 0 lightgray
        overflow-y: scroll

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
