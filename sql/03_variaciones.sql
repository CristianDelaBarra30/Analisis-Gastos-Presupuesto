WITH clean AS (
    SELECT
        TRIM(LOWER(categoria)) AS categoria,
        fecha,
        monto
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
    gasto_mensual - gasto_mes_anterior AS variacion,
    CASE 
        WHEN gasto_mes_anterior IS NULL OR gasto_mes_anterior = 0 THEN NULL
        ELSE (gasto_mensual - gasto_mes_anterior) / gasto_mes_anterior
    END AS porcentaje_variacion
FROM base;
