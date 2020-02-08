import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
    state: {
        celdas: {},
        horarioUsuario: {},
        anchoPantalla: window.innerWidth,
        altoPantalla: window.innerHeight
    },
    mutations: {
        registrarCelda(state, idCelda) {
            state.celdas[idCelda] = [];
        },
        agregarACelda(state, {idCelda, datos}) {
            state.celdas[idCelda].push(datos);
        },
        quitarDeCelda(state, idCelda) {
            const ref = state.celdas[idCelda];
            while (ref.length > 0) ref.pop()
        },
        agregarCursoAMiHorario(state, {nombre, datos} ) {
            if (!state.horarioUsuario[nombre]) {
                state.horarioUsuario[nombre] = datos;
                state.horarioUsuario = Object.assign({}, state.horarioUsuario);
            }
        },
        removerCursoMiHorario(state, nombre) {
            delete state.horarioUsuario[nombre];
            state.horarioUsuario = Object.assign({}, state.horarioUsuario);
        },
        registrarListenerTamanoPantalla(state) {
            window.addEventListener("resize", (ev) => {
                state.anchoPantalla = window.innerWidth;
                state.altoPantalla  = window.innerHeight
            });
        }
    },
    actions: {

    }
});

store.commit("registrarListenerTamanoPantalla");

export default store;