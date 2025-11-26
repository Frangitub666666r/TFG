document.addEventListener("DOMContentLoaded", () => {

    const imagenes = [
        "./img/portada.png",
        "./img/godotLogo.png",
        "../imagenes/titus.png"
    ];

    let indice = 0;

    var imgCarrusel = document.getElementById("imgCarrusel");
    var btnPrev = document.getElementById("btnPrev");
    var btnNext = document.getElementById("btnNext");

    function mostrarImagen(indice) {


        imgCarrusel.src = imagenes[indice]



    }

    btnNext.addEventListener("click", (e) => {
        e.preventDefault();
        indice++;
        mostrarImagen(indice);

        if (indice > imagenes.length) {
            indice = 0;
        };
    });

    btnPrev.addEventListener("click", (e) => {
        e.preventDefault();
        indice--;
        mostrarImagen(indice)

        if (indice < 0) {
            indice = 0;
        };
    });
    document.querySelectorAll('.menu a').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            target.scrollIntoView({ behavior: 'smooth' });
        });
    });

})


