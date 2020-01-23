<template lang="pug">
    form(@submit.prevent)
        label(for="selector_modo_color") Modo de color:
        br
        select#selector_modo_color(v-model="opcion")
            option(selected) Claro
            option Oscuro
    
    //
</template>

<script lang="coffee">

    export default
        name: "modo-color"
        data: ->
            opcion: "Claro"
        watch:
            opcion: (nuevo) ->
                console.log "Cambiado a #{nuevo}"
    
#
</script>

<style scoped lang="sass">


//
</style>