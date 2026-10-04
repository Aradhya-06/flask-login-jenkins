create database if not exists flaskdb;

use flaskdb;

craete table if not exists users(
    id int prinary key auto_increment,
    username varchar(50) not null unique,
    password varchar(20) not null,
    created_at timestamp default current_timestamp
);