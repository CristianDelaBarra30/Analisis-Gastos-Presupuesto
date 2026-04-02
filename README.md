# Análisis de Gastos y Control Presupuestario — SQL

## ¿Qué problema resuelve este proyecto?

En entornos de control de gestión financiero, los equipos necesitan responder constantemente:

- ¿Dónde se está concentrando el gasto?
- ¿Se está cumpliendo el presupuesto?
- ¿Qué cambió respecto al período anterior?

Este proyecto replica ese flujo de análisis utilizando SQL, simulando un caso real de control financiero en banca o grandes empresas.

---

## Herramientas utilizadas

- SQL — análisis principal (CTEs, JOINs, window functions como LAG y RANK)
- Excel — generación del dataset simulado
- Power BI (próximamente) — visualización de resultados

---

## Modelo de datos

El análisis se basa en dos datasets:

- `gastos`: contiene el gasto real ejecutado
- `presupuesto`: contiene el gasto planificado

Ambos datasets se integran mediante:

- categoría
- centro de costo
- fecha (nivel mensual)

Esta estructura replica el modelo utilizado en control de gestión financiero.

---

## Dataset

Dataset simulado diseñado para replicar estructuras reales de datos financieros.

Incluye:

- `categoria`
- `centro_costo`
- `fecha`
- `monto` (gasto real)
- `monto_presupuestado`
- `version_presupuesto`

---

## Calidad de datos

El dataset incluye inconsistencias controladas para simular problemas reales:

- diferencias en mayúsculas/minúsculas
- espacios en valores categóricos
- inconsistencias en centros de costo
- registros sin correspondencia entre gasto y presupuesto

---

## Metodología

El análisis se desarrolló mediante:

- limpieza y estandarización de datos usando `TRIM` y `LOWER`
- transformación de tipos mediante `CAST`
- uso de **CTEs** para estructurar consultas complejas
- aplicación de **window functions (LAG)** para análisis temporal
- uso de **JOINs** para integrar gasto real y presupuesto

---

## Análisis realizados

### Gasto total por categoría
Evaluación de la estructura de costos de la organización.

### Variación mensual
Análisis de cambios en el gasto utilizando `LAG`.

### Ranking de centros de costo
Identificación de los principales focos de gasto.

### Gasto vs Presupuesto
Comparación entre gasto real y presupuesto, permitiendo detectar desviaciones.

---

## Hallazgos principales

- Alta concentración del gasto en la categoría Personal
- Focos críticos en centros de costo específicos
- Variaciones relevantes en períodos determinados
- Diferencias entre gasto real y presupuesto que requieren análisis

---

## ¿Qué haría un controller con esto?

- Analizar desviaciones relevantes
- Priorizar control en centros de mayor impacto
- Ajustar forecast
- Escalar variaciones significativas a responsables

---

## Limitaciones

- Dataset simulado
- No incluye estacionalidad real
- No considera variables macroeconómicas

---

## Contexto profesional

Este proyecto está inspirado en procesos reales de control de gestión en banca, donde el análisis de gastos, desviaciones y presupuesto forma parte del trabajo diario.

## Próximos pasos

Se desarrollará un dashboard en Power BI para visualizar:

- gasto vs presupuesto
- variaciones mensuales
- concentración de costos

El objetivo es transformar el análisis en una herramienta de apoyo a la toma de decisiones.
