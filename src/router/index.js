import {createRouter, createWebHistory} from 'vue-router';
import Inicio from "../views/Inicio.vue";
import About from "../views/About.vue"

const routes = [
    {
        path: '/',
        name: 'Inicio',
        component: Inicio
    },
    {
        path: "/acerca-de",
        name: "About",
        component: About
    }
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
});

export default router;
