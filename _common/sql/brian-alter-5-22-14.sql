create table proof_list (
  proof_list_id int not null auto_increment,
  name varchar(32) not null,
  email varchar(32) not null,
  primary key (proof_list_id)
)Engine=InnoDB;

alter table templates drop column date_created;
alter table campaigns modify mg_campaign_id varchar(16);
alter table renewals modify mg_campaign_id varchar(16);
alter table campaigns modify name varchar(64) not null;
alter table campaigns modify description varchar(128) not null;
alter table campaigns modify domain varchar(32) not null;