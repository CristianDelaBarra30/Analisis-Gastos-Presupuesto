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
