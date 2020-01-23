<template lang="pug">
    td(:class="clases")
        celda-curso(v-for="(datos, i) in datosCeldas" :key="i" :datos="datos" :nombreAño="nombreAño")
    
    //
</template>

<script lang="coffee">
    import celdaCurso from "./celda-curso.vue"

    export default
        name: "celda",
        components: { celdaCurso }
        props:
            dia:
                type: String
                required: yes
            hora:
                type: String
                required: yes
            nombreAño:
                type: String
                required: yes
            nombreStore:
                type: String
                required: yes
        data: ->
            datosCeldas: []
        computed:
            identificadoresCelda: ->
                clases = []
                parteDia = @dia.substring 0, 2
                clases.push ("_" + parteDia)

                parteHora = (@hora.substring 0, 2) + (@hora.substring 3, 5)
                clases.push ("_" + parteHora)

                clases.push ("_" + parteDia + parteHora)

                nombreAño = @nombreAño
                claseAño = nombreAño.substring 0, (nombreAño.indexOf " ")
                clases.push ("_" + claseAño)

                id = "_" + claseAño + parteDia + parteHora
                clases.push id

                [id, clases]
            idCelda: -> @identificadoresCelda[0]
            clases: ->  @identificadoresCelda[1]
        methods:
            registrarCelda: -> @$store.commit "registrarCelda", @idCelda
            recuperarDatosCeldas: -> @datosCeldas = @$store.state.celdas[@idCelda]

        mounted: ->
            vm = this
            idCelda = @identificadoresCelda[0]
            promesa = new Promise (resolve) =>
                intervalo = setInterval (=>
                    unless vm.$store.state.celdas[idCelda] is undefined
                        clearInterval intervalo
                        resolve()
                ), 250

            @registrarCelda()
            await promesa
            @recuperarDatosCeldas()

#
</script>

<style scoped lang="sass">




//
</style>