drop table PT;
drop table trainer_time;
drop table body_info;
drop table member_time;
drop table member;
drop table trainer;

create table member
	(id		varchar(5),--M0001, M0002 
	 name		varchar(13),
	 gender		varchar(5),
	 registration_date		numeric(8,0),
	 phone_number		varchar(13),
	 primary key (id)
	);


create table trainer
	(id		varchar(5),--T0001, T0002
	 name		varchar(13),
	 gender		varchar(5),
	 phone_number varchar(13),
	 primary key (id)
	);


create table member_time
	(member_id		varchar(5), 
	 day_of_week		varchar(5),--mon tues wed thurs fri sat sun
	 major_time		    numeric(2,0) check (6 < major_time and major_time < 24),--07시에서 23시만 가능
	 primary key (member_id, day_of_week, major_time),
	 foreign key (member_id) REFERENCES member (id)
		on delete cascade--member 지워지면 같이 지워지도록
	);

create table body_info
	(member_id		varchar(5), 
	 height		numeric(4,1),
	 weight		    numeric(4,1),
	 fat_percentage numeric(3,1),
	 muscle_mass numeric(3,1),
	 measure_date numeric(8,0),
	 primary key (member_id, measure_date),
	 foreign key (member_id) REFERENCES member (id)
		on delete cascade--member 지워지면 같이 지워지도록
	);

create table trainer_time
	(trainer_id		varchar(5), 
	 day_of_week		varchar(5),--mon tues wed thurs fri sat sun
	 major_time		    numeric(2,0) check (6 < major_time and major_time < 24),--07시에서 23시만 가능
	 primary key (trainer_id, day_of_week, major_time),
	 foreign key (trainer_id) REFERENCES trainer (id)
		on delete cascade--trainer 지워지면 같이 지워지도록
	);
	
create table PT
	(member_id varchar(5),
	 trainer_id varchar(5),
	 day_of_week varchar(5),--mon tues wed thurs fri sat sun
	 pt_time numeric(2,0) check (6 < pt_time and pt_time < 24),--07시에서 23시만 가능
	 primary key (trainer_id, day_of_week, pt_time),
	 foreign key (member_id, day_of_week, pt_time) REFERENCES member_time (member_id, day_of_week, major_time)
		on delete cascade,--member 지워지면 member 시간대 지워지고 그럼 PT정보도 같이 지워지도록
	 foreign key (trainer_id, day_of_week, pt_time) REFERENCES trainer_time (trainer_id, day_of_week, major_time)
		on delete cascade--trainer 지워지면 trainer 시간대 지워지고 그럼 PT정보도 같이 지워지도록
	);
	
insert into member values ('M0000', 'KimAA', 'Man', 20191124, '010-0000-0000');
insert into member values ('M0001', 'KimZZ', 'Woman', 20191125, '010-0000-0001');
insert into member values ('M0002', 'KimAA', 'Woman', 20200202, '010-0000-0002');
insert into member values ('M0003', 'KimBB', 'Man', 20200303, '010-0000-0003');
insert into member values ('M0004', 'KimCC', 'Woman', 20200404, '010-0000-0004');
insert into member values ('M0005', 'KimDD', 'Man', 20200404, '010-0000-0005');
insert into member values ('M0006', 'KimEE', 'Woman', 20200505, '010-0000-0006');
insert into member values ('M0007', 'KimFF', 'Man', 20200506, '010-0000-0007');
insert into member values ('M0008', 'KimGG', 'Woman', 20200507, '010-0000-0008');
insert into member values ('M0009', 'KimHH', 'Man', 20200508, '010-0000-0009');
insert into member values ('M0010', 'KimII', 'Man', 20191124, '010-0000-0010');
insert into member values ('M0011', 'KimJJ', 'Woman', 20191125, '010-0000-0011');
insert into member values ('M0012', 'KimKK', 'Woman', 20191126, '010-0000-0012');
insert into member values ('M0013', 'KimLL', 'Man', 20191126, '010-0000-0013');
insert into member values ('M0014', 'KimMM', 'Woman', 20191127, '010-0000-0014');
insert into member values ('M0015', 'KimNN', 'Man', 20191128, '010-0000-0015');
insert into member values ('M0016', 'KimOO', 'Woman', 20191129, '010-0000-0016');
insert into member values ('M0017', 'KimPP', 'Man', 20191129, '010-0000-0017');
insert into member values ('M0018', 'KimQQ', 'Woman', 20191201, '010-0000-0018');
insert into member values ('M0019', 'KimAA', 'Man', 20191202, '010-0000-0019');

