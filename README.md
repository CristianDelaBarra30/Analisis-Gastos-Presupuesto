# Análisis de gasto vs presupuesto

Este proyecto nace de la necesidad de entender cómo se comportan los gastos en relación al presupuesto, algo que es bastante común en áreas de control de gestión.

La idea fue replicar un flujo simple pero realista de análisis financiero, usando SQL para trabajar los datos y Power BI para visualizar resultados.

---

## Datos

Se trabajó con dos datasets:

- Gastos reales
- Presupuesto

Ambos contienen información por categoría, centro de costo y fecha.

---

## Qué se hizo

Primero se realizó una limpieza de datos, ya que algunas columnas venían con problemas típicos como espacios, formatos distintos o inconsistencias en texto.

Luego se desarrollaron distintas consultas en SQL para:

- Ver el gasto total por categoría
- Comparar gasto real vs presupuesto
- Analizar variaciones mes a mes
- Identificar los centros de costo con mayor gasto

---

## Visualización

Se armó un dashboard en Power BI para poder ver:

- Gasto vs presupuesto
- Evolución mensual
- Principales centros de costo

La idea fue que fuera algo simple pero útil, similar a lo que usaría un equipo financiero.

---

## Conclusiones

Se observa que el gasto se mantiene en general bajo el presupuesto, aunque existen concentraciones importantes en ciertos centros de costo.

También hay variaciones mensuales que podrían requerir análisis más detallado.

---

## Notas

El proyecto está inspirado en tareas reales de control de gestión en banca, donde este tipo de análisis se realiza de forma frecuente.
