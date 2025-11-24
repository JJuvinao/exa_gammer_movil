import http from 'k6/http';
import { check, sleep } from 'k6';

// Configuración de la prueba
export let options = {
    vus: 10,           // Usuarios virtuales simultáneos
    iterations: 500,   // Número total de iteraciones
};

// Función principal ejecutada por cada usuario virtual
export default function () {
    // ID de clase aleatorio para simular distintos requests
    let claseId = Math.floor(Math.random() * 10) + 1;

    // Construir la URL con el ID
    let url = `https://www.apiexagammer.somee.com/api/Examenes/ExamenesClase/${claseId}`;

    // Headers con token Bearer
    let params = {
        headers: {
            "Authorization": "Bearer <token>", // Reemplaza <token> por uno válido
            "Content-Type": "application/json"
        },
    };

    // Realizar la petición GET
    let res = http.get(url, params);

    // Validar que la respuesta sea 200 OK
    check(res, {
        'status es 200': (r) => r.status === 200,
        'response < 500ms': (r) => r.timings.duration < 500,
    });

    // Pausa entre iteraciones
    sleep(0.5);
}

     