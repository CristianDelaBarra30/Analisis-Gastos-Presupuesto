# 📊 Análisis de Gastos y Control Presupuestario

**SQL + Power BI** | Simulación de entorno real en banca

---

## Contexto del Negocio

En entornos bancarios y corporativos, el control de gastos operacionales es un proceso crítico que involucra múltiples fuentes de datos, versiones de presupuesto (Budget, Forecast Q1, Forecast Q2) y responsables distribuidos por centros de costo.

Este proyecto simula ese entorno: un dataset con los problemas de calidad de datos típicos de un sistema real, un proceso de limpieza documentado en SQL, y un dashboard de control presupuestario en Power BI orientado a la toma de decisiones.

La lógica de negocio está inspirada en procesos reales de control de gestión en banca: análisis de gastos operacionales por GMD (Personal, Administración, Activo Fijo), control por centros de costo y detección de desviaciones presupuestarias relevantes.

---

## Problema de Negocio

> **¿Qué categorías y centros de costo están desviándose del presupuesto, y cuál es el comportamiento del gasto mes a mes?**

Objetivos específicos:
1. Limpiar y estandarizar datos con errores de ingreso (inconsistencias de nomenclatura, formatos mixtos, registros mal codificados)
2. Comparar gasto real vs. presupuesto por categoría, centro de costo y mes
3. Identificar variaciones mensuales y centros de costo con mayor concentración de gasto
4. Presentar los resultados en un dashboard ejecutivo para control presupuestario

---

## Dataset

Dos tablas con **5.000 registros cada una**, generadas con errores deliberados para simular datos de producción:

### `Gastos.csv`
| Campo | Tipo | Descripción |
|---|---|---|
| id_gasto | INT | Identificador único |
| fecha | DATE | Fecha del gasto |
| centro_costo | VARCHAR | Centro de costo (con errores de formato) |
| categoria | VARCHAR | Categoría del gasto (con inconsistencias) |
| subcategoria | VARCHAR | Subcategoría (Sueldos, Bonos, Arriendos, Servicios, Equipos, Infraestructura) |
| monto | VARCHAR | Monto (con formatos mixtos: puntos de miles, espacios, sin formato) |

### `Presupuesto.csv`
| Campo | Tipo | Descripción |
|---|---|---|
| categoria | VARCHAR | Categoría presupuestada (con variantes) |
| centro_costo | VARCHAR | Centro de costo (con guiones y espacios extra) |
| fecha | DATE | Mes del presupuesto |
| monto_presupuestado | VARCHAR | Monto (con formatos mixtos) |
| version_presupuesto | VARCHAR | Budget / Forecast Q1 / Forecast Q2 |

### Errores deliberados en el dataset

Estos errores fueron introducidos intencionalmente para replicar los problemas de calidad de datos típicos de sistemas productivos:

| Tipo de error | Ejemplos encontrados |
|---|---|
| Categorías inconsistentes | `"Personal"`, `"PERSONAL"`, `"personal"`, `" Personal"` (con espacio) |
| Abreviaturas no estándar | `"AF"`, `"ACTIVO FIJO"`, `"Activo Fijo"` para la misma categoría |
| Variantes tipográficas | `"ADMIN"`, `"ADMINISTRACION"`, `"Administración"`, `"ADMINSITRACION"` |
| Centros de costo mal formateados | `"TEC-001"`, `"TEC0-01"`, `"TEC-002"`, `"MKT-001"` |
| Centros fantasma en presupuesto | `"TI999"`, `"MK0123"`, `"TEC1213"` — códigos inexistentes en gastos reales |
| Montos con formato inconsistente | `" 1.070.651 "`, `"2366064"`, `"294539"` |
| Espacios extra en campos | `" Activo Fijo "`, `"TEC002 "`, `" MKT002"` |

> **El proceso de limpieza es parte central del análisis.** Sin normalizar estas inconsistencias, los JOINs entre tablas fallan silenciosamente y los totales son incorrectos.

---

## Metodología

```
Datos brutos (CSV) → Limpieza SQL → Análisis SQL → Dashboard Power BI
```

---

## SQL — Paso a Paso

### 1. Limpieza y Normalización

`TRIM()` y `LOWER()` solos no son suficientes. El dataset tiene abreviaturas (`AF`, `ADMIN`) que requieren mapeo explícito. Sin esto, el JOIN entre gastos y presupuesto pierde registros sin advertencia, generando falsos positivos de desviación.

```sql
SELECT
    CASE 
        WHEN TRIM(LOWER(categoria)) IN ('admin', 'administracion', 'administración') 
             THEN 'administración'
        WHEN TRIM(LOWER(categoria)) IN ('af', 'activo fijo', 'activo_fijo', 'activo fijo') 
             THEN 'activo fijo'
        WHEN TRIM(LOWER(categoria)) IN ('personal', ' personal') 
             THEN 'personal'
        ELSE TRIM(LOWER(categoria))
    END AS categoria,
    REPLACE(TRIM(LOWER(centro_costo)), '-', '') AS centro_costo,
    CAST(monto AS DECIMAL(18,2)) AS monto,
    fecha
FROM gastos;
```

