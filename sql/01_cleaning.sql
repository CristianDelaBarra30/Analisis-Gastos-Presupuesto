SELECT
    TRIM(categoria) AS categoria,
    TRIM(centro_costo) AS centro_costo,
    CAST(monto_real AS FLOAT) AS monto_real,
    CAST(monto_presupuestado AS FLOAT) AS monto_presupuestado,
    fecha
FROM gastos;
