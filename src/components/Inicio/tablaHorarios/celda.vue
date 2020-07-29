<template lang="pug">
td(:class="clases")
    celda-curso(v-for="(datos, i) in datosCeldas" :key="i" :datos="datos" :nombreAño="nombreAño")

//
</template>

<script lang="coffee">
    import {ref, computed, onMounted} from "vue"
    import {useStore} from "vuex"
    import celdaCurso from "./celda-curso.vue"

    setup = (props) =>
        store = useStore()

        datosCeldas = ref []

        identificadoresCelda = computed (=>
            clases = []
            parteDia = props.dia.substring 0, 2
            clases.push ("_" + parteDia)

            parteHora = (props.hora.substring 0, 2) + (props.hora.substring 3, 5)
            clases.push ("_" + parteHora)

            clases.push ("_" + parteDia + parteHora)

            nombreAño = props.nombreAño
            claseAño = nombreAño.substring 0, (nombreAño.indexOf " ")
            clases.push ("_" + claseAño)

            id = "_" + claseAño + parteDia + parteHora
            clases.push id

            [id, clases]
        )
        idCelda = computed (=> identificadoresCelda.value[0])
        clases = computed (=> identificadoresCelda.value[1])

        registrarCelda = => store.commit "registrarCelda", idCelda.value
        recuperarDatosCeldas = => datosCeldas.value = store.state.celdas[idCelda.value]

        onMounted (=>
            promesa = new Promise (resolve) =>
                intervalo = setInterval (=>
                    unless store.state.celdas[idCelda.value] is undefined
                        clearInterval intervalo
                        resolve()
                ), 250

            registrarCelda()
            await promesa
            recuperarDatosCeldas()
        )

        {
            datosCeldas
            identificadoresCelda
            idCelda
            clases
        }

    export default {
        name: "celda",
        components: {celdaCurso}
        props:
            dia:
                type: String
                required: true
            hora:
                type: String
                required: true
            nombreAño:
                type: String
                required: true
            nombreStore:
                type: String
                required: true
        setup
    }

#
</script>

