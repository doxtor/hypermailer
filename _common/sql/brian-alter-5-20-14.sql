alter table datasources drop column username;
alter table datasources drop column password;
alter table datasources add regular_password varchar(32) not null after ip;
alter table datasources add regular_username varchar(32) not null after ip;
alter table datasources add super_password varchar(32) not null after ip;
alter table datasources add super_username varchar(32) not null after ip;

alter table formatted_views modify datasource_id int unsigned not null;

ALTER TABLE formatted_views
ADD CONSTRAINT fk_datasources_formatted_views
FOREIGN KEY (datasource_id)
REFERENCES datasources (datasource_id)
ON UPDATE NO ACTION
ON DELETE RESTRICT;