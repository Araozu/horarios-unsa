<template lang="pug">
    div.lateral(:style="'height: ' + alto + 'px;'")
        div.mostrar-bajo-1000.boton-lateral(:style="'height: ' + alto + 'px;'")
            div »
        div.barra
            h1 Horarios UNSA
            br
            br
            p Algún dia implementaré las demas facultades/escuelas...
            p.
                No coloqué 1er año porque me da flojera... E igual los cachimbos no
                pueden escoger horario.
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
            a(href="https://github.com/Araozu/horarios-unsa" target="_blank" style="color: white;").
                Código fuente en GitHub
            // modo-color
            // h2 Inicio
            // h2 Otros

    //
</template>

<script lang="coffee">
    import modoColor from "./modo-color.vue"
    escuelas = require "json-loader!yaml-loader!../../assets/escuelas.yaml"

    export default
        name: "barra-lateral"
        components: { modoColor }
        data: ->
            escuelas: escuelas
            añoSeleccionado: 2018
            periodoSeleccionado: 2
            areaSeleccionada: "Ingenierías"
            facultadSeleccionada: "fips"
            escuelaSeleccionada: "ingenieriadesistemas"
        computed:
            alto: -> @$store.state.altoPantalla
            año: -> @$store.state.año
            periodo: -> @$store.state.periodo
            facultad: -> @$store.state.facultad
            escuela: -> @$store.state.escuela
            datos: -> @$store.state.datos
            urlEscuela: ->
                "http://" + @facultadSeleccionada + ".unsa.edu.pe/" + @escuelaSeleccionada + "/"
        watch:
            escuelaSeleccionada: (n) ->
                console.log "Cambiado a #{n}"

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



    .lateral
        display: block
        position: relative
        top: 0
        box-shadow: 2px 0 5px 0 rgb(122, 122, 122)
        z-index: 1
        margin-right: 0.5rem


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
