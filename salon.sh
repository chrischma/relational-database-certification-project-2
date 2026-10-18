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

BOOK_SERVICE() {
  echo 'Please enter your phone number.'
  read CUSTOMER_PHONE

  customers="$($PSQL "SELECT * FROM customers;")"

  PHONE_QUERY_RESULT="$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")"
  

  if  [[ $PHONE_QUERY_RESULT == "" ]]; then
    echo 'We found no user profile for your phone number'
    echo 'Please enter your name'
    read CUSTOMER_NAME
    
    echo 'Writing' $CUSTOMER_PHONE 'to DB.'
    INSERT_QUERY="$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")"  
    # Bis hierhin klappt alles...

    echo 'Please enter your preferred service time!'
    read SERVICE_TIME

    SERVICE_ID=$SERVICE_ID_SELECTED

    echo 'OK'
    # CURRENT_DB_ROWS="$($PSQL "SELECT * FROM CUSTOMERS;")" 
    CUSTOMER_ID="$($PSQL "
    SELECT customer_id 
    FROM CUSTOMERS 
    WHERE name='$CUSTOMER_NAME';")" 

    INSERT_APPOINTMENT_QUERY="$($PSQL "
    INSERT INTO appointments (customer_id, service_id, name, time) 
    VALUES ('$CUSTOMER_ID', '$SERVICE_ID', '$CUSTOMER_NAME', '$SERVICE_TIME');")"  

    SERVICE_NAME="$($PSQL "
    SELECT name FROM services WHERE service_id = $SERVICE_ID;
    ")"
    echo 'I have put you down for a '$SERVICE_NAME' at '$SERVICE_TIME', '$CUSTOMER_NAME'.'
  fi

}

BOOK_SERVICE


