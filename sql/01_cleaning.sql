--Cleaning tabla centro costo
SELECT
    TRIM(LOWER(categoria)) AS categoria,
    REPLACE(TRIM(LOWER(centro_costo)),'-','') AS centro_costo,
    CAST(monto AS DECIMAL(18,2)) AS monto,
    fecha
FROM gastos;

--Cleaning tabla presupuestos
SELECT
    TRIM(LOWER(categoria)) AS categoria,
    TRIM(LOWER(centro_costo)) AS centro_costo,
    CAST(monto_presupuestado AS DECIMAL(18,2)) AS monto_presupuestado,
    fecha,
    version_presupuesto
FROM presupuesto;