---

### 2. Gasto Total por Categoría

```sql
WITH clean AS (
    SELECT
        CASE 
            WHEN TRIM(LOWER(categoria)) IN ('admin','administracion','administración') 
                 THEN 'administración'
            WHEN TRIM(LOWER(categoria)) IN ('af','activo fijo','activo_fijo') 
                 THEN 'activo fijo'
            WHEN TRIM(LOWER(categoria)) IN ('personal',' personal') 
                 THEN 'personal'
            ELSE TRIM(LOWER(categoria))
        END AS categoria,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
)
SELECT 
    categoria,
    SUM(monto) AS gasto_total
FROM clean
GROUP BY categoria
ORDER BY gasto_total DESC;
```

---

### 3. Variaciones Mes a Mes

CTEs encadenadas con `LAG()` para comparar cada mes con el anterior por categoría. `PARTITION BY categoria` asegura que la ventana se reinicie para cada categoría independientemente.

```sql
WITH clean AS (
    SELECT
        CASE 
            WHEN TRIM(LOWER(categoria)) IN ('admin','administracion','administración') 
                 THEN 'administración'
            WHEN TRIM(LOWER(categoria)) IN ('af','activo fijo','activo_fijo') 
                 THEN 'activo fijo'
            ELSE TRIM(LOWER(categoria))
        END AS categoria,
        fecha,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
),
gasto_mensual AS (
    SELECT 
        categoria,
        DATE_TRUNC('month', fecha) AS mes,
        SUM(monto) AS gasto_mensual
    FROM clean
    GROUP BY categoria, DATE_TRUNC('month', fecha)
),
base AS (
    SELECT 
        categoria,
        mes,
        gasto_mensual,
        LAG(gasto_mensual) OVER (
            PARTITION BY categoria 
            ORDER BY mes
        ) AS gasto_mes_anterior
    FROM gasto_mensual
)
SELECT *,
    gasto_mensual - gasto_mes_anterior AS variacion_absoluta,
    CASE 
        WHEN gasto_mes_anterior IS NULL OR gasto_mes_anterior = 0 THEN NULL
        ELSE ROUND((gasto_mensual - gasto_mes_anterior) / gasto_mes_anterior * 100, 2)
    END AS variacion_porcentual
FROM base
ORDER BY categoria, mes;
```

---

### 4. Ranking de Centros de Costo

`RANK()` sobre `SUM()` agrupa primero y luego rankea. Se elige `RANK()` sobre `DENSE_RANK()` porque ante empates, la posición real importa más que la secuencia continua.

```sql
WITH clean AS (
    SELECT
        REPLACE(TRIM(LOWER(centro_costo)), '-', '') AS centro_costo,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
),
ranking AS (
    SELECT 
        centro_costo,
        SUM(monto) AS gasto_total,
        RANK() OVER (ORDER BY SUM(monto) DESC) AS ranking
    FROM clean
    GROUP BY centro_costo
)
SELECT *
FROM ranking
WHERE ranking <= 10;
```

---

### 5. Gasto Real vs. Presupuesto

`LEFT JOIN` para conservar todos los gastos, incluso sin presupuesto asignado. `COALESCE` convierte los NULL del LEFT JOIN en 0 para permitir el cálculo de diferencia. Los centros fantasma se excluyen explícitamente.

```sql
WITH gastos_clean AS (
    SELECT
        CASE 
            WHEN TRIM(LOWER(categoria)) IN ('admin','administracion','administración') 
                 THEN 'administración'
            WHEN TRIM(LOWER(categoria)) IN ('af','activo fijo','activo_fijo') 
                 THEN 'activo fijo'
            ELSE TRIM(LOWER(categoria))
        END AS categoria,
        REPLACE(TRIM(LOWER(centro_costo)), '-', '') AS centro_costo,
        DATE_TRUNC('month', fecha) AS mes,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
),
presupuesto_clean AS (
    SELECT
        CASE 
            WHEN TRIM(LOWER(categoria)) IN ('admin','administracion','administración') 
                 THEN 'administración'
            WHEN TRIM(LOWER(categoria)) IN ('af','activo fijo','activo_fijo') 
                 THEN 'activo fijo'
            ELSE TRIM(LOWER(categoria))
        END AS categoria,
        REPLACE(TRIM(LOWER(centro_costo)), '-', '') AS centro_costo,
        DATE_TRUNC('month', fecha) AS mes,
        CAST(monto_presupuestado AS DECIMAL(18,2)) AS monto_presupuestado
    FROM presupuesto
    WHERE centro_costo NOT IN ('ti999', 'mk0123', 'tec1213')
)
SELECT
    g.categoria,
    g.centro_costo,
    g.mes,
    SUM(g.monto) AS gasto_total,
    COALESCE(SUM(p.monto_presupuestado), 0) AS presupuesto,
    SUM(g.monto) - COALESCE(SUM(p.monto_presupuestado), 0) AS diferencia,
    CASE
        WHEN COALESCE(SUM(p.monto_presupuestado), 0) = 0 THEN NULL
        ELSE ROUND(
            (SUM(g.monto) - COALESCE(SUM(p.monto_presupuestado), 0)) 
            / COALESCE(SUM(p.monto_presupuestado), 0) * 100, 2
        )
    END AS desviacion_pct
FROM gastos_clean g
LEFT JOIN presupuesto_clean p
    ON g.categoria = p.categoria
    AND g.centro_costo = p.centro_costo
    AND g.mes = p.mes
GROUP BY 1, 2, 3
ORDER BY diferencia DESC;
```