insert into trainer values ('T0000', 'LeeAA', 'Man', '010-1000-0000');
insert into trainer values ('T0001', 'LeeBB', 'Man', '010-1000-0001');
insert into trainer values ('T0002', 'LeeCC', 'Woman', '010-1000-0002');
insert into trainer values ('T0003', 'LeeDD', 'Man', '010-1000-0003');
insert into trainer values ('T0004', 'LeeEE', 'Man', '010-1000-0004');
insert into trainer values ('T0005', 'LeeFF', 'Woman', '010-1000-0005');
insert into trainer values ('T0006', 'LeeGG', 'Man', '010-1000-0006');

-- 평균 -> 남자 체지방 10-30: 21~26 골격근량 체중 45~48% , 
-- 여자 체지방 21~ 36, 골격근량 체중 37~40%
insert into body_info values ('M0000', 181.0, 79.0, 20.5, 33.5, 20191124);
insert into body_info values ('M0000', 181.0, 74.2, 18.4, 34.5, 20191226);
insert into body_info values ('M0000', 181.3, 72.1, 16.5, 35, 20200121);
insert into body_info values ('M0001', 165.4, 53.3, 24.4, 20.7, 20191125);
insert into body_info values ('M0001', 165.4, 55.2, 25.1, 21.0, 20191225);
insert into body_info values ('M0002', 150.2, 53.2, 30.6, 16.2, 20200202);
insert into body_info values ('M0002', 150.2, 51.1, 29.2, 17.4, 20200302);
insert into body_info values ('M0003', 169.5, 75.2, 28.4, 35.7, 20200303);
insert into body_info values ('M0004', 172.5, 59.7, 33.2, 25.9, 20200404);
insert into body_info values ('M0005', 177.4, 63.8, 26.8, 36.4, 20200404);
insert into body_info values ('M0006', 156.0, 66.0, 31.4, 26.3, 20200505);
insert into body_info values ('M0007', 168.2, 68.9, 26.8, 37.5, 20200506);
insert into body_info values ('M0008', 161.0, 55.6, 27.1, 24.8, 20200507);
insert into body_info values ('M0009', 170.3, 83.9, 20.2, 28.0, 20200508);
insert into body_info values ('M0010', 185.1, 72.2, 30.7, 40.0, 20191124);
insert into body_info values ('M0011', 140.9, 63.6, 38.0, 29.0, 20191125);
insert into body_info values ('M0012', 155.7, 60.4, 36.1, 26.6, 20191126);
insert into body_info values ('M0013', 177.6, 70.1, 26.5, 30.7, 20191126);
insert into body_info values ('M0014', 172.5, 93.1, 20.9, 29.8, 20191127);
insert into body_info values ('M0015', 183.0, 91.4, 23.3, 31.7, 20191128);
insert into body_info values ('M0016', 167.1, 41.6, 22.7, 29.9, 20191129);
insert into body_info values ('M0017', 183.0, 91.4, 23.3, 31.7, 20191129);
insert into body_info values ('M0018', 165.2, 69.7, 33.7, 27.5, 20191201);
insert into body_info values ('M0019', 156.7, 91.5, 21.0, 39.9, 20191202);

