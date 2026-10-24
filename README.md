# Base de Datos de la Tabla Periódica

Base de datos PostgreSQL de elementos químicos, corregida y normalizada, con un script de Bash para consultar cualquier elemento.

Proyecto de la certificación **Relational Database** de [freeCodeCamp](https://www.freecodecamp.org/).

## Qué hace

`element.sh` recibe un número atómico, un símbolo o un nombre y muestra las propiedades del elemento:

```
$ ./element.sh H
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
```

Si el elemento no existe, avisa que no lo encontró.

## Tecnologías

PostgreSQL · Bash · SQL

## Modelo de datos

| Tabla | Columnas principales |
| --- | --- |
| `elements` | `atomic_number`, `symbol`, `name` |
| `properties` | `atomic_number` → `elements`, `type_id` → `types`, `atomic_mass`, `melting_point_celsius`, `boiling_point_celsius` |
| `types` | `type_id`, `type` |

## Cómo ejecutarlo

Requisitos: PostgreSQL y una terminal Bash.

```bash
psql -U postgres < periodic_table.sql
chmod +x element.sh
./element.sh 1        # por número atómico
./element.sh H        # por símbolo
./element.sh Hydrogen # por nombre
```

El script se conecta con el usuario `freecodecamp`; si usás otro, cambiá la variable `PSQL` en `element.sh`.

## Lo que aprendí

- Corregir una base existente: renombrar columnas, cambiar tipos de datos y agregar restricciones `NOT NULL` y `UNIQUE`.
- Normalizar datos moviendo el tipo de elemento a su propia tabla.
- Consultar con `JOIN` y procesar resultados en Bash con `IFS` y arreglos.
