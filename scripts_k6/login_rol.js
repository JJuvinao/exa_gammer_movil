import http from 'k6/http';
import { check, sleep } from 'k6';

// Configuración de la prueba
export let options = {
    vus: 10,           // Usuarios virtuales simultáneos
    iterations: 500,   // Número total de iteraciones
};

// Función principal ejecutada por cada usuario virtual
export default function () {
    // Payload de ejemplo (puedes cambiar los usuarios según tu base de prueba)
    let payload = JSON.stringify({
        username: `usuario_${Math.floor(Math.random() * 1000)}`, // Usuarios simulados
        password: "contraseña123"
    });

    // Headers
    let params = {
        headers: {
            "Content-Type": "application/json"
        },
    };

    // Realizar la petición POST al endpoint de login
    let res = http.post('https://apiexagammer.somee.com/api/Login', payload, params);

    // Validar que la respuesta sea 200 OK
    check(res, {
        'status es 200': (r) => r.status === 200,
        'response < 500ms': (r) => r.timings.duration < 500,
    });

    // Pausa entre iteraciones
    sleep(0.5); // medio segundo
}
