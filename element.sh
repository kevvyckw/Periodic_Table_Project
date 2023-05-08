#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
#Input element. Can be either atomic_number, name or symbol



ELEMENT_INPUT=$1

MAIN_MENU(){ 
if [ -z "$ELEMENT_INPUT" ]
then
  echo "Please provide an element as an argument."
else  
  if ! [[ "$ELEMENT_INPUT" =~ ^[0-9]+$ ]]; 
  then  
    SYMBOL_EXIST=$($PSQL "SELECT symbol FROM elements WHERE symbol='$ELEMENT_INPUT'")
    SYMBOL_EXIST_FORMATTED=$(echo $SYMBOL_EXIST | sed 's/^ *//')
    if [[ -z $SYMBOL_EXIST ]]
    then
      NAME_EXIST=$($PSQL "SELECT name FROM elements WHERE name='$ELEMENT_INPUT'")
      NAME_EXIST_FORMATTED=$(echo $NAME_EXIST | sed 's/^ *//')
      if [[ -z $NAME_EXIST ]]
      then    
        echo "I could not find that element in the database."
      else
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELEMENT_INPUT'")
        ATOMIC_NUMBER_FORMATTED=$(echo $ATOMIC_NUMBER | sed 's/^ *//')
        ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
        ELEMENT_SYMBOL_FORMATTED=$(echo $ELEMENT_SYMBOL | sed 's/^ *//')
        ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id = properties.type_id AND atomic_number=$ATOMIC_NUMBER")
        ELEMENT_TYPE_FORMATTED=$(echo $ELEMENT_TYPE | sed 's/^ *//')
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
        ATOMIC_MASS_FORMATTED=$(echo $ATOMIC_MASS | sed 's/^ *//')
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
        MELTING_POINT_FORMATTED=$(echo $MELTING_POINT | sed 's/^ *//')
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
        BOILING_POINT_FORMATTED=$(echo $BOILING_POINT | sed 's/^ *//')
        echo "The element with atomic number $ATOMIC_NUMBER_FORMATTED is $NAME_EXIST_FORMATTED ($ELEMENT_SYMBOL_FORMATTED). It's a $ELEMENT_TYPE_FORMATTED, with a mass of $ATOMIC_MASS_FORMATTED amu. $NAME_EXIST_FORMATTED has a melting point of $MELTING_POINT_FORMATTED celsius and a boiling point of $BOILING_POINT_FORMATTED celsius."
      fi
    else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT_INPUT'")
      ATOMIC_NUMBER_FORMATTED=$(echo $ATOMIC_NUMBER | sed 's/^ *//')
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_NAME_FORMATTED=$(echo $ELEMENT_NAME | sed 's/^ *//')
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id = properties.type_id AND atomic_number=$ATOMIC_NUMBER")
      ELEMENT_TYPE_FORMATTED=$(echo $ELEMENT_TYPE | sed 's/^ *//')
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ATOMIC_MASS_FORMATTED=$(echo $ATOMIC_MASS | sed 's/^ *//')
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT_FORMATTED=$(echo $MELTING_POINT | sed 's/^ *//')
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT_FORMATTED=$(echo $BOILING_POINT | sed 's/^ *//')
      echo "The element with atomic number $ATOMIC_NUMBER_FORMATTED is $ELEMENT_NAME_FORMATTED ($SYMBOL_EXIST_FORMATTED). It's a $ELEMENT_TYPE_FORMATTED, with a mass of $ATOMIC_MASS_FORMATTED amu. $ELEMENT_NAME_FORMATTED has a melting point of $MELTING_POINT_FORMATTED celsius and a boiling point of $BOILING_POINT_FORMATTED celsius."
    fi
  else
    ATOMIC_NUMBER_EXIST=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$ELEMENT_INPUT")
    ATOMIC_NUMBER_EXIST_FORMATTED=$(echo $ATOMIC_NUMBER_EXIST | sed 's/^ *//')
    if [[ -z $ATOMIC_NUMBER_EXIST ]]
    then    
      echo "I could not find that element in the database."
    else
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER_EXIST")
      ELEMENT_NAME_FORMATTED=$(echo $ELEMENT_NAME | sed 's/^ *//')
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER_EXIST")
      ELEMENT_SYMBOL_FORMATTED=$(echo $ELEMENT_SYMBOL | sed 's/^ *//')
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id = properties.type_id AND atomic_number=$ATOMIC_NUMBER_EXIST")
      ELEMENT_TYPE_FORMATTED=$(echo $ELEMENT_TYPE | sed 's/^ *//')
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER_EXIST")
      ATOMIC_MASS_FORMATTED=$(echo $ATOMIC_MASS | sed 's/^ *//')
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_EXIST")
      MELTING_POINT_FORMATTED=$(echo $MELTING_POINT | sed 's/^ *//')
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_EXIST")  
      BOILING_POINT_FORMATTED=$(echo $BOILING_POINT | sed 's/^ *//')
      echo "The element with atomic number $ATOMIC_NUMBER_EXIST_FORMATTED is $ELEMENT_NAME_FORMATTED ($ELEMENT_SYMBOL_FORMATTED). It's a $ELEMENT_TYPE_FORMATTED, with a mass of $ATOMIC_MASS_FORMATTED amu. $ELEMENT_NAME_FORMATTED has a melting point of $MELTING_POINT_FORMATTED celsius and a boiling point of $BOILING_POINT_FORMATTED celsius."
    fi
  fi
fi
} 

EXIT(){
echo -e "\nThank you for stopping in.\n"

}

MAIN_MENU
