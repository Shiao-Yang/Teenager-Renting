/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/5/11 16:44:41                           */
/*==============================================================*/


drop table if exists Admins;

drop table if exists Carts;

drop table if exists Complaints;

drop table if exists Houses;

drop table if exists Orders;

drop table if exists Tickets;

drop table if exists Users;

drop table if exists Workers;

/*==============================================================*/
/* Table: Admins                                                */
/*==============================================================*/
create table Admins
(
   id                   int not NULL auto_increment,
   name                 varchar(30),
   username             varchar(18) not null,
   password             varchar(18) not null,
   primary key (id)
);

/*==============================================================*/
/* Table: Carts                                                 */
/*==============================================================*/
create table Carts
(
   id                   int auto_increment,
   hid                  int not null,
   uid                  int not null,
   primary key(id)
);

/*==============================================================*/
/* Table: Complaints                                            */
/*==============================================================*/
create table Complaints
(
   id                   int not null auto_increment,
   uid                  int not null,
   tid                  int not null,
   contents             text not null,
   pictures             longblob,
   reply                text,
   primary key (id)
);

/*==============================================================*/
/* Table: Houses                                                */
/*==============================================================*/
create table Houses
(
   id                   int not null auto_increment,
   short_price          float not null,
   long_price           float not null,
   location             varchar(254),
   area                 float,
   available            bool,
   type                 int,
   floor_plan           longblob,
   pictures             longblob,
   details              text,
   primary key (id)
);

/*==============================================================*/
/* Table: Orders                                                */
/*==============================================================*/
create table Orders
(
   id                   int not null auto_increment,
   uid                  int not null,
   hid                  int not null,
   type                 bool,
   paid                 bool,
   status               int,
   order_time           datetime not null,
   duration             int not null,
   amount               float not null,
   details              text,
   primary key (id)
);

/*==============================================================*/
/* Table: Tickets                                               */
/*==============================================================*/
create table Tickets
(
   id                   int not null auto_increment,
   wid                  int,
   uid                  int not null,
   hid                  int not null,
   info                 text,
   status               int not null,
   date                 date,
   materials_pic        longblob,
   materials_text       text,
   comment              int,
   pictures             longblob,
   details              text,
   primary key (id)
);

/*==============================================================*/
/* Table: Users                                                 */
/*==============================================================*/
create table Users
(
   id                   int not null auto_increment,
   username             varchar(18) not null,
   password             varchar(18) not null,
   avatar               longblob,
   tel                  varchar(11),
   email                varchar(30),
   name                 varchar(30) not null,
   age                  int,
   sex                  int,
   primary key (id)
);

/*==============================================================*/
/* Table: Workers                                               */
/*==============================================================*/
create table Workers
(
   id                   int not null auto_increment,
   username             varchar(18) not null,
   password             varchar(18) not null,
   name                 varchar(30) not null,
   tel                  varchar(11),
   photo                longblob,
   description          text,
   primary key (id)
);

alter table Carts add constraint FK_加入购物车 foreign key (uid)
      references Users (id) on delete restrict on update restrict;

alter table Carts add constraint FK_被加入购物车 foreign key (hid)
      references Houses (id) on delete restrict on update restrict;

alter table Complaints add constraint FK_投诉 foreign key (uid)
      references Users (id) on delete restrict on update restrict;

alter table Complaints add constraint FK_被投诉 foreign key (tid)
      references Tickets (id) on delete restrict on update restrict;

alter table Orders add constraint FK_下单 foreign key (uid)
      references Users (id) on delete restrict on update restrict;

alter table Orders add constraint FK_参与订单 foreign key (hid)
      references Houses (id) on delete restrict on update restrict;

alter table Tickets add constraint FK_报修 foreign key (uid)
      references Users (id) on delete restrict on update restrict;

alter table Tickets add constraint FK_接单 foreign key (wid)
      references Workers (id) on delete restrict on update restrict;

alter table Tickets add constraint FK_维修 foreign key (hid)
      references Houses (id) on delete restrict on update restrict;

