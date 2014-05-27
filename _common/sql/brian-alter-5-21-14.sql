alter table renewals modify renewal_id int unsigned not null auto_increment;
alter table renewals modify formatted_view_id int unsigned not null;
alter table renewals add mg_campaign_id int unsigned after renewal_id;
alter table renewals add from_email varchar(64) not null after name;
alter table renewals add from_name varchar(64) not null after from_email;
alter table campaigns modify campaign_id int unsigned not null auto_increment;
alter table campaigns modify datasource_view_id int unsigned;
alter table campaigns change datasource_view_id formatted_view_id int unsigned;
alter table campaigns modify mg_campaign_id int unsigned;
alter table campaigns modify template_id int unsigned;
alter table campaigns modify date_created datetime not null;
alter table campaigns modify date_started datetime;
alter table events modify event_id int unsigned not null auto_increment;
alter table users modify user_id int unsigned not null auto_increment;

create table domains (
  domain_id int not null auto_increment,
  name varchar(32) not null,
  domain varchar(32) not null,
  primary key (domain_id)
)Engine=InnoDB;