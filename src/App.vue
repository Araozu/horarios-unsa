<template lang="pug">
    div.contenedor
        template(v-if="ancho > 500")
            barra-lateral
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
        computed:
            alto: -> @$store.state.altoPantalla
            ancho: -> @$store.state.anchoPantalla
            año: -> @$store.state.año
            periodo: -> @$store.state.periodo
            facultad: -> @$store.state.facultad
            escuela: -> @$store.state.escuela
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
        grid-template-columns: 400px auto

    .der
        position: relative
        top: 0
        right: 0
        overflow-y: scroll
        overflow-x: hidden


    @media only screen and (max-width: 1370px)
        .contenedor
            grid-template-columns: 200px auto


    @media only screen and (max-width: 1000px)
        .contenedor
            grid-template-columns: 1.75rem auto


//
</style>
