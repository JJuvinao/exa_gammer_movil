import http from 'k6/http';
import { check, sleep } from 'k6';

// Configuración de la prueba
export let options = {
    vus: 10,           // Usuarios virtuales simultáneos
    duration: '60s',   // Número total de iteraciones (requests)
};

// Función principal que se ejecuta por cada usuario virtual
export default function () {
    // Payload de ejemplo
    let payload = JSON.stringify({
        username: `usuario_${Math.floor(Math.random() * 1000)}`, // Genera usuarios distintos
        password: "contraseña123",
        rol: "usuario",
        correo: `correo_${Math.floor(Math.random() * 1000)}@example.com`, // Correo distinto por request
        img: "assets/imagen/fotoperfil.png"
    });

    // Headers
    let params = {
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
    };

    // Realizar la petición POST
    let res = http.post('https://www.apiexagammer.somee.com/api/Usuarios/Registro', payload, params);

    // Validar que la respuesta sea 200 OK
    check(res, {
        'status es 200': (r) => r.status === 200,
        'response < 500ms': (r) => r.timings.duration < 500,
    });

    // Pausa entre iteraciones
    sleep(0.5); // medio segundo
}