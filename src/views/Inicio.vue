<template lang="pug">
    div.home
        h2.titulo {{ datos.titulo }}
        p Puedes agregar cursos de diferentes años a tu horario.



        // label.container Mostrar descansos de 10m
            input(type="checkbox" v-model="$store.state.mostrarDescansos")
            span.checkmark

        // div.input-descanso
            input#descansos(type="checkbox" v-model="$store.state.mostrarDescansos")
            label(for="descansos") Mostrar descansos de 10m
        br
        br

        anio(:año="horarioUsuario" nombreAño="Mi horario")
        anio(v-for="(año, i) in datos.años" :key="i"
            :año="año" :nombreAño="i"
        )

    //
</template>

<script lang="coffee">
    import anio from "../components/Inicio/anio.vue"
    import vCheckBox from "../components/v-checkbox.vue"
    import YAML from "yaml"

    export default
        name: 'home'
        components: { anio, vCheckBox }
        computed:
            horarioUsuario: -> @$store.state.horarioUsuario
            datos: -> @$store.state.datos




#
</script>

