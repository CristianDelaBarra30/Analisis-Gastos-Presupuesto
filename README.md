# Análisis de gasto vs presupuesto

Este proyecto busca replicar un análisis típico de control de gestión, enfocado en entender el comportamiento del gasto y su relación con el presupuesto.

La idea fue construir un flujo simple pero representativo de lo que se realiza en entornos financieros reales.

---

## Datos

Se trabajó con dos datasets:

- Gastos reales
- Presupuesto

Ambos contienen información por categoría, centro de costo y fecha.

---

## Proceso

Primero se realizó una limpieza de datos, considerando problemas comunes como:

- Espacios en blanco
- Diferencias de formato
- Inconsistencias en texto

Se utilizaron funciones como TRIM, LOWER, REPLACE y CAST.

---

## Análisis

Se desarrollaron distintas consultas en SQL para:

- Analizar el gasto total por categoría  
- Comparar gasto real vs presupuesto  
- Evaluar variaciones mes a mes usando LAG  
- Identificar centros de costo con mayor gasto  

---

## Visualización

Se construyó un dashboard en Power BI para facilitar el análisis:

- Gasto vs presupuesto  
- Evolución mensual  
- Ranking de centros de costo  
- KPIs financieros  

---

## Archivos del proyecto

- data/ → datasets  
- sql/ → queries  
- visuals/ → imágenes y gif  
- dashboard.pbix → dashboard Power BI  

---

## Conclusiones

El gasto se mantiene en general bajo el presupuesto, aunque existen concentraciones relevantes en ciertos centros de costo.

También se observan variaciones mensuales que podrían requerir análisis adicional.

---

## Contexto

El proyecto está inspirado en tareas reales de control de gestión en banca, donde este tipo de análisis se utiliza para apoyar la toma de decisiones financieras.
