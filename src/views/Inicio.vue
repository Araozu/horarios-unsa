<template lang="pug">
    div.home
        h2.titulo {{ datos.titulo }}
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
        data: ->
            datos:
                titulo: "Cargando..."
                años: {}
        created: ->
            vm = this
            resRaw = await fetch "/horarios/2018_2_fps_epis.yaml"
            res = YAML.parse await resRaw.text()
            vm.datos = res


#
</script>
