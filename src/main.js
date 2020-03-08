import Vue from 'vue'
import App from './App.vue'
import VueGtag from "vue-gtag"
import router from './router'
import store from './store'
import './registerServiceWorker'
import "normalize-css"
import "./sass/Global.sass"

Vue.config.productionTip = false;

Vue.use(VueGtag, {
    config: { id: "UA-113477820-2" }
}, router);

new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app');