insert into member_time values ('M0000', 'Wed', 12);
insert into member_time values ('M0000', 'Tues', 17);
insert into member_time values ('M0000', 'Tues', 13);
insert into member_time values ('M0000', 'Sat', 9);
insert into member_time values ('M0000', 'Wed', 20);
insert into member_time values ('M0000', 'Tues', 19);
insert into member_time values ('M0000', 'Thurs', 7);
insert into member_time values ('M0000', 'Mon', 12);
insert into member_time values ('M0001', 'Wed', 7);
insert into member_time values ('M0001', 'Tues', 16);
insert into member_time values ('M0001', 'Fri', 16);
insert into member_time values ('M0001', 'Wed', 23);
insert into member_time values ('M0001', 'Sat', 23);
insert into member_time values ('M0001', 'Mon', 23);
insert into member_time values ('M0001', 'Thurs', 11);
insert into member_time values ('M0001', 'Sat', 18);
insert into member_time values ('M0001', 'Sun', 15);
insert into member_time values ('M0001', 'Fri', 17);
insert into member_time values ('M0002', 'Tues', 23);
insert into member_time values ('M0002', 'Wed', 9);
insert into member_time values ('M0002', 'Thurs', 8);
insert into member_time values ('M0002', 'Sun', 19);
insert into member_time values ('M0002', 'Mon', 13);
insert into member_time values ('M0002', 'Sun', 12);
insert into member_time values ('M0002', 'Sat', 22);
insert into member_time values ('M0002', 'Sun', 10);
insert into member_time values ('M0002', 'Fri', 7);
insert into member_time values ('M0003', 'Sat', 12);
insert into member_time values ('M0003', 'Wed', 14);
insert into member_time values ('M0003', 'Sun', 18);
insert into member_time values ('M0003', 'Wed', 7);
insert into member_time values ('M0003', 'Wed', 12);
insert into member_time values ('M0003', 'Sat', 22);
insert into member_time values ('M0003', 'Mon', 23);
insert into member_time values ('M0003', 'Sat', 21);
insert into member_time values ('M0003', 'Wed', 16);
insert into member_time values ('M0003', 'Thurs', 21);
insert into member_time values ('M0004', 'Tues', 16);
insert into member_time values ('M0004', 'Sat', 9);
insert into member_time values ('M0004', 'Wed', 20);
insert into member_time values ('M0004', 'Sat', 23);
insert into member_time values ('M0004', 'Tues', 18);
insert into member_time values ('M0004', 'Mon', 15);
insert into member_time values ('M0004', 'Mon', 10);
insert into member_time values ('M0004', 'Mon', 17);
insert into member_time values ('M0004', 'Tues', 11);
insert into member_time values ('M0005', 'Wed', 21);
insert into member_time values ('M0005', 'Sun', 10);
insert into member_time values ('M0005', 'Sun', 7);
insert into member_time values ('M0005', 'Sat', 18);
insert into member_time values ('M0005', 'Sun', 21);
insert into member_time values ('M0005', 'Tues', 14);
insert into member_time values ('M0005', 'Mon', 17);
insert into member_time values ('M0005', 'Thurs', 12);
insert into member_time values ('M0005', 'Wed', 7);
insert into member_time values ('M0005', 'Wed', 20);
insert into member_time values ('M0006', 'Mon', 23);
insert into member_time values ('M0006', 'Thurs', 11);
insert into member_time values ('M0006', 'Fri', 8);
insert into member_time values ('M0006', 'Wed', 9);
insert into member_time values ('M0006', 'Thurs', 16);
insert into member_time values ('M0006', 'Fri', 13);
insert into member_time values ('M0006', 'Sun', 15);
insert into member_time values ('M0006', 'Thurs', 10);
insert into member_time values ('M0006', 'Tues', 19);
insert into member_time values ('M0007', 'Wed', 20);
insert into member_time values ('M0007', 'Sat', 19);
insert into member_time values ('M0007', 'Wed', 13);
insert into member_time values ('M0007', 'Fri', 19);
insert into member_time values ('M0007', 'Mon', 21);
insert into member_time values ('M0007', 'Sat', 14);
insert into member_time values ('M0007', 'Fri', 9);
insert into member_time values ('M0007', 'Fri', 7);
insert into member_time values ('M0007', 'Wed', 12);
insert into member_time values ('M0007', 'Mon', 11);
insert into member_time values ('M0008', 'Sun', 17);
insert into member_time values ('M0008', 'Fri', 8);
insert into member_time values ('M0008', 'Sat', 23);
insert into member_time values ('M0008', 'Sat', 13);
insert into member_time values ('M0008', 'Tues', 11);
insert into member_time values ('M0008', 'Wed', 21);
insert into member_time values ('M0008', 'Fri', 9);
insert into member_time values ('M0008', 'Sat', 20);
insert into member_time values ('M0008', 'Wed', 19);
insert into member_time values ('M0009', 'Sat', 16);
insert into member_time values ('M0009', 'Sat', 15);
insert into member_time values ('M0009', 'Sat', 21);
insert into member_time values ('M0009', 'Sat', 19);
insert into member_time values ('M0009', 'Wed', 15);
insert into member_time values ('M0009', 'Sat', 20);
insert into member_time values ('M0009', 'Mon', 14);
insert into member_time values ('M0009', 'Sun', 22);
insert into member_time values ('M0009', 'Sun', 9);
insert into member_time values ('M0009', 'Thurs', 23);
insert into member_time values ('M0010', 'Fri', 20);
insert into member_time values ('M0010', 'Sat', 21);
insert into member_time values ('M0010', 'Wed', 19);
insert into member_time values ('M0010', 'Fri', 15);
insert into member_time values ('M0010', 'Sun', 10);
insert into member_time values ('M0010', 'Sun', 9);
insert into member_time values ('M0010', 'Wed', 23);
insert into member_time values ('M0010', 'Wed', 10);
insert into member_time values ('M0010', 'Thurs', 18);
insert into member_time values ('M0010', 'Sat', 19);
insert into member_time values ('M0011', 'Fri', 23);
insert into member_time values ('M0011', 'Fri', 18);
insert into member_time values ('M0011', 'Fri', 13);
insert into member_time values ('M0011', 'Sat', 21);
insert into member_time values ('M0011', 'Fri', 12);
insert into member_time values ('M0011', 'Thurs', 18);
insert into member_time values ('M0011', 'Sun', 8);
insert into member_time values ('M0011', 'Wed', 10);
insert into member_time values ('M0011', 'Fri', 20);
insert into member_time values ('M0011', 'Tues', 9);
insert into member_time values ('M0012', 'Tues', 17);
insert into member_time values ('M0012', 'Mon', 7);
insert into member_time values ('M0012', 'Fri', 8);
insert into member_time values ('M0012', 'Sat', 7);
insert into member_time values ('M0012', 'Mon', 19);
insert into member_time values ('M0012', 'Wed', 18);
insert into member_time values ('M0012', 'Tues', 20);
insert into member_time values ('M0012', 'Wed', 10);
insert into member_time values ('M0012', 'Mon', 22);
insert into member_time values ('M0012', 'Wed', 12);
insert into member_time values ('M0013', 'Thurs', 13);
insert into member_time values ('M0013', 'Fri', 14);
insert into member_time values ('M0013', 'Thurs', 17);
insert into member_time values ('M0013', 'Sun', 9);
insert into member_time values ('M0013', 'Fri', 13);
insert into member_time values ('M0013', 'Sat', 8);
insert into member_time values ('M0013', 'Fri', 17);
insert into member_time values ('M0013', 'Fri', 7);
insert into member_time values ('M0013', 'Wed', 11);
insert into member_time values ('M0013', 'Fri', 15);
insert into member_time values ('M0014', 'Sat', 18);
insert into member_time values ('M0014', 'Sat', 20);
insert into member_time values ('M0014', 'Sun', 9);
insert into member_time values ('M0014', 'Tues', 13);
insert into member_time values ('M0014', 'Sun', 12);
insert into member_time values ('M0014', 'Sun', 21);
insert into member_time values ('M0014', 'Thurs', 21);
insert into member_time values ('M0014', 'Sat', 16);
insert into member_time values ('M0014', 'Mon', 8);
insert into member_time values ('M0014', 'Fri', 12);
insert into member_time values ('M0015', 'Thurs', 13);
insert into member_time values ('M0015', 'Thurs', 21);
insert into member_time values ('M0015', 'Tues', 16);
insert into member_time values ('M0015', 'Wed', 21);
insert into member_time values ('M0015', 'Sun', 17);
insert into member_time values ('M0015', 'Wed', 22);
insert into member_time values ('M0015', 'Thurs', 16);
insert into member_time values ('M0015', 'Mon', 22);
insert into member_time values ('M0015', 'Mon', 21);
insert into member_time values ('M0015', 'Fri', 7);
insert into member_time values ('M0016', 'Tues', 10);
insert into member_time values ('M0016', 'Mon', 23);
insert into member_time values ('M0016', 'Sat', 17);
insert into member_time values ('M0016', 'Thurs', 20);
insert into member_time values ('M0016', 'Sat', 9);
insert into member_time values ('M0016', 'Sun', 19);
insert into member_time values ('M0016', 'Wed', 17);
insert into member_time values ('M0016', 'Tues', 16);
insert into member_time values ('M0016', 'Thurs', 13);
insert into member_time values ('M0016', 'Mon', 21);
insert into member_time values ('M0017', 'Tues', 14);
insert into member_time values ('M0017', 'Wed', 20);
insert into member_time values ('M0017', 'Fri', 11);
insert into member_time values ('M0017', 'Sun', 22);
insert into member_time values ('M0017', 'Thurs', 22);
insert into member_time values ('M0017', 'Fri', 16);
insert into member_time values ('M0017', 'Fri', 17);
insert into member_time values ('M0017', 'Sun', 23);
insert into member_time values ('M0017', 'Wed', 12);
insert into member_time values ('M0018', 'Tues', 20);
insert into member_time values ('M0018', 'Thurs', 8);
insert into member_time values ('M0018', 'Mon', 23);
insert into member_time values ('M0018', 'Mon', 22);
insert into member_time values ('M0018', 'Fri', 12);
insert into member_time values ('M0018', 'Sat', 16);
insert into member_time values ('M0018', 'Sat', 20);
insert into member_time values ('M0018', 'Tues', 17);
insert into member_time values ('M0018', 'Mon', 10);
insert into member_time values ('M0018', 'Sun', 11);
insert into member_time values ('M0019', 'Sun', 22);
insert into member_time values ('M0019', 'Sun', 12);
insert into member_time values ('M0019', 'Sat', 12);
insert into member_time values ('M0019', 'Wed', 19);
insert into member_time values ('M0019', 'Tues', 17);
insert into member_time values ('M0019', 'Wed', 20);
insert into member_time values ('M0019', 'Sun', 20);
insert into member_time values ('M0019', 'Thurs', 17);
insert into member_time values ('M0019', 'Mon', 20);

