create table customers(
        customerid serial primary key,
        name text,
        age int,
        happiness int,
        email text
);

create table orders(
	orderid serial primary key,
	item text,
	customerid int,
        foreign key (customerid) references customers(customerid)
        on delete cascade
);
