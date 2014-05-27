create table system (
  system_id int unsigned not null auto_increment,
  `key` varchar(16) not null,
  value text not null,
  primary key (system_id)
)Engine=InnoDB;

alter table campaigns drop column domain;
alter table campaigns add domain_id int not null after campaign_id;

ALTER TABLE campaigns
ADD CONSTRAINT fk_domains_campaigns
FOREIGN KEY (domain_id)
REFERENCES domains (domain_id)
ON UPDATE NO ACTION
ON DELETE RESTRICT;

alter table renewals drop column domain;
alter table renewals add domain int not null after renewal_id;