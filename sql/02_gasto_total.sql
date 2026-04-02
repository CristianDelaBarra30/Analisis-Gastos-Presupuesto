SELECT 
    categoria,
    SUM(monto) AS gasto_total
FROM gastos
GROUP BY categoria
ORDER BY gasto_total DESC;
