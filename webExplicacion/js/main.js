document.addEventListener("DOMContentLoaded", () => {

    const imagenes = [
        "./img/portada.png",
        "./img/godotLogo.png",
        "../imagenes/sprites/spriteTitus/titus.png",
        "../imagenes/sprites/spriteTitus/titus_avATK.png",
        "../imagenes/sprites/spriteTitus/titus_salATK.png",
        "../imagenes/sprites/spriteTitus/titus_golATK.png",
        "../imagenes/sprites/spriteTitus/titus_salATKV2.png",
        "../imagenes/EscenarioBosque.png",
        "../imagenes/sprites/Enemigos/goblin.png",
        "../imagenes/sprites/Enemigos/Worg.png"


    ];

    let indice = 0;

    const imgCarrusel = document.getElementById("img");
    const btnPrev = document.getElementById("btnPrev");
    const btnNext = document.getElementById("btnNext");

    function mostrarImagen(indice) {
        imgCarrusel.src = imagenes[indice];
    }

    btnNext.addEventListener("click", (e) => {
        e.preventDefault();
        indice++;
        if (indice >= imagenes.length) indice = 0;
        mostrarImagen(indice);
    });

    btnPrev.addEventListener("click", (e) => {
        e.preventDefault();
        indice--;
        if (indice < 0) indice = imagenes.length - 1;
        mostrarImagen(indice);
    });

    document.querySelectorAll('.menu a').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) target.scrollIntoView({ behavior: 'smooth' });
        });
    });

    // =================================================
    // PANTALLA: INICIO / HISTORIA / PERSONAJES / ACTUALIZACIONES
    // =================================================
    const btnPersonajes = document.getElementById("menuPersonajes");
    const btnInicio = document.querySelector("#menuInicio");
    const btnHistoria = document.querySelector("#menuHistoria")
    const btnActualizaciones = document.querySelector("#menuActualizaciones")
    const cajaInicio = document.getElementById("inicio");
    const personajesScreen = document.getElementById("personajesScreen");
    const listaPersonajes = document.getElementById("listaPersonajes");
    const infoPersonaje = document.getElementById("infoPersonaje");
    const historiaScreen = document.getElementById("historiaScreen");
    const actualizacionesScreen = document.querySelector("#actualizacionesScreen")

    // Mostrar personajes
    btnPersonajes.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "none";
        personajesScreen.style.display = "block";
        listaPersonajes.style.display = "block";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen.style.display = "none";
        actualizacionesScreen.style.display = "none";
    });

    // Volver a inicio
    btnInicio.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "block";
        personajesScreen.style.display = "none";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen.style.display = "none";
        actualizacionesScreen.style.display = "none";
    });
    // Mostrar la sinopsis
    btnHistoria.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "none";
        personajesScreen.style.display = "none";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen.style.display = "block";
        actualizacionesScreen.style.display = "none";

    });

    // Mostrar actualizaciones

    btnActualizaciones.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "none";
        personajesScreen.style.display = "none";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen.style.display = "none";
        actualizacionesScreen.style.display = "block";
    });


    // Mostrar info personaje
    listaPersonajes.querySelectorAll("li").forEach(personaje => {
        personaje.addEventListener("click", () => {
            infoPersonaje.style.display = "block";
            infoPersonaje.innerHTML = personaje.dataset.info;
        });
    });

    // =================================================
    // LÓGICA DEL FORMULARIO DE SUGERENCIAS
    // =================================================
    const formSugerencias = document.getElementById("formSugerencias");
    const mensajeExito = document.getElementById("mensajeExito");
    const btnEnviar = document.getElementById("btnEnviarSugerencia");

    if (formSugerencias) {
        formSugerencias.addEventListener("submit", (e) => {
            e.preventDefault(); // Evita que la página se recargue

            // 1. Simulación visual de envío
            const textoOriginal = btnEnviar.innerText;
            btnEnviar.innerText = "ENVIANDO...";
            btnEnviar.disabled = true;
            btnEnviar.style.backgroundColor = "#555"; // Gris mientras carga

            // 2. Simular retardo de red (1.5 segundos)
            setTimeout(() => {
                // Aquí iría el código real para enviar a backend si lo tuvieras
                // Por ahora, solo limpiamos y mostramos éxito
                
                formSugerencias.reset(); // Limpia el area de texto
                
                // Restaurar botón
                btnEnviar.innerText = textoOriginal;
                btnEnviar.disabled = false;
                btnEnviar.style.backgroundColor = "rgb(255, 102, 0)";

                // Mostrar mensaje de éxito
                mensajeExito.style.display = "block";

                // Ocultar mensaje de éxito después de 4 segundos
                setTimeout(() => {
                    mensajeExito.style.display = "none";
                }, 4000);

            }, 1500);
        });
    }
});
