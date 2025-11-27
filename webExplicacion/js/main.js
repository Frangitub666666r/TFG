document.addEventListener("DOMContentLoaded", () => {

    const imagenes = [
        "./img/portada.png",
        "./img/godotLogo.png",
        "../imagenes/titus.png"
    ];

    let indice = 0;

    const imgCarrusel = document.getElementById("imgCarrusel");
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

    // Scroll suave
    document.querySelectorAll('.menu a').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) target.scrollIntoView({ behavior: 'smooth' });
        });
    });

    // =================================================
    // PANTALLA: INICIO / HISTORIA / PERSONAJES
    // =================================================
    const btnPersonajes = document.getElementById("menuPersonajes");
    const btnInicio = document.querySelector("#menuInicio");
    const btnHistoria = document.querySelector("#menuHistoria")
    const cajaInicio = document.getElementById("inicio");
    const personajesScreen = document.getElementById("personajesScreen");
    const listaPersonajes = document.getElementById("listaPersonajes");
    const infoPersonaje = document.getElementById("infoPersonaje");
    const historiaScreen = document.getElementById("historiaScreen")

    // Mostrar personajes
    btnPersonajes.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "none";
        personajesScreen.style.display = "block";
        listaPersonajes.style.display = "block";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen = "none";
    });

    // Volver a inicio
    btnInicio.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "block";
        personajesScreen.style.display = "none";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen = "none";
    });

    btnHistoria.addEventListener("click", (e) => {
        e.preventDefault();
        cajaInicio.style.display = "none";
        personajesScreen.style.display = "none";
        infoPersonaje.style.display = "none";
        infoPersonaje.innerHTML = "";
        historiaScreen = "block";
    });

    // Mostrar info personaje
    listaPersonajes.querySelectorAll("li").forEach(personaje => {
        personaje.addEventListener("click", () => {
            infoPersonaje.style.display = "block";
            infoPersonaje.innerHTML = personaje.dataset.info;
        });
    });

});
