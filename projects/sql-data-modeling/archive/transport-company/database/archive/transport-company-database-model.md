# Transport company database model

A model for a database of an example transport company.

## Tables

No column in no table shall be null.

|No.|Name|Description
|-|-|-
|1|Orders|Orders. A row represents an order. The order placing person, the cargo handing over person and the cargo receiving person can be the same person. One order can be assigned to only one order placing person, only one cargo handing over person, only one cargo receiving person, only one place of origin address and only one place of destination address. One order placing person can be assigned to multiple orders. One cargo handing over person can be assigned to multiple orders. One cargo receiving person can be assigned to multiple orders. One place of origin address can be assigned to multiple orders. One place of destination address can be assigned to multiple orders.
|2|People|People mentioned in any other table within this model. A row represents a person.
|3|Companies|Companies mentioned in any other table within this model. A row represents a company.
|4|People and companies|Assignment of people to companies. A row represents the fact that a person represents a company. One person can be assigned to only one company. One company can be assigned to multiple people.
|5|Vehicles|Vehicles that the company possesses. A row represents a vehicle.
|6|Addresses|Addresses mentioned in any other table within this model. A row represents an address.
|7|Parcels|Individual parcels that the company handles within each order. A row represents a parcel. One parcel can be assigned to only one order. One order can be assigned to multiple parcels.
|8|Parcel shipments|Shipments of parcels. A row represents a shipment. A parcel can be shipped multiple times if the company wants to use one or more distribution centers as intermediaries. One shipment can be assigned to only one vehicle, only one address and multiple parcels. One vehicle can be assigned to multiple shipments. One address can be assigned to multiple shipments. One parcel can be assigned to multiple shipments.
|9|Parcel deliveries|Deliveries of parcels. A parcel can be delivered multiple times if the company wants to use one or more distribution centers as intermediaries. A row represents a delivery. One delivery can be assigned to only one shipment and only one address. One address can be assigned to multiple deliveries. One shipment can be assigned to only one delivery.
|10|Required payments|Payments for orders that the clients of the company are charged. A client is supposed to be charged a payment for their order after all the parcels within this order have been delivered. A row represents a required payment. One required payment can be assigned to only one order. One order can be assigned to only one required payment.
|11|Made payments|Payments for orders that the clients of the company have made. A row represents a made payment. One made payment can be assigned to only one required payment. One required payment can be assigned to only one made payment.

## Columns

### "Orders" table

A row is expected to be added when a client has placed an order.

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Acceptance date and time|No
|3|Order placing person ID|No
|4|Cargo handing over person ID|No
|5|Cargo receiving person ID|No
|6|Place of origin address ID|No
|7|Place of destination address ID|No

### "People" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Name|No

### "Companies" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Registration number|No

### "People and companies" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Person ID|No
|3|Company ID|No

### "Vehicles" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Maximum cargo weight in kg|No
|3|GPS location|No

### "Addresses" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Address|No
|3|GPS location|No

### "Parcels" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Order ID|No
|3|Estimated weight in kg|No

### "Shipments" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Vehicle ID|No
|3|Parcel ID|No
|4|Address ID|No
|5|Date and time|No

### "Deliveries" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Shipment ID|No
|3|Address ID|No
|4|Date and time|No

### "Required payments" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Order ID|No
|3|Amount|No
|4|Due date|No

### "Done payments" table

|No.|Name|Can be null?
|-|-|-
|1|ID|No
|2|Required payment ID|No
|3|Date|No
