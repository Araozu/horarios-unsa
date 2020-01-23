<template lang="pug">
    div.contenedor
        barra-lateral
        div.der(:style="'max-height: ' + alto + 'px;'")
            router-view

    //
</template>

<script lang="coffee">
    import barraLateral from "./components/App/barra-lateral.vue"

    export default
        name: "App"
        components: { barraLateral }
        data: ->
            alto: window.innerHeight

#
</script>

<style lang="sass">

    .contenedor
        display: grid
        grid-template-columns: 400px auto

    .der
        position: relative
        top: 0
        right: 0
        overflow-y: scroll
        overflow-x: hidden


//
</style>
