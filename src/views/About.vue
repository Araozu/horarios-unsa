<template lang="pug">
div.acerca-de
    h1 Acerca de
    h2 Autor
    p Fernando Araoz Morales

    h2 Tecnologías usadas
    p Vue.js 3 - En mi opinion el mejor framework.
    p Vue router - Para manejar las rutas en el SPA.
    p Vuex - Para manejar las celdas de los horarios.
    p Pug - Para solo declarar una vez las etiquetas y evitar &lt; / &gt;
    p CoffeeScript - Para usar JavaScript más expresivo.
    p Sass - Para poder anidar los selectores.

    h2 ¿De donde salen los horarios?
    p De los excel/fotos que se publican, los transformo a mano a YAML.

    h2 ¿Dónde puedo reportar problemas?
    p En GitHub, https://github.com/Araozu/horarios-unsa.

//
</template>

<script lang="coffee">

    export default {
        name: "About"
    }

#
</script>

<style scoped lang="sass">

    .acerca-de
        margin: 0 auto
        width: 90%

//
</style>
