MySQL shell:

kubectl run --rm -n forgejo -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh

Create the database and user:

CREATE DATABASE stenlund CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin';
create user 'forgejo'@'%';
grant all privileges on stenlund.* to 'forgejo'@'%';
alter user 'forgejo'@'%' identified by 'changeme';
