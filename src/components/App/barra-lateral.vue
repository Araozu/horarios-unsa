<template lang="pug">
div.lateral
    div.barra
        template(v-if="!barraOculta")
            router-link.link_github(to="/")
                h1 Horarios UNSA
            br
            v-check-box(txt="Mostrar descansos de 10m" v-model="mostrarDescansos")
            br
            v-check-box(txt="Tema oscuro" v-model="temaOscuro")
            br
            // div.info
                p
                    i Solo implementado para Ingeniería de Sistemas*
                // p {{ año }}-{{ periodo }}
                div
                    select(v-model.number="anioSeleccionado" @input="actualizarAnio($event)")
                        option 2018
                        option 2019
                        option 2020
                    select(v-model.number="periodoSeleccionado" @input="actualizarPeriodo($event)")
                        option 1
                        option 2

                // div
                    select.select_area-fac-esc(v-model="areaSeleccionada")
                        option(v-for="(_, nombre) in escuelas") {{ nombre }}

                // div
                    select.select_area-fac-esc(v-model="facultadSeleccionada")
                        option(v-for="(facultad, nombre) in escuelas[areaSeleccionada]" :value="nombre") {{ facultad.nombre }}

                // div(v-if="escuelas[areaSeleccionada][facultadSeleccionada]")
                    select.select_area-fac-esc(v-model="escuelaSeleccionada")
                        option(v-for="(escuela, nombre) in escuelas[areaSeleccionada][facultadSeleccionada].escuelas" :value="nombre")
                            | {{ escuela.nombre }}

                // div
                    a(:href="urlEscuela" target="_blank") Página de la escuela
                // p {{ datos.escuela? datos.escuela.nombre: escuela }}
            br
            router-link.link_github(to="/acerca-de/") Acerca de
            br
            a.link_github(href="https://github.com/Araozu/horarios-unsa" target="_blank").
                Código fuente en GitHub

        div.boton-ocultar(@click="fnCambiarEstadoBarra")
            span.material-icons {{ barraOculta? "keyboard_arrow_right": "keyboard_arrow_left" }}

//
</template>

<script lang="coffee">
    import {ref, computed} from "vue"
    import {useStore} from "vuex"
    import vCheckBox from "../v-checkbox.vue"
    escuelas = require "json-loader!yaml-loader!../../assets/escuelas.yaml"

    setup = =>
        store = useStore()

        escuelas = ref escuelas
        anioSeleccionado = ref 2020
        periodoSeleccionado = ref 2
        areaSeleccionada = ref "Ingenierías"
        facultadSeleccionada = ref "fips"
        escuelaSeleccionada = ref "ingenieriadesistemas"

        año = computed (=> store.state.año)
        periodo = computed (=> store.state.periodo)
        facultad = computed (=> store.state.facultad)
        escuela = computed (=> store.state.escuela)
        datos = computed (=> store.state.datos)
        urlEscuela = computed (=>
            "http://" + facultadSeleccionada.value + ".unsa.edu.pe/" + escuelaSeleccionada.value + "/")
        mostrarDescansos = computed ({
            get: -> store.state.mostrarDescansos
            set: (value) -> store.commit "cambiarMostrarDescansos", value
        })
        temaOscuro = computed({
            get: -> store.state.color == "oscuro"
            set: (value) ->
                store.commit "cambiarColor", (if value == true then "oscuro" else "claro")
        })

        actualizarAnio = (ev) =>
            valor = ev.target.value
            console.log valor
            store.commit "cambiarAnioHorario", valor

        actualizarPeriodo = (ev) =>
            valor = ev.target.value
            console.log valor
            store.commit "cambiarPeriodoHorario", valor

        {
            escuelas
            anioSeleccionado
            periodoSeleccionado
            areaSeleccionada
            facultadSeleccionada
            escuelaSeleccionada
            año
            periodo
            facultad
            escuela
            datos
            urlEscuela
            mostrarDescansos
            temaOscuro
            actualizarAnio
            actualizarPeriodo
        }

    export default {
        components: {vCheckBox}
        props:
            barraOculta:
                type: Boolean
                required: true
            fnCambiarEstadoBarra:
                type: Function
                required: true
        setup
    }

#
</script>

<style scoped lang="sass">

    .select_area-fac-esc
        width: 100%


    .boton-ocultar
        position: absolute
        bottom: 0
        left: 0
        width: 100%
        height: 3rem
        border-top: solid 1px var(--colorBorde)
        text-align: right
        display: inline-table
        box-sizing: border-box
        cursor: pointer
        opacity: 0.6
        user-select: none
        &:hover
            background-color: var(--colorHover)
            opacity: 1
        .material-icons
            display: table-cell
            vertical-align: middle
            font-size: 2rem


    .link_github
        color: var(--colorTexto)


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


    .lateral
        display: block
        position: relative
        height: 100vh
        top: 0
        box-shadow: 2px 0 5px 0 rgb(122, 122, 122)
        z-index: 1
        margin-right: 0.5rem
        background-color: var(--colorFondo)
        color: var(--colorTexto)
        // transition: background-color 250ms


    h1
        text-align: center

    h2
        margin: 0
        padding: 15px 10px

    .info
        p, div
            margin: 10px 20px
            font-family: var(--fuente-titulos)

//
</style>
