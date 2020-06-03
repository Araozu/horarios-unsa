<template lang="pug">
    div.info_curso(:style="estiloCurso")
        h4.titulo_curso(@mouseenter="resaltarTodasCeldas" @mouseleave="quitarResaltadoCeldas"

        )
            // input.marcador_curso(type="checkbox" v-model="cursoAgregado")
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

        div.acciones-cursos
            span.material-icons(@click.stop="agregarCursoAMiHorario" :title="cursoAgregado? 'Quitar': 'Agregar'")
                | {{ cursoAgregado? "remove": "add" }}


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
            esMiHorario: -> @nombreAño is "Mi horario"
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
            nombreAñoMin: ->
                nombreAño = @nombreAño
                nombreAño.substring 0, nombreAño.indexOf " "
            idCurso: ->
                if @nombreAñoMin is "Mi"
                    @nombreCurso
                else
                    "_" + @nombreAñoMin + @curso.abreviado
            cursoAgregado: ->
                cursosUsuario = @$store.state.horarioUsuario

                for idCurso, _ of cursosUsuario
                    if idCurso is @idCurso then return true

                false
            estiloCurso: ->
                if @cursoAgregado then { backgroundColor: "var(--colorHover)" }
                else {}
        methods:
            agregarCursoAMiHorario: ->
                if @cursoAgregado
                    @$store.commit "removerCursoMiHorario", @idCurso
                else
                    idCurso = @idCurso
                    nombre = @nombreCurso
                    datos = @curso
                    @$store.commit "agregarCursoAMiHorario", { nombre: idCurso, datos: datos }

            obtenerClase: (grupo, esLab) ->
                obtenerClaseGrupoCurso @nombreAño, @curso.abreviado, grupo, esLab

            procesarTeoria: () ->
                cursoAbreviado = @curso.abreviado
                curso = @curso
                nombreStore = "_" + @nombreAñoMin

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

            desprocesarTeoria: () ->
                cursoAbreviado = @curso.abreviado
                curso = @curso
                nombreStore = "_" + @nombreAñoMin

                for nombreGrupo, { Horas } of curso.Teoria
                    for horaId in Horas
                        datos = { cursoAbreviado, nombreGrupo, esLab: no }
                        idCelda = nombreStore + horaId

                        @$store.commit "quitarDeCelda", idCelda

                for nombreGrupo, { Horas } of curso.Laboratorio
                    for horaId in Horas
                        datos = { cursoAbreviado, nombreGrupo, esLab: yes }
                        idCelda = nombreStore + horaId

                        @$store.commit "quitarDeCelda", idCelda

            resaltarTodasCeldas: () ->
                resaltarCurso @nombreAño, @curso.abreviado

            quitarResaltadoCeldas: () ->
                removerResaltadoCurso @nombreAño, @curso.abreviado

        mounted: ->
            @procesarTeoria()

        beforeDestroy: ->
            @desprocesarTeoria()

#
</script>

<style scoped lang="sass">

    .acciones-cursos
        margin-top: 0.15rem
        display: inline-table
        .material-icons
            display: table-cell
            user-select: none
            cursor: pointer
            font-size: 1.5rem
            border: solid 1px transparent
            border-radius: 2px
            &:hover
                border: solid 1px var(--colorTexto)
                background-color: var(--colorHover)


    .marcador_curso
        display: inline-block
        margin-right: 0.45rem
        font-size: 1rem
        cursor: pointer


    .titulo_curso
        display: inline-block
        cursor: pointer
        &:hover
            text-decoration: underline

    .info_curso
        display: inline-block
        padding: 0.5rem 0.75rem
        vertical-align: top
        border-radius: 2px
        margin-right: 0.2rem
        margin-bottom: 0.2rem

        h4
            margin-top: 0.5rem
            margin-bottom: 0.25rem

    .teoria, .laboratorio, .datos
        white-space: pre

    .ancho
        font:
            family: "Fira Code", monospace
        user-select: none




//
</style>
