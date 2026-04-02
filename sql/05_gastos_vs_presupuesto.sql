WITH gastos_clean AS (
    SELECT
        TRIM(LOWER(categoria)) AS categoria,
        TRIM(LOWER(centro_costo)) AS centro_costo,
        fecha,
        monto
    FROM gastos
),
presupuesto_clean AS (
    SELECT
        TRIM(LOWER(categoria)) AS categoria,
        TRIM(LOWER(centro_costo)) AS centro_costo,
        fecha,
        monto_presupuestado
    FROM presupuesto
)

SELECT
    g.categoria,
    g.centro_costo,
    DATE_TRUNC('month', g.fecha) AS mes,
    SUM(g.monto) AS gasto_total,
    SUM(p.monto_presupuestado) AS presupuesto,
    SUM(g.monto) - SUM(p.monto_presupuestado) AS diferencia
FROM gastos_clean g
LEFT JOIN presupuesto_clean p
    ON g.categoria = p.categoria
    AND g.centro_costo = p.centro_costo
    AND DATE_TRUNC('month', g.fecha) = DATE_TRUNC('month', p.fecha)
GROUP BY 1,2,3
ORDER BY diferencia DESC;
