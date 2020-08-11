<template lang="pug">
div.info_curso(:style="estiloCurso")
    div(:style="cursoOculto? {opacity: '0.5'}: {}")
        h4.titulo_curso(@mouseenter="resaltarTodasCeldas" @mouseleave="quitarResaltadoCeldas")
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
        span.material-icons(@click.stop="ocultar_mostrarCursoV" :title="cursoOculto? 'Mostrar': 'Ocultar'")
            | {{ cursoOculto? 'visibility_off': 'visibility' }}


//
</template>

<script lang="coffee">
    import {ref, computed, onMounted, onUnmounted} from "vue"
    import {useStore} from "vuex"
    import {
        resaltarCurso
        removerResaltadoCurso
        resaltarGrupoCurso
        removerResaltadoGrupo
        obtenerClaseGrupoCurso
        ocultar_mostrarCurso
    } from "./tablaHorarios/funcionesResaltado.coffee"
    import bloque from "./curso/bloque"

    setup = (props) =>
        store = useStore()
        cursoOculto = ref false

        esMiHorario = computed (=> props.nombreAño is "Mi horario")
        teoria = computed (=>
            profesores = {}
            for n, grupo of props.curso.Teoria
                docente = grupo.Docente
                unless profesores[docente]?
                    profesores[docente] = []
                profesores[docente].push(n)
            profesores
        )
        laboratorio = computed (=>
            profesores = {}
            for n, grupo of props.curso.Laboratorio
                docente = grupo.Docente
                unless profesores[docente]?
                    profesores[docente] = []
                profesores[docente].push(n)
            profesores
        )
        laboratorioVacio = computed (=>
            labs = laboratorio.value
            estaVacio = yes

            for i of labs
                estaVacio = no
                break

            estaVacio
        )
        nombreAñoMin = computed (=>
            nombreAño = props.nombreAño
            nombreAño.substring 0, nombreAño.indexOf " "
        )
        idCurso = computed (=>
            if nombreAñoMin.value is "Mi"
                props.nombreCurso
            else
                "_" + nombreAñoMin.value + props.curso.abreviado
        )
        cursoAgregado = computed (=>
            cursosUsuario = store.state.horarioUsuario

            for idCurso, _ of cursosUsuario
                if idCurso is idCurso.value then return true

            false
        )
        estiloCurso = computed (=>
            if cursoAgregado.value then { backgroundColor: "var(--colorHover)" }
            else {}
        )

        agregarCursoAMiHorario = =>
            if cursoAgregado.value
                store.commit "removerCursoMiHorario", idCurso.value
            else
                store.commit "agregarCursoAMiHorario", {
                    nombre: idCurso.value
                    datos: props.curso
                }

        ocultar_mostrarCursoV = =>
            cursoOculto.value = !cursoOculto.value
            ocultar_mostrarCurso props.nombreAño, props.curso.abreviado

        obtenerClase = (grupo, esLab) =>
            obtenerClaseGrupoCurso props.nombreAño, props.curso.abreviado, grupo, esLab

        procesarTeoria = =>
            cursoAbreviado = props.curso.abreviado
            curso = props.curso
            nombreStore = "_" + nombreAñoMin.value

            for nombreGrupo, { Horas } of curso.Teoria
                for horaId in Horas
                    datos = { cursoAbreviado, nombreGrupo, esLab: false }
                    idCelda = nombreStore + horaId

                    store.commit "agregarACelda", {idCelda, datos}

            for nombreGrupo, { Horas } of curso.Laboratorio
                for horaId in Horas
                    datos = { cursoAbreviado, nombreGrupo, esLab: true }
                    idCelda = nombreStore + horaId

                    store.commit "agregarACelda", {idCelda, datos}

        desprocesarTeoria = =>
            cursoAbreviado = props.curso.abreviado
            curso = props.curso
            nombreStore = "_" + nombreAñoMin.value

            for nombreGrupo, { Horas } of curso.Teoria
                for horaId in Horas
                    datos = { cursoAbreviado, nombreGrupo, esLab: no }
                    idCelda = nombreStore + horaId

                    store.commit "quitarDeCelda", idCelda

            for nombreGrupo, { Horas } of curso.Laboratorio
                for horaId in Horas
                    datos = { cursoAbreviado, nombreGrupo, esLab: yes }
                    idCelda = nombreStore + horaId

                    store.commit "quitarDeCelda", idCelda

        resaltarTodasCeldas = =>
            resaltarCurso props.nombreAño, props.curso.abreviado

        quitarResaltadoCeldas = =>
            removerResaltadoCurso props.nombreAño, props.curso.abreviado

        onMounted procesarTeoria

        onUnmounted desprocesarTeoria

        {
            cursoOculto
            esMiHorario
            teoria
            laboratorio
            laboratorioVacio
            nombreAñoMin
            idCurso
            cursoAgregado
            estiloCurso
            agregarCursoAMiHorario
            obtenerClase
            procesarTeoria
            desprocesarTeoria
            resaltarTodasCeldas
            quitarResaltadoCeldas
            ocultar_mostrarCursoV
        }

    export default {
        name: "curso"
        components: {bloque}
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
        setup
    }

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
            family: var(--fuente-monoespacio)
        user-select: none

//
</style>
