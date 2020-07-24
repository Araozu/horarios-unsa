import {createRouter, createWebHistory} from 'vue-router';
import Inicio from "../views/Inicio.vue";

const routes = [
    {
        path: '/',
        name: 'Inicio',
        component: Inicio
    }
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
});

export default router;
