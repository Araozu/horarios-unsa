<template lang="pug">
    div.lateral
        div.mostrar-bajo-1000.boton-lateral
            div »
        div.barra
            template(v-if="!barraOculta")
                h1 Horarios UNSA
                br
                br
                p Los horarios están completos. Fuente:
                a.link_github(href="https://drive.google.com/file/d/1DqAkbDtcVjAWhEb6YwMpFWUkXGpgeQt1/view"
                    target="_blank")
                    | Google Drive
                br
                br
                v-check-box(txt="Mostrar descansos de 10m" v-model="mostrarDescansos")
                br
                v-check-box(txt="Tema oscuro" v-model="temaOscuro")
                // div.info
                    p
                        i Solo algunos horarios están implementados*
                    // p {{ año }}-{{ periodo }}
                    div
                        select(v-model.number="añoSeleccionado")
                            option 2018
                            option 2019
                            option 2020
                        select(v-model.number="periodoSeleccionado")
                            option 1
                            option 2

                    // p {{ datos.facultad? datos.facultad.nombre: facultad }}
                    div
                        select(v-model="areaSeleccionada")
                            option(v-for="(_, nombre) in escuelas") {{ nombre }}

                    div
                        select(v-model="facultadSeleccionada")
                            option(v-for="(facultad, nombre) in escuelas[areaSeleccionada]" :value="nombre") {{ facultad.nombre }}

                    div(v-if="escuelas[areaSeleccionada][facultadSeleccionada]")
                        select(v-model="escuelaSeleccionada")
                            option(v-for="(escuela, nombre) in escuelas[areaSeleccionada][facultadSeleccionada].escuelas" :value="nombre")
                                | {{ escuela.nombre }}

                    div
                        a(:href="urlEscuela" target="_blank") Página de la escuela
                    // p {{ datos.escuela? datos.escuela.nombre: escuela }}
                br
                br
                a.link_github(href="https://github.com/Araozu/horarios-unsa" target="_blank").
                    Código fuente en GitHub

            div.boton-ocultar(@click="fnCambiarEstadoBarra")
                span.material-icons {{ barraOculta? "keyboard_arrow_right": "keyboard_arrow_left" }}

    //
</template>

<script lang="coffee">
    import vCheckBox from "../v-checkbox.vue"
    escuelas = require "json-loader!yaml-loader!../../assets/escuelas.yaml"

    export default
        name: "barra-lateral"
        components: { vCheckBox }
        data: ->
            escuelas: escuelas
            añoSeleccionado: 2018
            periodoSeleccionado: 2
            areaSeleccionada: "Ingenierías"
            facultadSeleccionada: "fips"
            escuelaSeleccionada: "ingenieriadesistemas"
        props:
            barraOculta:
                type: Boolean
                required: true
            fnCambiarEstadoBarra:
                type: Function
                required: true
        computed:
            año: -> @$store.state.año
            periodo: -> @$store.state.periodo
            facultad: -> @$store.state.facultad
            escuela: -> @$store.state.escuela
            datos: -> @$store.state.datos
            urlEscuela: ->
                "http://" + @facultadSeleccionada + ".unsa.edu.pe/" + @escuelaSeleccionada + "/"
            mostrarDescansos:
                get: -> @$store.state.mostrarDescansos
                set: (value) -> @$store.commit "cambiarMostrarDescansos", value
            temaOscuro:
                get: -> @$store.state.color == "oscuro"
                set: (value) ->
                    @$store.commit "cambiarColor",
                        if value == true then "oscuro"
                        else "claro"

        watch:
            escuelaSeleccionada: (n) ->
                console.log "Cambiado a #{n}"

#
</script>

<style scoped lang="sass">

    .boton-ocultar
        position: absolute
        bottom: 0
        left: 0
        width: 100%
        height: 3rem
        border-top: solid 1px var(--colorBorde)
        text-align: right
        display: inline-table
        padding-right: 1rem
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
            font-family: "Product Sans", Roboto, sans-serif



    @media only screen and (max-width: 1000px)
        .barra
            position: absolute
            right: 2rem

        .lateral
            overflow-y: scroll

//
</style>
