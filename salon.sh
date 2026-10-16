#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

services="$($PSQL "SELECT * FROM services;")"
echo 'Ergebnis aus DB:' $services

customers="$($PSQL "SELECT * FROM customers;")"
echo 'Ergebnis aus DB:' $customers

SELECT_SERVICE() {
  echo "✂️ Welcome! Chose any of our services below!"
  echo "$services" | while IFS=' ' read service_id sperator name; do
 echo $service_id")" $name
done

echo $services

read SERVICE_ID_SELECTED
while ! [[ $services == *"$SERVICE_ID_SELECTED"* ]]; do
  SELECT_SERVICE
  done
}

SELECT_SERVICE
echo $SERVICE_ID_SELECTED


echo 'Please enter your phone number.'
read CUSTOMER_PHONE

echo 'Please enter your name'
read CUSTOMER_NAME

if ! [[ $customers == $CUSTOMER_NAME$ ]]; then
echo $CUSTOMER_NAME'Thank you, '$CUSTOMER_NAME!
fi

echo 'Please enter your preferred service time!'
read SERVICE_TIME