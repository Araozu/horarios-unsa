<template lang="pug">
table.tabla_horario(border="1")
    thead
        tr
            td Hora
            td(v-for="dia in dias") {{ dia }}
    tbody
        template(v-for="hora in horas")
            tr.fila(v-show="!(horasDescanso.find(x => x === hora)) || $store.state.mostrarDescansos")
                td
                    span {{ hora.substring(0, 5) }}
                    span.ocultar-en-movil {{ hora.substr(5) }}
                celda(v-for="(dia, i) in dias" :key="i"
                    :dia="dia"
                    :hora="hora"
                    :nombreAño="nombreAño"
                    :nombreStore="nombreStore")

//
</template>

<script lang="coffee">
    import {ref, computed} from "vue"
    import celda from "./tablaHorarios/celda.vue"

    setup = (props) =>
        dias = ref ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"]
        horas = ref [
            "07:00 - 07:50"
            "07:50 - 08:40"
            "08:40 - 08:50"
            "08:50 - 09:40"
            "09:40 - 10:30"
            "10:30 - 10:40"
            "10:40 - 11:30"
            "11:30 - 12:20"
            "12:20 - 13:10"
            "13:10 - 14:00"
            "14:00 - 14:50"
            "14:50 - 15:40"
            "15:40 - 15:50"
            "15:50 - 16:40"
            "16:40 - 17:30"
            "17:30 - 17:40"
            "17:40 - 18:30"
            "18:30 - 19:20"
            "19:20 - 20:10"
        ]
        horasDescanso = ref [
            "08:40 - 08:50"
            "10:30 - 10:40"
            "15:40 - 15:50"
            "17:30 - 17:40"
        ]

        nombreStore = computed (=> "_" + props.nombreAño.substring 0, (props.nombreAño.indexOf " "))

        {
            dias
            horas
            horasDescanso
            nombreStore
        }

    export default {
        name: "tabla-horarios"
        components: {celda}
        props:
            nombreAño:
                type: String
                required: true
        setup
    }

#
</script>

<style scoped lang="sass">

    .fila:hover
        background-color: var(--colorFondoFila)


    .tabla_horario
        width: 100%
        border-color: var(--colorBorde) // rgba(135, 135, 135, 0.51)
        border: none
        tr
            vertical-align: middle
            text-align: center
            td:first-child
                width: 8rem
        td
            border: solid 1px var(--colorBorde)


    @media only screen and (max-width: 700px)
        .ocultar-en-movil
            display: none



//
</style>