insert into trainer_time values ('T0000', 'Mon', 7);
insert into trainer_time values ('T0000', 'Mon', 8);
insert into trainer_time values ('T0000', 'Mon', 9);
insert into trainer_time values ('T0000', 'Mon', 10);
insert into trainer_time values ('T0000', 'Mon', 11);
insert into trainer_time values ('T0000', 'Mon', 12);
insert into trainer_time values ('T0000', 'Mon', 13);
insert into trainer_time values ('T0000', 'Mon', 14);
insert into trainer_time values ('T0000', 'Mon', 15);
insert into trainer_time values ('T0000', 'Mon', 16);
insert into trainer_time values ('T0000', 'Mon', 17);
insert into trainer_time values ('T0000', 'Mon', 18);
insert into trainer_time values ('T0000', 'Mon', 19);
insert into trainer_time values ('T0000', 'Mon', 20);
insert into trainer_time values ('T0000', 'Mon', 21);
insert into trainer_time values ('T0000', 'Mon', 22);
insert into trainer_time values ('T0000', 'Mon', 23);
insert into trainer_time values ('T0001', 'Tues', 7);
insert into trainer_time values ('T0001', 'Tues', 8);
insert into trainer_time values ('T0001', 'Tues', 9);
insert into trainer_time values ('T0001', 'Tues', 10);
insert into trainer_time values ('T0001', 'Tues', 11);
insert into trainer_time values ('T0001', 'Tues', 12);
insert into trainer_time values ('T0001', 'Tues', 13);
insert into trainer_time values ('T0001', 'Tues', 14);
insert into trainer_time values ('T0001', 'Tues', 15);
insert into trainer_time values ('T0001', 'Tues', 16);
insert into trainer_time values ('T0001', 'Tues', 17);
insert into trainer_time values ('T0001', 'Tues', 18);
insert into trainer_time values ('T0001', 'Tues', 19);
insert into trainer_time values ('T0001', 'Tues', 20);
insert into trainer_time values ('T0001', 'Tues', 21);
insert into trainer_time values ('T0001', 'Tues', 22);
insert into trainer_time values ('T0001', 'Tues', 23);
insert into trainer_time values ('T0002', 'Wed', 7);
insert into trainer_time values ('T0002', 'Wed', 8);
insert into trainer_time values ('T0002', 'Wed', 9);
insert into trainer_time values ('T0002', 'Wed', 10);
insert into trainer_time values ('T0002', 'Wed', 11);
insert into trainer_time values ('T0002', 'Wed', 12);
insert into trainer_time values ('T0002', 'Wed', 13);
insert into trainer_time values ('T0002', 'Wed', 14);
insert into trainer_time values ('T0002', 'Wed', 15);
insert into trainer_time values ('T0002', 'Wed', 16);
insert into trainer_time values ('T0002', 'Wed', 17);
insert into trainer_time values ('T0002', 'Wed', 18);
insert into trainer_time values ('T0002', 'Wed', 19);
insert into trainer_time values ('T0002', 'Wed', 20);
insert into trainer_time values ('T0002', 'Wed', 21);
insert into trainer_time values ('T0002', 'Wed', 22);
insert into trainer_time values ('T0002', 'Wed', 23);
insert into trainer_time values ('T0003', 'Thurs', 7);
insert into trainer_time values ('T0003', 'Thurs', 8);
insert into trainer_time values ('T0003', 'Thurs', 9);
insert into trainer_time values ('T0003', 'Thurs', 10);
insert into trainer_time values ('T0003', 'Thurs', 11);
insert into trainer_time values ('T0003', 'Thurs', 12);
insert into trainer_time values ('T0003', 'Thurs', 13);
insert into trainer_time values ('T0003', 'Thurs', 14);
insert into trainer_time values ('T0003', 'Thurs', 15);
insert into trainer_time values ('T0003', 'Thurs', 16);
insert into trainer_time values ('T0003', 'Thurs', 17);
insert into trainer_time values ('T0003', 'Thurs', 18);
insert into trainer_time values ('T0003', 'Thurs', 19);
insert into trainer_time values ('T0003', 'Thurs', 20);
insert into trainer_time values ('T0003', 'Thurs', 21);
insert into trainer_time values ('T0003', 'Thurs', 22);
insert into trainer_time values ('T0003', 'Thurs', 23);
insert into trainer_time values ('T0004', 'Fri', 7);
insert into trainer_time values ('T0004', 'Fri', 8);
insert into trainer_time values ('T0004', 'Fri', 9);
insert into trainer_time values ('T0004', 'Fri', 10);
insert into trainer_time values ('T0004', 'Fri', 11);
insert into trainer_time values ('T0004', 'Fri', 12);
insert into trainer_time values ('T0004', 'Fri', 13);
insert into trainer_time values ('T0004', 'Fri', 14);
insert into trainer_time values ('T0004', 'Fri', 15);
insert into trainer_time values ('T0004', 'Fri', 16);
insert into trainer_time values ('T0004', 'Fri', 17);
insert into trainer_time values ('T0004', 'Fri', 18);
insert into trainer_time values ('T0004', 'Fri', 19);
insert into trainer_time values ('T0004', 'Fri', 20);
insert into trainer_time values ('T0004', 'Fri', 21);
insert into trainer_time values ('T0004', 'Fri', 22);
insert into trainer_time values ('T0004', 'Fri', 23);
insert into trainer_time values ('T0005', 'Sat', 7);
insert into trainer_time values ('T0005', 'Sat', 8);
insert into trainer_time values ('T0005', 'Sat', 9);
insert into trainer_time values ('T0005', 'Sat', 10);
insert into trainer_time values ('T0005', 'Sat', 11);
insert into trainer_time values ('T0005', 'Sat', 12);
insert into trainer_time values ('T0005', 'Sat', 13);
insert into trainer_time values ('T0005', 'Sat', 14);
insert into trainer_time values ('T0005', 'Sat', 15);
insert into trainer_time values ('T0005', 'Sat', 16);
insert into trainer_time values ('T0005', 'Sat', 17);
insert into trainer_time values ('T0005', 'Sat', 18);
insert into trainer_time values ('T0005', 'Sat', 19);
insert into trainer_time values ('T0005', 'Sat', 20);
insert into trainer_time values ('T0005', 'Sat', 21);
insert into trainer_time values ('T0005', 'Sat', 22);
insert into trainer_time values ('T0005', 'Sat', 23);
insert into trainer_time values ('T0006', 'Sun', 7);
insert into trainer_time values ('T0006', 'Sun', 8);
insert into trainer_time values ('T0006', 'Sun', 9);
insert into trainer_time values ('T0006', 'Sun', 10);
insert into trainer_time values ('T0006', 'Sun', 11);
insert into trainer_time values ('T0006', 'Sun', 12);
insert into trainer_time values ('T0006', 'Sun', 13);
insert into trainer_time values ('T0006', 'Sun', 14);
insert into trainer_time values ('T0006', 'Sun', 15);
insert into trainer_time values ('T0006', 'Sun', 16);
insert into trainer_time values ('T0006', 'Sun', 17);
insert into trainer_time values ('T0006', 'Sun', 18);
insert into trainer_time values ('T0006', 'Sun', 19);
insert into trainer_time values ('T0006', 'Sun', 20);
insert into trainer_time values ('T0006', 'Sun', 21);
insert into trainer_time values ('T0006', 'Sun', 22);
insert into trainer_time values ('T0006', 'Sun', 23);

