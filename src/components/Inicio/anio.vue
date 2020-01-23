<template lang="pug">
    div
        h3 {{ nombreAño }}

        tabla-horarios(:nombreAño="nombreAño")
        curso(v-for="(curso, nombre) in año" :key="nombre"
            :curso="curso"
            :nombreAño="nombreAño"
            :nombreCurso="nombre")

    //
</template>

<script lang="coffee">
    import curso from "./curso.vue"
    import tablaHorarios from "./tabla-horarios.vue"

    export default
        name: "Anio"
        components: { curso, tablaHorarios }
        props:
            año:
                type: Object
                required: true
            nombreAño:
                type: String
                required: true
    
#
</script>

<style scoped lang="sass">


//
</style>