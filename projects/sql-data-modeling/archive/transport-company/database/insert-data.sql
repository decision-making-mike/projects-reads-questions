insert into people (
    name
)
values
    ('Ed One'),
    ('Mark Two'),
    ('Jill Three'),
    ('Rita Four'),
    ('Leonie Five'),
    ('Horace Six'),
    ('Ted Seven'),
    ('Lina Eight'),
    ('Ronald Nine'),
    ('Maggie Ten')
;

insert into companies (
    registration_number
)
values
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10)
;

insert into people_companies (
    person_id,
    company_id
)
values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10)
;

insert into addresses (
    address,
    gps_location
)
values
    ('Sunville / Sun Square / 1', '5.123456,5.123456'),
    ('Mercury City / Mercury Lane / 2', '10.123456,10.123456'),
    ('Venusworth / Venus Road / 3', '15.123456,15.123456'),
    ('Earthham / Earth Gardens / 4', '20.123456,20.123456'),
    ('Moonby / Moon Hill / 5', '25.123456,25.123456'),
    ('Marsbury / Mars Drive / 6', '30.123456,30.123456'),
    ('Jupiterton / Jupiter Avenue / 7', '35.123456,35.123456'),
    ('Saturnstead / Saturn Highway / 8', '40.123456,40.123456'),
    ('Uranus Town / Uranus Way / 9', '45.123456,45.123456'),
    ('Neptuneford / Neptune Grove / 10', '50.123456,50.123456')
;

insert into vehicles (
    max_cargo_weight_in_kg,
    gps_location
)
values
    (1000, '50.123456,50.123456'),
    (2000, '45.123456,45.123456'),
    (3000, '40.123456,40.123456'),
    (4000, '35.123456,35.123456'),
    (5000, '30.123456,30.123456'),
    (6000, '25.123456,25.123456'),
    (7000, '20.123456,20.123456'),
    (8000, '15.123456,15.123456'),
    (9000, '10.123456,10.123456'),
    (10000, '5.123456,5.123456')
;

insert into orders (
    acceptance_date_and_time,
    order_placing_person_id,
    cargo_handing_over_person_id,
    cargo_receiving_person_id,
    place_of_origin_address_id,
    place_of_destination_address_id
)
values
    ('2024-01-01 00:00', 1, 3, 5, 1, 2),
    ('2024-02-01 00:00', 1, 3, 5, 2, 3),
    ('2024-03-01 00:00', 1, 3, 5, 3, 4),
    ('2024-04-01 00:00', 1, 3, 5, 4, 1),
    ('2024-05-01 00:00', 1, 3, 5, 1, 2),
    ('2024-06-01 00:00', 1, 3, 5, 2, 3),
    ('2024-07-01 00:00', 2, 4, 6, 3, 4),
    ('2024-08-01 00:00', 2, 4, 6, 4, 1),
    ('2024-09-01 00:00', 2, 4, 6, 1, 2),
    ('2024-10-01 00:00', 2, 4, 6, 2, 3)
;

insert into parcels (
    order_id,
    estimated_weight_in_kg
)
values
    (1, 11),
    (2, 22),
    (2, 33),
    (3, 44),
    (3, 55),
    (3, 66),
    (4, 77),
    (4, 88),
    (4, 99),
    (4, 110)
;

insert into shipments (
    vehicle_id,
    parcel_id,
    address_id,
    date_and_time
)
values
    (1, 1, 1, '2024-01-02 00:00'),
    (2, 2, 2, '2024-02-02 00:00'),
    (2, 3, 3, '2024-03-02 00:00'),
    (3, 4, 4, '2024-04-02 00:00'),
    (3, 5, 5, '2024-05-02 00:00'),
    (3, 6, 6, '2024-06-02 00:00'),
    (4, 7, 7, '2024-07-02 00:00'),
    (4, 8, 8, '2024-08-02 00:00'),
    (4, 9, 9, '2024-09-02 00:00'),
    (4, 10, 10, '2024-10-02 00:00')
;

insert into deliveries (
    shipment_id,
    address_id,
    date_and_time
)
values
    (1, 2, '2024-01-03 00:00'),
    (2, 3, '2024-02-03 00:00'),
    (3, 4, '2024-03-03 00:00'),
    (4, 5, '2024-04-03 00:00'),
    (5, 6, '2024-05-03 00:00'),
    (6, 7, '2024-06-03 00:00'),
    (7, 8, '2024-07-03 00:00'),
    (8, 9, '2024-08-03 00:00'),
    (9, 10, '2024-09-03 00:00'),
    (10, 1, '2024-10-03 00:00')
;

insert into required_payments (
    order_id,
    amount,
    due_date
)
values
    (1, 100, '2024-01-04'),
    (2, 200, '2024-02-04'),
    (3, 300, '2024-03-04'),
    (4, 400, '2024-04-04'),
    (5, 500, '2024-05-04'),
    (6, 600, '2024-06-04'),
    (7, 700, '2024-07-04'),
    (8, 800, '2024-08-04'),
    (9, 900, '2024-09-04'),
    (10, 1000, '2024-10-04')
;

insert into made_payments (
    required_payment_id,
    date
)
values
    (1, '2024-01-05'),
    (2, '2024-02-05'),
    (3, '2024-03-05'),
    (4, '2024-04-05'),
    (5, '2024-05-05')
;

insert into fuel_expenses (
    amount
)
values
    (50),
    (51),
    (52),
    (53),
    (54)
;

insert into parameters (
    name,
    value
)
values
    ('service price', '100')
;

insert into service_ratings (
    value
)
values
    (1),
    (2),
    (3),
    (4),
    (5)
;

insert into employment_ratings (
    value
)
values
    (6),
    (7),
    (8),
    (9),
    (10)
;

insert into salaries (
    amount
)
values
    (1000),
    (1000),
    (1000),
    (2000),
    (2000),
    (2000),
    (3000),
    (3000),
    (3000),
    (4000)
;
