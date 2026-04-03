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
    WHERE centro_costo NOT IN ('ti999', 'mk0123', 'tec1213') -- centros fantasma excluidos
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

