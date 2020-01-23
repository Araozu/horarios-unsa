<template lang="pug">
    div.info_curso
        h4.titulo_curso(@mouseenter="resaltarTodasCeldas" @mouseleave="quitarResaltadoCeldas")
            span.ancho {{ curso.abreviado }} >&nbsp;
            | {{ curso.nombre }}
        table.datos
            tr
                td(v-for="(grupos, profesor) in teoria")
                    span.ancho |&nbsp;
                    | {{ profesor }}
                    span.ancho.cursor_click.ancho__teoria(
                        v-for="grupo in grupos"
                        @mouseenter="resaltarCeldasGrupo(grupo, false)"
                        @mouseleave="quitarResaltadoGrupo(grupo, false)")
                        |  {{ grupo }}&nbsp;

            tr
                template(v-if="!laboratorioVacio")
                    td(v-for="(grupos, profesor) in laboratorio")
                        span.ancho |&nbsp;
                        | {{ profesor }}
                        span.ancho.cursor_click.ancho__lab(
                            v-for="grupo in grupos"
                            @mouseenter="resaltarCeldasGrupo(grupo, true)"
                            @mouseleave="quitarResaltadoGrupo(grupo, true)")
                            |  L{{ grupo }}&nbsp;
                template(v-else)
                    td
                        span.ancho | _

    //
</template>

<script lang="coffee">
    import { resaltarCurso, removerResaltadoCurso, resaltarGrupoCurso, removerResaltadoGrupo } from "./tablaHorarios/funcionesResaltado.coffee"

    export default
        name: "curso"
        props:
            curso:
                type: Object
                required: true
            nombreAño:
                type: String
                required: true
        computed:
            teoria: ->
                vm = this
                profesores = {}
                for n, grupo of vm.curso.Teoria
                    docente = grupo.Docente
                    unless profesores[docente]?
                        profesores[docente] = []
                    profesores[docente].push(n)
                profesores
            laboratorio: ->
                vm = this
                profesores = {}
                for n, grupo of vm.curso.Laboratorio
                    docente = grupo.Docente
                    unless profesores[docente]?
                        profesores[docente] = []
                    profesores[docente].push(n)
                profesores
            laboratorioVacio: ->
                labs = this.laboratorio
                estaVacio = yes

                for i of labs
                    estaVacio = no
                    break

                estaVacio
        methods:
            procesarTeoria: () ->
                nombreAño = @nombreAño
                cursoAbreviado = @curso.abreviado
                curso = @curso
                nombreStore = "_" + (nombreAño.substring 0, nombreAño.indexOf " ")

                for nombreGrupo, { Horas } of curso.Teoria
                    for horaId in Horas
                        datos = { cursoAbreviado, nombreGrupo, esLab: no }
                        idCelda = nombreStore + horaId

                        @$store.commit "agregarACelda", {idCelda, datos}

                for nombreGrupo, { Horas } of curso.Laboratorio
                    for horaId in Horas
                        datos = { cursoAbreviado, nombreGrupo, esLab: yes }
                        idCelda = nombreStore + horaId

                        @$store.commit "agregarACelda", {idCelda, datos}
            resaltarTodasCeldas: () ->
                resaltarCurso @nombreAño, @curso.abreviado
            quitarResaltadoCeldas: () ->
                removerResaltadoCurso @nombreAño, @curso.abreviado
            resaltarCeldasGrupo: (grupo, esLab) ->
                resaltarGrupoCurso @nombreAño, @curso.abreviado, grupo, esLab
            quitarResaltadoGrupo: (grupo, esLab) ->
                removerResaltadoGrupo @nombreAño, @curso.abreviado, grupo, esLab

        mounted: ->
            @procesarTeoria()

#
</script>

<style scoped lang="sass">

    .titulo_curso
        display: inline-block
        cursor: default
        &:hover
            text-decoration: underline

    .info_curso
        display: inline-block
        padding: 1rem
        vertical-align: top

        h4
            margin-top: 1rem
            margin-bottom: 0.25rem

    .teoria, .laboratorio, .datos
        white-space: pre

    .ancho
        font:
            family: "Fira Code", monospace
        user-select: none

    .cursor_click
        cursor: pointer


    .ancho__teoria:hover
        background-color: var(--colorTeoria)
        color: white

    .ancho__lab:hover
        background-color: var(--colorLab)
        color: white

//
</style>
