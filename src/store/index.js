import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        celdas: {},
        horarioUsuario: {}
    },
    mutations: {
        registrarCelda(state, idCelda) {
            state.celdas[idCelda] = [];
        },
        agregarACelda(state, {idCelda, datos}) {
            state.celdas[idCelda].push(datos);
        },
        quitarDeCelda(state) {

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
        }
    },
    actions: {

    }
});
