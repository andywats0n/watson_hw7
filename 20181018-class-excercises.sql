drop database if exists second_international_bank;
create database second_international_bank;

show databases;

USE second_international_bank;

create table second_international_bank.customers (
  id int not null auto_increment,
  first_name varchar(20),
  last_name varchar(20),
  loan bool default false,
  checking decimal(8,2),
  savings decimal(8,2),
  primary key(id)
);

USE second_international_bank;

insert into second_international_bank.customers(first_name,last_name,checking,savings)
  values ("Amanda", "Watson", 10.50, 15.99)
        ,("Alli", "Watson", 2000.50, 148723.99)
        ,("Chip", "Watson", 999.43, 23987.99)
        ,("Monty", "Watson", 100000.50, 150330.99);

select * from second_international_bank.customers;
