<template lang="pug">
div.contenedor(:style="anchoBarraLateral")
    template(v-if="ancho > 500")
        barra-lateral(:barraOculta="barraLateralOculta" :fnCambiarEstadoBarra="cambiarEstadoBarraLateral")
        div.der(:style="'max-height: ' + alto + 'px;'")
            router-view
    template(v-else)
        br
        div
            h1 Horarios UNSA
            p Parece que estás usando un celular.
            p Rota tu celular para poder usar el sistema de horarios.
            p.
                Recomendamos un computador o laptop para obtener
                el funcionamiento completo.


//
</template>

<script lang="coffee">
    import barraLateral from "./components/App/barra-lateral.vue"
    import YAML from "yaml"

    export default
        name: "App"
        components: { barraLateral }
        data: ->
            barraLateralOculta: false
        computed:
            alto: -> @$store.state.altoPantalla
            ancho: -> @$store.state.anchoPantalla
            año: -> @$store.state.año
            periodo: -> @$store.state.periodo
            facultad: -> @$store.state.facultad
            escuela: -> @$store.state.escuela
            anchoBarraLateral: ->
                if @barraLateralOculta then { gridTemplateColumns: "4rem auto" }
                else { gridTemplateColumns: "20rem auto" }
        methods:
            cambiarEstadoBarraLateral: ->
                @barraLateralOculta = !@barraLateralOculta
        created: ->
            vm = this
            resRaw = await fetch "/horarios/#{@año}_#{@periodo}_#{@facultad}_#{@escuela}.yaml"
            res = YAML.parse await resRaw.text()
            @$store.commit "cambiarDatos", res

#
</script>

<style lang="sass">

    .contenedor
        display: grid
        grid-template-columns: 20rem auto
        background-color: var(--colorFondo)
        color: var(--colorTexto)
        // transition: background-color 250ms

    .der
        position: relative
        top: 0
        right: 0
        overflow-y: scroll
        overflow-x: hidden


    @media only screen and (max-width: 1370px)
        .contenedor
            grid-template-columns: 16rem auto


    @media only screen and (max-width: 1000px)
        .contenedor
            grid-template-columns: 1.75rem auto


//
</style>
