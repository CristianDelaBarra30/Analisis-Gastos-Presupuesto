--Cleaning tabla centro costo
SELECT
    TRIM(LOWER(categoria)) AS categoria,
    TRIM(LOWER(centro_costo)) AS centro_costo,
    CAST(monto AS FLOAT) AS monto,
    fecha
FROM gastos;

--Cleaning tabla presupuestos
SELECT
    TRIM(LOWER(categoria)) AS categoria,
    TRIM(LOWER(centro_costo)) AS centro_costo,
    CAST(monto_presupuestado AS FLOAT) AS monto_presupuestado,
    fecha,
    version_presupuesto
FROM presupuesto;
