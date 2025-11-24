import http from 'k6/http';
import { check, sleep } from 'k6';

// Configuración de la prueba
export let options = {
    vus: 10,
    duration: '60s',  // prueba más larga
};

export default function () {
    // Payload de ejemplo
    let payload = JSON.stringify({
        nombre: "Nombre de la clase",
        tema: "Tema de la clase",
        autor: "Autor de la clase",
        imagenClase: "https://midominio.com/imagen.png",
        id_Profe: 1
    });

    // Headers incluyendo token Bearer
    let params = {
        headers: {
            "Authorization": "Bearer <token>",
            "Content-Type": "application/json"
        },
    };

    // Realizar la petición POST
    let res = http.post('https://www.apiexagammer.somee.com/api/Clases/ClasePost', payload, params);

    // Validar que la respuesta sea 200 OK
    check(res, {
        'status es 200': (r) => r.status === 200,
        'response < 500ms': (r) => r.timings.duration < 500,
    });

    sleep(1); // Pausa de 1 segundo entre iteraciones
}