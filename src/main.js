import { createApp } from 'vue';
import App from './App.vue';
import VueGtag from "vue-gtag";
import router from './router';
import store from './store';
import "normalize.css";
import "./sass/Global.sass";
import "./sass/colores.sass";

const app = createApp(App);
app.use(router);
app.use(store);
/*
app.use(VueGtag, {
    config: {id: "UA-113477820-2"}
}, router);
 */
app.mount('#app');
