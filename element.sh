#!/bin/bash

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
  if [[ $1 =~ [0-9]+$ ]]; then
    SELECT_ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1;")
  else
    SELECT_ELEMENT=$($PSQL "SELECT * FROM elements WHERE symbol='$1' OR name='$1'")
  fi

  if [[ -z $SELECT_ELEMENT ]]; then
    echo "I could not find that element in the database."
  else  
    IFS='|' read -r -a element <<< "$SELECT_ELEMENT"

    SELECT_PROPERTIES="$($PSQL "SELECT type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=${element[0]};")"
    IFS='|' read -r -a properties <<< "$SELECT_PROPERTIES"

    echo "The element with atomic number ${element[0]} is ${element[2]} (${element[1]}). It's a ${properties[0]}, with a mass of ${properties[1]} amu. ${element[2]} has a melting point of ${properties[2]} celsius and a boiling point of ${properties[3]} celsius."
  fi
fi