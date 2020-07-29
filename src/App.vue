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
    import {ref, computed} from "vue"
    import {useStore} from "vuex"
    import barraLateral from "./components/App/barra-lateral.vue"
    import YAML from "yaml"

    obtenerEstadoBarraLateralOculta = =>
        (localStorage?.getItem "barra-oculta") == "true"

    setup = =>
        store = useStore()

        barraLateralOculta = ref (obtenerEstadoBarraLateralOculta())
        alto = computed (=> store.state.altoPantalla)
        ancho = computed (=> store.state.anchoPantalla)
        año = computed (=> store.state.año)
        periodo = computed (=> store.state.periodo)
        facultad = computed (=> store.state.facultad)
        escuela = computed (=> store.state.escuela)
        anchoBarraLateral = computed (=>
            if barraLateralOculta.value
                {gridTemplateColumns: "2.5rem auto"}
            else
                {gridTemplateColumns: "20rem auto"}
        )

        cambiarEstadoBarraLateral = =>
            nuevoVal = !barraLateralOculta.value
            localStorage?.setItem "barra-oculta", nuevoVal
            barraLateralOculta.value = nuevoVal

        setTimeout (=>
            resRaw = await fetch "/horarios/#{año.value}_#{periodo.value}_#{facultad.value}_#{escuela.value}.yaml"
            res = YAML.parse await resRaw.text()
            store.commit "cambiarDatos", res
        ), 0

        {
            barraLateralOculta
            alto
            ancho
            año
            periodo
            facultad
            escuela
            anchoBarraLateral
            cambiarEstadoBarraLateral
        }

    export default {
        name: "App"
        components: {barraLateral}
        setup
    }

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
