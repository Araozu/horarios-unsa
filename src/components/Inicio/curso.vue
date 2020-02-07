<template lang="pug">
    div.info_curso
        h4.titulo_curso(@mouseenter="resaltarTodasCeldas" @mouseleave="quitarResaltadoCeldas"
            title="Agregar curso a mi horario."
            @click.stop="agregarCursoAMiHorario"
        )
            input.marcador_curso(type="checkbox" v-model="cursoAgregado")
            span.ancho {{ curso.abreviado }} >&nbsp;
            | {{ curso.nombre }}
        table.datos
            tr
                bloque(v-for="(grupos, profesor) in teoria"
                    :grupos="grupos"
                    :profesor="profesor"
                    :nombreAño="nombreAño"
                    :abreviado="curso.abreviado"
                    :key="profesor"
                )

            tr
                template(v-if="!laboratorioVacio")
                    bloque(v-for="(grupos, profesor) in laboratorio"
                        :grupos="grupos"
                        :profesor="profesor"
                        :esLab="true"
                        :nombreAño="nombreAño"
                        :abreviado="curso.abreviado"
                        :key="profesor"
                    )

                template(v-else)
                    td
                        span.ancho | _

    //
</template>

<script lang="coffee">
    import {
        resaltarCurso
        removerResaltadoCurso
        resaltarGrupoCurso
        removerResaltadoGrupo
        obtenerClaseGrupoCurso
    } from "./tablaHorarios/funcionesResaltado.coffee"

    import bloque from "./curso/bloque"

    export default
        name: "curso"
        components: { bloque }
        data: ->
            cursoAgregado: no
        props:
            curso:
                type: Object
                required: true
            nombreAño:
                type: String
                required: true
            nombreCurso:
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
            agregarCursoAMiHorario: ->
                if @cursoAgregado
                    @cursoAgregado = false
                    @$store.commit "removerCursoMiHorario", @nombreCurso
                else
                    @cursoAgregado = true
                    nombre = @nombreCurso
                    datos = @curso
                    @$store.commit "agregarCursoAMiHorario", { nombre, datos }

            obtenerClase: (grupo, esLab) ->
                obtenerClaseGrupoCurso @nombreAño, @curso.abreviado, grupo, esLab

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

        mounted: ->
            @procesarTeoria()

#
</script>

<style scoped lang="sass">

    .marcador_curso
        display: inline-block
        margin-right: 0.45rem
        font-size: 1rem


    .titulo_curso
        display: inline-block
        cursor: pointer
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




//
</style>
