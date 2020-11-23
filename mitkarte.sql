create table "user"
(
    id            serial      not null
        constraint user_pk
            primary key,
    user_name     varchar(24) not null,
    user_password varchar(20) not null,
    user_email    varchar(40) not null,
    created_at    timestamp
);

comment on table "user" is 'who post a store location and payment or review a store payment';

create table payment
(
    id      serial      not null
        constraint payment_pk
            primary key,
    payment varchar(20) not null
);

comment on table payment is 'a type of payment';

create table category
(
    id       serial      not null
        constraint category_pk
            primary key,
    category varchar(20) not null
);

comment on table category is 'a type of store';

create table store_info
(
    id            serial      not null
        constraint store_info_pk
            primary key,
    posted_user   integer     not null,
    store_name    varchar(30) not null,
    store_address varchar(80) not null,
    "Latitude"    double precision,
    "Longitude"   double precision,
    created_at    timestamp   not null,
    store_type    integer
        constraint store_info_category_id_fk
            references category
);

comment on table store_info is 'a store infomation';

create table store_payment
(
    store_id   integer not null
        constraint store_payment_store_info_id_fk
            references store_info,
    payment_id integer not null
        constraint store_payment_payment_id_fk
            references payment,
    constraint store_payment_pk
        primary key (store_id, payment_id)
);

comment on table store_payment is 'a store accepts non-cash payment ';

create table store_payment_confirm
(
    user_id         integer   not null
        constraint store_payment_confirm_user_id_fk
            references "user",
    store           integer   not null
        constraint store_payment_confirm_store_info_id_fk
            references store_info,
    payment         integer   not null
        constraint store_payment_confirm_payment_id_fk
            references payment,
    confrim_at      timestamp not null,
    is_noncash_work boolean   not null,
    constraint store_payment_confirm_pk
        primary key (user_id, store, payment)
);

comment on table store_payment_confirm is 'when user used a noncash payment at the store';


INSERT INTO public."user" (id, user_name, user_password, user_email, created_at) VALUES (1, 'apple235', '12345323532', 'apple134@apple.com', '2020-11-23 20:07:55.000000');
INSERT INTO public."user" (id, user_name, user_password, user_email, created_at) VALUES (2, 'orangeparty', '2303208548', 'orangeparty@google.com', '2020-11-23 20:08:24.000000');
INSERT INTO public."user" (id, user_name, user_password, user_email, created_at) VALUES (3, 'bananananana', '30482058', 'bananananana@google.com', '2020-11-23 20:08:50.000000');
INSERT INTO public."user" (id, user_name, user_password, user_email, created_at) VALUES (4, 'steven.me', '2348', 'steven@me.com', '2020-11-23 20:09:33.000000');
INSERT INTO public."user" (id, user_name, user_password, user_email, created_at) VALUES (7, 'tomatotree', '11111', 'tomatotree@hoase.com', '2020-11-23 20:10:26.000000');


INSERT INTO public.payment (id, payment) VALUES (1, 'visa');
INSERT INTO public.payment (id, payment) VALUES (2, 'master');
INSERT INTO public.payment (id, payment) VALUES (3, 'american express');
INSERT INTO public.payment (id, payment) VALUES (4, 'paypal');
INSERT INTO public.payment (id, payment) VALUES (5, 'google pay');
INSERT INTO public.payment (id, payment) VALUES (6, 'apple pay');
INSERT INTO public.payment (id, payment) VALUES (7, 'samsung pay');
INSERT INTO public.payment (id, payment) VALUES (8, 'JCB');

INSERT INTO public.category (id, category) VALUES (1, 'bakery');
INSERT INTO public.category (id, category) VALUES (2, 'cafe');
INSERT INTO public.category (id, category) VALUES (3, 'späti');
INSERT INTO public.category (id, category) VALUES (4, 'restaurant');
INSERT INTO public.category (id, category) VALUES (5, 'hairshop');
INSERT INTO public.category (id, category) VALUES (6, 'pharmacy');
INSERT INTO public.category (id, category) VALUES (7, 'fashion');
INSERT INTO public.category (id, category) VALUES (8, 'bar');
INSERT INTO public.category (id, category) VALUES (9, 'grocery');
INSERT INTO public.category (id, category) VALUES (10, 'ice cream shop');

INSERT INTO public.store_info (id, posted_user, store_name, store_address, "Latitude", "Longitude", created_at, store_type) VALUES (1, 1, 'Burgermeister Zoo
', 'Bhf Zoo, Joachimsthaler Str. 1-3, 10623 Berlin, Germany', 52.5043703, 13.3309188, '2020-11-23 20:16:01.000000', 4);
INSERT INTO public.store_info (id, posted_user, store_name, store_address, "Latitude", "Longitude", created_at, store_type) VALUES (2, 1, 'Bonanza Coffee Roasters', 'Adalbertstraße 70, 10999 Berlin, Germany', 52.5005164, 13.4114924, '2020-11-23 20:18:31.000000', 2);
INSERT INTO public.store_info (id, posted_user, store_name, store_address, "Latitude", "Longitude", created_at, store_type) VALUES (3, 1, 'Hard Rock Cafe
', 'Kurfürstendamm 224, 10719 Berlin, Germany', 52.4993121, 13.3268204, '2020-11-23 20:20:13.000000', 4);
INSERT INTO public.store_info (id, posted_user, store_name, store_address, "Latitude", "Longitude", created_at, store_type) VALUES (4, 2, 'JONES ice cream
', 'Goltzstraße 3, 10781 Berlin, Germany', 52.4457459, 13.2515146, '2020-11-23 20:21:39.000000', 10);

INSERT INTO public.store_payment (store_id, payment_id) VALUES (1, 1);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (3, 2);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (1, 2);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (2, 1);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (3, 1);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (1, 3);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (3, 3);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (1, 4);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (4, 1);
INSERT INTO public.store_payment (store_id, payment_id) VALUES (4, 2);

INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (3, 3, 2, '2020-11-23 20:49:12.000000', true);
INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (1, 4, 1, '2020-11-23 20:49:28.000000', true);
INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (1, 3, 1, '2020-11-23 20:49:46.000000', true);
INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (2, 3, 2, '2020-11-23 20:50:10.000000', true);
INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (4, 4, 1, '2020-11-23 20:50:41.000000', true);
INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (3, 4, 1, '2020-11-23 20:50:57.000000', true);
INSERT INTO public.store_payment_confirm (user_id, store, payment, confrim_at, is_noncash_work) VALUES (2, 4, 1, '2020-11-23 20:51:11.000000', true);


