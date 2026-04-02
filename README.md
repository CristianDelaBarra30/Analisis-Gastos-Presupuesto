# Análisis de Gastos y Control Presupuestario — SQL

## ¿Qué problema resuelve este proyecto?

En entornos de control de gestión financiero, los equipos necesitan responder constantemente:

- ¿Dónde se está concentrando el gasto?
- ¿Se está cumpliendo el presupuesto?
- ¿Qué cambió respecto al período anterior?

Este proyecto replica ese flujo de análisis utilizando SQL, simulando un caso real de control financiero en banca o grandes empresas.

---

## Herramientas utilizadas

- **SQL** — análisis principal (CTEs, JOINs, window functions como LAG y RANK)
- **Excel** — generación del dataset y validación de resultados
- **Power BI**  — visualización de resultados

---

## Dataset

Dataset simulado que representa gastos operacionales mensuales, diseñado para replicar estructuras reales de datos financieros.

Incluye:

- `categoria` — tipo de gasto (Personal, Administración, Activo Fijo)
- `centro_costo` — área responsable del gasto
- `fecha` — período mensual
- `monto_real` — gasto ejecutado
- `monto_presupuestado` — gasto planificado

El dataset considera múltiples centros de costo y períodos, permitiendo análisis comparativos y temporales similares a entornos productivos.

Estructura del repositorio:

---

data/ → dataset en CSV
sql/ → queries organizadas por análisis
visuals/ → gráficos generados

---

## Metodología

El análisis se desarrolló mediante:

- Limpieza y estandarización de datos (TRIM, CAST, REPLACE)
- Uso de **CTEs** para modularidad y legibilidad
- Aplicación de **window functions (LAG)** para análisis de variaciones temporales
- Agregaciones para evaluación de estructura de gasto

El enfoque replica prácticas utilizadas en entornos reales con grandes volúmenes de datos y múltiples fuentes.

---

## Análisis realizados

### 1. Gasto total por categoría
Identifica la estructura de costos de la organización.

### 2. Comparación real vs presupuesto
Calcula desviaciones absolutas y porcentuales.

### 3. Variación mes a mes
Uso de `LAG()` para detectar cambios relevantes en el gasto.

### 4. Ranking de centros de costo
Identifica concentración del gasto y focos críticos.

---

## Hallazgos principales

**Alta concentración en Personal:**  
La categoría Personal representa la mayor proporción del gasto total, lo que refleja una estructura intensiva en capital humano.

**Centro crítico — Inmuebles:**  
El mayor gasto se concentra en este centro, asociado a costos de infraestructura.

**Distribución no homogénea:**  
El gasto se concentra en pocos centros, lo que indica necesidad de control focalizado.

**Peak en octubre:**  
Se observa un aumento significativo del gasto, que en un contexto real requeriría validación con eventos operacionales o ajustes contables.

---

## ¿Qué haría un controller con esto?

- Escalar desviaciones relevantes (>10%) a responsables
- Priorizar control en centros de mayor impacto
- Ajustar forecast según comportamiento observado
- Investigar causas de variaciones atípicas

---

## Visualizaciones

### Gasto por categoría
![Gasto por categoría](visuals/Gasto_por_categorias.png)

### Top centros de costo
![Top centros de costo](visuals/Centros_de_costos.png)

---

## Limitaciones

- Dataset simulado (no refleja comportamiento real completo)
- No considera estacionalidad avanzada
- No incluye efectos macroeconómicos (inflación, tipo de cambio)
- No contempla ajustes contables complejos

---

## Contexto profesional

Este proyecto está inspirado en procesos reales de control de gestión en banca, donde el análisis de gastos, desviaciones presupuestarias y variaciones mensuales forma parte del trabajo diario.

Las queries reflejan la lógica aplicada en entornos productivos utilizando SQL y plataformas como Databricks.
