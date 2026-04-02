WITH gastos_clean AS (
    SELECT
        TRIM(LOWER(categoria)) AS categoria,
        REPLACE(TRIM(LOWER(centro_costo)),'-','') AS centro_costo,
        DATE_TRUNC('month', fecha) AS mes,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
),
presupuesto_clean AS (
    SELECT
        TRIM(LOWER(categoria)) AS categoria,
        REPLACE(TRIM(LOWER(centro_costo)),'-','') AS centro_costo,
        DATE_TRUNC('month', fecha) AS mes,
        CAST(monto_presupuestado AS DECIMAL(18,2)) AS monto_presupuestado
    FROM presupuesto
)

SELECT
    g.categoria,
    g.centro_costo,
    g.mes,
    SUM(g.monto) AS gasto_total,
    COALESCE(SUM(p.monto_presupuestado),0) AS presupuesto,
    SUM(g.monto) - COALESCE(SUM(p.monto_presupuestado),0) AS diferencia
FROM gastos_clean g
LEFT JOIN presupuesto_clean p
    ON g.categoria = p.categoria
    AND g.centro_costo = p.centro_costo
    AND g.mes = p.mes
GROUP BY 1,2,3
ORDER BY diferencia DESC;
