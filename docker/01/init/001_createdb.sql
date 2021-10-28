create table stores if exists
(
    id text UNIQUE,
    name varchar(100),
    infomation bson,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);

create table users
(
    user_id text UNIQUE,
    password text,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);

create table admins
(
    admin_id text UNIQUE,
    name text UNIQUE,
    password text,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);

create table posts
(
    post_id bigint,
    title varchar(255),
    body text,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);
create table post_image
(
    post_image_id bigint,
    post_id bigint,
    title varchar(255),
    file_name varchar(255),
    file_path varchar(255),
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);

/** after configuration */
-- DROP roll if exists



-- publication
-- CREATE OR REPLACE PUBLICATION pub FOR ALL TABLES;

