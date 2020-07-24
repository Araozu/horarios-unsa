import Vuex from 'vuex'

const cambiarModoColor = modo => {
    const clases = document.body.classList;

    bucle: for (const pos in clases) {
        if (clases.hasOwnProperty(pos)) {
            const clase =  clases[pos];

            switch (clase) {
                case "tema-claro":
                case "tema-oscuro": {
                    clases.remove(clase);
                    break bucle;
                }
            }

        }
    }

    clases.add(modo);
};

export default Vuex.createStore({
    state: {
        celdas: {},
        horarioUsuario: {},
        anchoPantalla: window.innerWidth,
        altoPantalla: window.innerHeight,
        año: 2020,
        periodo: 1,
        facultad: "fps",
        escuela: "ingenieriadesistemas",
        datos: {
            titulo: "Cargando...",
            años: {}
        },
        mostrarDescansos: true,
        color: (() => {
            const modo = localStorage.getItem("color") || "oscuro";
            cambiarModoColor(`tema-${ modo }`);
            return modo
        })()
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
        },
        cambiarDatos(state, datos) {
            state.datos = datos;
        },
        cambiarMostrarDescansos(state, dato) {
            state.mostrarDescansos = !!dato
        },
        cambiarColor (state, valor) {
            state.color = valor;
            cambiarModoColor(`tema-${valor}`);
            localStorage.setItem("color", valor);
        }
    },
    actions: {},
    modules: {}
});

// TODO: Mover esto al componente App
// store.commit("registrarListenerTamanoPantalla");