insert into trainer_time values ('T0000', 'Tues', 7);
insert into trainer_time values ('T0000', 'Tues', 8);
insert into trainer_time values ('T0000', 'Tues', 9);
insert into trainer_time values ('T0000', 'Tues', 10);
insert into trainer_time values ('T0000', 'Tues', 11);
insert into trainer_time values ('T0000', 'Tues', 12);
insert into trainer_time values ('T0000', 'Tues', 13);
insert into trainer_time values ('T0000', 'Tues', 14);
insert into trainer_time values ('T0000', 'Tues', 15);
insert into trainer_time values ('T0000', 'Tues', 16);
insert into trainer_time values ('T0000', 'Tues', 17);
insert into trainer_time values ('T0000', 'Tues', 18);
insert into trainer_time values ('T0000', 'Tues', 19);
insert into trainer_time values ('T0000', 'Tues', 20);
insert into trainer_time values ('T0000', 'Tues', 21);
insert into trainer_time values ('T0000', 'Tues', 22);
insert into trainer_time values ('T0000', 'Tues', 23);
insert into trainer_time values ('T0001', 'Wed', 7);
insert into trainer_time values ('T0001', 'Wed', 8);
insert into trainer_time values ('T0001', 'Wed', 9);
insert into trainer_time values ('T0001', 'Wed', 10);
insert into trainer_time values ('T0001', 'Wed', 11);
insert into trainer_time values ('T0001', 'Wed', 12);
insert into trainer_time values ('T0001', 'Wed', 13);
insert into trainer_time values ('T0001', 'Wed', 14);
insert into trainer_time values ('T0001', 'Wed', 15);
insert into trainer_time values ('T0001', 'Wed', 16);
insert into trainer_time values ('T0001', 'Wed', 17);
insert into trainer_time values ('T0001', 'Wed', 18);
insert into trainer_time values ('T0001', 'Wed', 19);
insert into trainer_time values ('T0001', 'Wed', 20);
insert into trainer_time values ('T0001', 'Wed', 21);
insert into trainer_time values ('T0001', 'Wed', 22);
insert into trainer_time values ('T0001', 'Wed', 23);
insert into trainer_time values ('T0002', 'Thurs', 7);
insert into trainer_time values ('T0002', 'Thurs', 8);
insert into trainer_time values ('T0002', 'Thurs', 9);
insert into trainer_time values ('T0002', 'Thurs', 10);
insert into trainer_time values ('T0002', 'Thurs', 11);
insert into trainer_time values ('T0002', 'Thurs', 12);
insert into trainer_time values ('T0002', 'Thurs', 13);
insert into trainer_time values ('T0002', 'Thurs', 14);
insert into trainer_time values ('T0002', 'Thurs', 15);
insert into trainer_time values ('T0002', 'Thurs', 16);
insert into trainer_time values ('T0002', 'Thurs', 17);
insert into trainer_time values ('T0002', 'Thurs', 18);
insert into trainer_time values ('T0002', 'Thurs', 19);
insert into trainer_time values ('T0002', 'Thurs', 20);
insert into trainer_time values ('T0002', 'Thurs', 21);
insert into trainer_time values ('T0002', 'Thurs', 22);
insert into trainer_time values ('T0002', 'Thurs', 23);
insert into trainer_time values ('T0003', 'Fri', 7);
insert into trainer_time values ('T0003', 'Fri', 8);
insert into trainer_time values ('T0003', 'Fri', 9);
insert into trainer_time values ('T0003', 'Fri', 10);
insert into trainer_time values ('T0003', 'Fri', 11);
insert into trainer_time values ('T0003', 'Fri', 12);
insert into trainer_time values ('T0003', 'Fri', 13);
insert into trainer_time values ('T0003', 'Fri', 14);
insert into trainer_time values ('T0003', 'Fri', 15);
insert into trainer_time values ('T0003', 'Fri', 16);
insert into trainer_time values ('T0003', 'Fri', 17);
insert into trainer_time values ('T0003', 'Fri', 18);
insert into trainer_time values ('T0003', 'Fri', 19);
insert into trainer_time values ('T0003', 'Fri', 20);
insert into trainer_time values ('T0003', 'Fri', 21);
insert into trainer_time values ('T0003', 'Fri', 22);
insert into trainer_time values ('T0003', 'Fri', 23);
insert into trainer_time values ('T0004', 'Sat', 7);
insert into trainer_time values ('T0004', 'Sat', 8);
insert into trainer_time values ('T0004', 'Sat', 9);
insert into trainer_time values ('T0004', 'Sat', 10);
insert into trainer_time values ('T0004', 'Sat', 11);
insert into trainer_time values ('T0004', 'Sat', 12);
insert into trainer_time values ('T0004', 'Sat', 13);
insert into trainer_time values ('T0004', 'Sat', 14);
insert into trainer_time values ('T0004', 'Sat', 15);
insert into trainer_time values ('T0004', 'Sat', 16);
insert into trainer_time values ('T0004', 'Sat', 17);
insert into trainer_time values ('T0004', 'Sat', 18);
insert into trainer_time values ('T0004', 'Sat', 19);
insert into trainer_time values ('T0004', 'Sat', 20);
insert into trainer_time values ('T0004', 'Sat', 21);
insert into trainer_time values ('T0004', 'Sat', 22);
insert into trainer_time values ('T0004', 'Sat', 23);
insert into trainer_time values ('T0005', 'Sun', 7);
insert into trainer_time values ('T0005', 'Sun', 8);
insert into trainer_time values ('T0005', 'Sun', 9);
insert into trainer_time values ('T0005', 'Sun', 10);
insert into trainer_time values ('T0005', 'Sun', 11);
insert into trainer_time values ('T0005', 'Sun', 12);
insert into trainer_time values ('T0005', 'Sun', 13);
insert into trainer_time values ('T0005', 'Sun', 14);
insert into trainer_time values ('T0005', 'Sun', 15);
insert into trainer_time values ('T0005', 'Sun', 16);
insert into trainer_time values ('T0005', 'Sun', 17);
insert into trainer_time values ('T0005', 'Sun', 18);
insert into trainer_time values ('T0005', 'Sun', 19);
insert into trainer_time values ('T0005', 'Sun', 20);
insert into trainer_time values ('T0005', 'Sun', 21);
insert into trainer_time values ('T0005', 'Sun', 22);
insert into trainer_time values ('T0005', 'Sun', 23);
insert into trainer_time values ('T0006', 'Mon', 7);
insert into trainer_time values ('T0006', 'Mon', 8);
insert into trainer_time values ('T0006', 'Mon', 9);
insert into trainer_time values ('T0006', 'Mon', 10);
insert into trainer_time values ('T0006', 'Mon', 11);
insert into trainer_time values ('T0006', 'Mon', 12);
insert into trainer_time values ('T0006', 'Mon', 13);
insert into trainer_time values ('T0006', 'Mon', 14);
insert into trainer_time values ('T0006', 'Mon', 15);
insert into trainer_time values ('T0006', 'Mon', 16);
insert into trainer_time values ('T0006', 'Mon', 17);
insert into trainer_time values ('T0006', 'Mon', 18);
insert into trainer_time values ('T0006', 'Mon', 19);
insert into trainer_time values ('T0006', 'Mon', 20);
insert into trainer_time values ('T0006', 'Mon', 21);
insert into trainer_time values ('T0006', 'Mon', 22);
insert into trainer_time values ('T0006', 'Mon', 23);

