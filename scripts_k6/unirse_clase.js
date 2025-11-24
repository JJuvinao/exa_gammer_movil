import http from 'k6/http';
import { check, sleep } from 'k6';

// Configuración de la prueba
export let options = {
    vus: 10,           // Usuarios virtuales simultáneos
    iterations: 500,   // Número total de iteraciones
};

// Función principal ejecutada por cada usuario virtual
export default function () {
    // Payload de ejemplo
    let payload = JSON.stringify({
        userid: Math.floor(Math.random() * 10) + 1, // Simula distintos usuarios
        claseid: Math.floor(Math.random() * 10),    // ID de clase aleatorio
        codigo: `codigo_${Math.floor(Math.random() * 500)}` // Código de clase aleatorio
    });

    // Headers incluyendo token Bearer
    let params = {
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer <token>" // Reemplaza <token> por uno válido
        },
    };

    // Realizar la petición POST al endpoint de ingreso
    let res = http.post('https://www.apiexagammer.somee.com/api/Estudi_Clases/Ingresar', payload, params);

    // Validar que la respuesta sea 200 OK
    check(res, {
        'status es 200': (r) => r.status === 200,
        'response < 500ms': (r) => r.timings.duration < 500,
    });

    // Pausa entre iteraciones
    sleep(0.5); // medio segundo
}