---

## Dashboard Power BI

![Dashboard](visuals/Dashboard_control_presupuestario.gif)

El dashboard consolida los resultados del análisis SQL en una vista ejecutiva de una página con filtros interactivos por centro de costo y categoría:

- **KPIs superiores:** Gasto total ($12,8M), presupuesto total ($13,3M), diferencia absoluta (-$550K) y % de desviación (-4,13%)
- **Gasto vs Presupuesto por categoría:** Personal presenta la mayor subejecución en términos absolutos ($3,2M bajo presupuesto); Activo Fijo y Administración superan su presupuesto asignado
- **Tendencia mensual:** Gasto consistentemente por debajo del presupuesto a lo largo del año, con peaks en agosto y octubre que superan el promedio mensual
- **Top centros de costo:** Los 3 principales (mkt004, tec001, ope002) concentran la mayor proporción del gasto total — focos prioritarios de control
- **Filtros interactivos:** permiten drill-down por centro de costo y categoría sin cambiar de página

---

## Hallazgos y Decisiones de Negocio

| Hallazgo | Implicancia para el negocio |
|---|---|
| Gasto total 4,13% bajo presupuesto | Control presupuestario eficiente a nivel global, pero con distribución heterogénea entre categorías |
| Personal: mayor subejecución absoluta | Posible subejecución en sueldos, cargos diferidos o vacantes sin cubrir — requiere revisión con el área |
| Activo Fijo y Administración sobre presupuesto | Categorías que requieren seguimiento: pueden indicar compras no planificadas o reasignaciones |
| Top 3 centros concentran la mayor proporción del gasto | Alta concentración: priorizar controles y revisión de estimaciones en mkt004, tec001 y ope002 |
| Peaks de gasto en agosto y octubre | Comportamiento estacional a monitorear: posibles ajustes contables de cierre o provisiones adicionales |
| 3 centros fantasma en presupuesto | Error de parametría detectado: TI999, MK0123, TEC1213 no existen en gastos reales — requiere corrección en sistema fuente |

---

## Limitaciones del Análisis

Estas limitaciones son importantes para interpretar correctamente los resultados:

- **Dataset simulado:** los datos fueron generados con errores deliberados para practicar limpieza, no provienen de un sistema productivo real. Los montos y proporciones no reflejan ninguna empresa real.
- **Sin ajuste por inflación:** los montos se comparan en términos nominales. En un análisis real, las variaciones deberían ajustarse por IPC para períodos superiores a un año.
- **Sin dimensión de tipo de cambio:** el dataset no incluye gastos en moneda extranjera (USD/EUR), que en entornos bancarios reales son parte relevante del control.
- **Presupuesto sin versión seleccionada:** el dataset incluye versiones Budget, Forecast Q1 y Forecast Q2. El análisis suma todas las versiones; en producción se debería filtrar por la versión vigente del período.
- **Sin contexto organizacional:** los centros de costo son códigos genéricos. En un análisis real, estarían mapeados a áreas, responsables y jerarquías organizacionales.

---

## Próximos Pasos

Mejoras planificadas para versiones futuras del proyecto:

- **Migración a Python (pandas):** replicar el proceso de limpieza y análisis en un notebook Jupyter para portabilidad y reproducibilidad
- **Modelo dimensional:** rediseñar el dataset con tabla de hechos y dimensiones (dim_centro_costo, dim_categoria, dim_fecha) para mejorar el modelado en Power BI
- **Forecast simple:** agregar proyección de cierre anual basada en tendencia del gasto acumulado vs. presupuesto restante
- **Automatización:** simular el pipeline completo con un job programado (equivalente a lo implementado en Databricks en entorno productivo)

---

## Estructura del Repositorio

```
├── data/
│   ├── Gastos.csv
│   ├── Presupuesto.csv
│   └── Visualizador_gastos vs presupuestos.pbix
├── sql/
│   ├── 01_cleaning.sql
│   ├── 02_gasto_total.sql
│   ├── 03_variaciones.sql
│   ├── 04_ranking_centros.sql
│   └── 05_gasto_vs_presupuesto.sql
├── visuals/
│   ├── Dashboard_control_presupuestario.gif
│   ├── Gasto_por_categorias.png
│   └── Centros_de_costos.png
└── README.md
```

---

## Stack Técnico

- **SQL** — compatible con Databricks SQL, DuckDB, PostgreSQL, BigQuery
- **Power BI** — modelado de datos, DAX básico, dashboard ejecutivo con filtros interactivos
- **Excel** — generación del dataset y validación de resultados

---

*Proyecto de portafolio | Cristian De La Barra Díaz — Finance Data Analyst*
*linkedin.com/in/cristian-de-la-barra · github.com/CristianDelaBarra30*