insert into PT values ('M0000', 'T0001', 'Wed', 12);
insert into PT values ('M0000', 'T0000', 'Tues', 17);
insert into PT values ('M0001', 'T0001', 'Wed', 7);
insert into PT values ('M0001', 'T0000', 'Tues', 16);
insert into PT values ('M0002', 'T0000', 'Tues', 23);
insert into PT values ('M0002', 'T0001', 'Wed', 9);
insert into PT values ('M0003', 'T0004', 'Sat', 12);
insert into PT values ('M0003', 'T0001', 'Wed', 14);
insert into PT values ('M0004', 'T0001', 'Tues', 16);
insert into PT values ('M0004', 'T0004', 'Sat', 9);
insert into PT values ('M0005', 'T0001', 'Wed', 21);
insert into PT values ('M0005', 'T0005', 'Sun', 10);
insert into PT values ('M0006', 'T0000', 'Mon', 23);
insert into PT values ('M0006', 'T0002', 'Thurs', 11);
insert into PT values ('M0007', 'T0001', 'Wed', 20);
insert into PT values ('M0007', 'T0004', 'Sat', 19);
insert into PT values ('M0008', 'T0006', 'Sun', 17);
insert into PT values ('M0008', 'T0003', 'Fri', 8);
insert into PT values ('M0009', 'T0004', 'Sat', 16);