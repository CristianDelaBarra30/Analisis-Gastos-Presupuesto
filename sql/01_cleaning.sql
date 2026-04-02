-- Cleaning gastos
SELECT
    TRIM(LOWER(categoria)) AS categoria,
    REPLACE(TRIM(LOWER(centro_costo)),'-','') AS centro_costo,
    CAST(monto AS DECIMAL(18,2)) AS monto,
    fecha
FROM gastos;

-- Cleaning presupuesto
SELECT
    TRIM(LOWER(categoria)) AS categoria,
    REPLACE(TRIM(LOWER(centro_costo)),'-','') AS centro_costo,
    CAST(monto_presupuestado AS DECIMAL(18,2)) AS monto_presupuestado,
    fecha,
    version_presupuesto
FROM presupuesto;
