# Propuesta de Automatización de Reportes  
## Enfoque prioritario: Venta de Productos

---

### 1. El problema actual

Una parte relevante de los ingresos de la clínica proviene de la **venta de productos**.  
Sin embargo, hoy no existe una visibilidad clara y sistemática sobre:

- Qué productos específicos se están vendiendo
- Cuánto genera cada uno
- Cuáles tienen alta rotación y cuáles están estancados
- Cómo se relaciona la venta de productos con el stock disponible
- Qué profesionales impulsan más la venta de productos

Esto genera decisiones a ciegas: se reponen productos sin datos, se mantienen ítems de baja rotación y se pierde oportunidad de potenciar los que realmente mueven la caja.

---

### 2. La solución propuesta

Implementar un **sistema de reportes automatizados** que entregue, de forma periódica y confiable, información clara sobre la operación de la clínica, con especial foco en la línea de productos.

El sistema se construye sobre los datos de **Medilink** y se automatiza para que la información llegue sola (sin armado manual diario o semanal).

---

### 3. Reporte prioritario: Venta de Productos

Este es el reporte de mayor impacto económico inmediato.

#### ¿Qué mostrará?

| Vista | Qué responde |
|-------|--------------|
| **Ranking de productos** | ¿Cuáles son los 10–20 productos que más se venden (por unidades y por ingresos)? |
| **Ingresos por producto** | ¿Cuánto dinero genera cada producto y qué % representa del total de la línea? |
| **Productos de baja rotación** | ¿Qué productos casi no se venden en los últimos 30 / 60 / 90 días? |
| **Cruce Ventas vs Stock** | ¿Qué productos de alta venta tienen stock bajo? ¿Cuáles tienen mucho stock y poca venta? |
| **Venta por profesional** | ¿Qué médicos/terapeutas están impulsando más la venta de productos? |
| **Evolución temporal** | ¿Cómo se comporta la venta de productos mes a mes? |

#### Beneficio directo

- Identificar los productos que realmente sostienen el ingreso
- Detectar a tiempo productos que no rotan (capital inmovilizado)
- Evitar quiebres de stock en los productos estrella
- Tomar decisiones de compra, descontinuación y promoción con datos
- Crear incentivos o capacitaciones basadas en quién vende más productos

---

### 4. Otros reportes que se pueden sumar

Una vez resuelto el de productos, se pueden agregar de forma progresiva:

| Reporte | Utilidad principal |
|---------|--------------------|
| **Citas del día + No-shows** | Control operativo diario y recuperación de inasistencias |
| **Facturación / Recaudación** | Visibilidad diaria de ingresos y formas de pago |
| **Productividad por profesional** | Desempeño de cada médico (atenciones + venta de productos) |
| **Resumen ejecutivo semanal** | Vista gerencial con los KPIs más importantes |

---

### 5. Cómo funciona técnicamente (resumen)

1. Se extraen los datos desde Medilink (exportación a Excel o mediante API).
2. Se limpian y estructuran (especialmente el detalle de productos).
3. Se generan los reportes y/o dashboards.
4. Se automatiza la actualización y el envío (correo, carpeta compartida o Power BI).

El resultado: la información llega sola, actualizada y lista para tomar decisiones.

---

### 6. Lo que se necesita de la clínica para avanzar

Para poder construir el reporte de productos (y el resto) de forma correcta, se requiere:

**Acceso y permisos**
- Usuario con permiso para ver y exportar reportes de gestión en Medilink
- Confirmación del plan contratado (Esencial / Pro / Titanium)

**Datos clave a poder exportar**
- Detalle de **venta de productos** línea por línea (nombre del producto, cantidad, precio, fecha, profesional)
- Información de **inventario / stock** (si se utiliza el módulo)
- Citas / agenda (estado de la cita)
- Recaudación / caja
- Atenciones por profesional

**Información de contexto**
- ¿Los productos se registran como inventario, como prestaciones, o de ambas formas?
- ¿Existen categorías o familias de productos definidas?
- ¿Hay una o más sucursales?
- Persona de contacto para coordinar accesos

**Opcional pero recomendable**
- Activación de la API de Medilink (permite automatización más estable)

---

### 7. Resultado esperado

Al finalizar la implementación, la clínica contará con:

- Claridad real sobre **qué productos venden y cuánto generan**
- Reportes que se actualizan y llegan de forma automática
- Menos tiempo del equipo en armar información manualmente
- Mejor control de stock y de la línea de productos
- Base sólida para seguir sumando reportes de gestión

---

### 8. Próximo paso

Revisar juntos los puntos de la sección 6, confirmar accesos y exportaciones de prueba, y con eso armar la propuesta definitiva de alcance y plazos.

---

**Documento preparado para evaluación previa**  
Enfocado en resolver el problema de visibilidad de la línea de productos y sentar las bases de una reportería automatizada sobre Medilink.
