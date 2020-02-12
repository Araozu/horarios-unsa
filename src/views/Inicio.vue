<template lang="pug">
    div.home
        h2.titulo {{ datos.titulo }}
        p Puedes agregar cursos de diferentes años a tu horario.
        anio(:año="horarioUsuario" nombreAño="Mi horario")
        anio(v-for="(año, i) in datos.años" :key="i"
            :año="año" :nombreAño="i"
        )

    //
</template>

<script lang="coffee">
    import anio from "../components/Inicio/anio.vue"
    import YAML from "yaml"

    export default
        name: 'home'
        components: { anio }
        computed:
            horarioUsuario: -> @$store.state.horarioUsuario
            datos: -> @$store.state.datos


#
</script>
