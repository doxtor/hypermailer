create table renewals (
  renewal_id int not null auto_increment,
  domain varchar(32) not null,
  formatted_view_id int not null,
  name varchar(32) not null,
  subject varchar(128) not null,
  content text not null,
  primary key (renewal_id)
)Engine=InnoDB;

create table events (
  event_id int not null auto_increment,
  type char not null,
  description text not null,
  date datetime not null,
  primary key(event_id)
)Engine=InnoDB;