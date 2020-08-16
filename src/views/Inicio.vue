<template lang="pug">
div.home
    h2.titulo {{ datos.titulo }}

    p(v-html="datos.descripcion? datos.descripcion: ''")

    hr

    p Puedes agregar cursos de diferentes años a tu horario.

    anio(:año="horarioUsuario" nombreAño="Mi horario")

    anio(v-for="(año, i) in datos.años" :key="i"
        :año="año" :nombreAño="i"
    )

//
</template>

<script lang="coffee">
    import {computed} from "vue"
    import {useStore} from "vuex"
    import anio from "../components/Inicio/anio.vue"
    import vCheckBox from "../components/v-checkbox.vue"
    import YAML from "yaml"

    setup = =>
        store = useStore()
        horarioUsuario = computed (=> store.state.horarioUsuario)
        datos = computed (=> store.state.datos)

        {
            horarioUsuario
            datos
        }

    export default {
        components: {anio, vCheckBox}
        setup
    }

#
</script>

