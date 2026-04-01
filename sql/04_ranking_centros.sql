SELECT 
    centro_costo,
    SUM(monto) AS gasto_total,
    RANK() OVER (ORDER BY SUM(monto) DESC) AS ranking
FROM gastos
GROUP BY centro_costo;
