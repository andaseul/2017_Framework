create table class (
	code varchar(50) primary key,
	title varchar(100),
	teacher_name varchar(50),
	start_date date,
	end_date date,
	cur_stunum int default 0,
	limit_num int default 20,
	attendance_day int
);

create table staff (
	staff_code TINYINT primary key,
	staff_name varchar(50)
);

create table employee (
	id varchar(50) primary key,
	pw varchar(50) not null,
	name varchar(50) not null,
	gender varchar(5) default '��',
	address varchar(500),
	mail varchar(20),
	birthday date,
	joindate date,
	account_name varchar(50),
	account varchar(50),
	phone varchar(50),
	staff_code TINYINT,
	foreign key (staff_code) references staff(staff_code) 
);

create table student (
	id varchar(50) primary key,
	pw varchar(50) not null,
	name varchar(50) not null,
	gender varchar(5) default '��',
	address varchar(500),
	mail varchar(50),
	birthday date,
	approve TINYINT default 0,
	phone varchar(50),
	class_code varchar(50),
	foreign key (class_code) references class(code) 
);

create table teacher (
	id varchar(50) primary key,
	name varchar(50) not null,
	staff_code TINYINT default 3,
	class_code varchar(50),
	foreign key (id) references employee(id) on delete cascade,
	foreign key (staff_code) references staff(staff_code) on delete cascade,
	foreign key (class_code) references class(code) on delete cascade
);

create table ceo (
	id varchar(50) primary key,
	name varchar(50) not null,
	staff_code TINYINT default 2,
	foreign key (id) references employee(id) on delete cascade,
	foreign key (staff_code) references staff(staff_code)
);


create table administration (
	id varchar(50) primary key,
	name varchar(50) not null,
	staff_code TINYINT default 2,
	foreign key (id) references employee(id) on delete cascade,
	foreign key (staff_code) references staff(staff_code)
);

create table jobsupport (
	id varchar(50) primary key,
	name varchar(50) not null,
	staff_code TINYINT default 5,
	foreign key (id) references employee(id) on delete cascade,
	foreign key (staff_code) references staff(staff_code) on delete cascade
);

create table salse (
	id varchar(50) primary key,
	name varchar(50) not null,
	staff_code TINYINT default 4,
	foreign key (id) references employee(id) on delete cascade,
	foreign key (staff_code) references staff(staff_code) on delete cascade
);

create table attend_info (
	curdate date,
	curmonth int,
	class_code varchar(50),
	foreign key (class_code) references class(code) on delete cascade
);

create table attend (
	curdate date default '2017-01-01',
	curtime time default '00:00:00',
	state TINYINT default 0,
	stu_id varchar(50),
	class_code varchar(50),
	foreign key (stu_id) references student(id) on delete cascade,
	foreign key (class_code) references class(code) on delete cascade
);


create table subject (
	code varchar(50) primary key,
	title varchar(100),
	class_code varchar(50),
	exam TINYINT default 0,
	foreign key (class_code) references class(code) on delete cascade
);

create table question (
	qcode varchar(50) primary key,
	question varchar(5000) not null,
	example1 varchar(1000) not null,
	example2 varchar(1000) not null,
	example3 varchar(1000) not null,
	example4 varchar(1000) not null,
	example5 varchar(1000) not null,
	answer TINYINT not null,
	sub_code varchar(20),
	foreign key (sub_code) references subject(code) on delete cascade
);

create table stu_exam (
	id varchar(50),
	qcode varchar(50),
	sub_code varchar(50),
	answer TINYINT,
	foreign key (id) references student(id) on delete cascade,
	foreign key (qcode) references question(qcode) on delete cascade,
	foreign key (sub_code) references subject(code) on delete cascade
);

create table stu_grade (
	id varchar(50),
	sub_code varchar(50),
	score int default 0,
	total_score int default 100,
	foreign key (id) references student(id) on delete cascade,
	foreign key (sub_code) references subject(code) on delete cascade
);

create table notice_bbs (
	idx int(10) not null auto_increment primary key,
	name varchar(50) default '�Ѻ����� ������',
	title varchar(500),
	memo varchar(5000),
	curdate date,
	curtime time,
	hit int(11) default 0
);

create table inquiry_bbs (
	idx int(10) not null auto_increment primary key,
	name varchar(50),
	phone varchar(50),
	title varchar(500),
	memo varchar(5000),
	flag int default 0,
	curdate date,
	curtime time,
	hit int(11) default 0
);

create table classnotice_bbs (
	idx int(10) not null auto_increment primary key,
	name varchar(50) default '���ǰ�����',
	title varchar(500),
	memo varchar(5000),
	curdate date,
	curtime time,
	hit int(11) default 0,
	class_code varchar(50),
	foreign key (class_code) references class(code) on delete cascade
);

create table recruitInfo_bbs (
	idx int(10) not null auto_increment primary key,
	name varchar(50) default '���������',
	title varchar(500),
	memo varchar(5000),
	curdate date,
	curtime time,
	file varchar(200),
	file_size int,
	hit int(11) default 0
);

create table consultingbbs (
	idx int(10) not null auto_increment primary key,
	name varchar(50),
	title varchar(500),
	memo varchar(5000),
	curdate date,
	curtime time,
	file varchar(200),
	file_size int,
	hit int(11) default 0,
	grp int(11) default 0,
	seq int(11) default 1,
	lvl int(11) default 0 
);

create table classqabbs (
	idx int(10) not null auto_increment primary key,
	name varchar(50),
	title varchar(500),
	memo varchar(5000),
	curdate date,
	curtime time,
	file varchar(200),
	file_size int,
	hit int(11) default 0,
	grp int(11) default 0,
	seq int(11) default 1,
	lvl int(11) default 0,
	class_code varchar(50),
	foreign key (class_code) references class(code) on delete cascade
);

create table student_job (
	id varchar(50) primary key,
	name varchar(50), 
	job int default 0,
	foreign key (id) references student(id) on delete cascade
);



insert into staff values(2, '������');
insert into staff values(3, '������');
insert into staff values(4, '������');
insert into staff values(5, '���������');
insert into staff values(6, '��ǥ�̻�');

insert into class values('class01', 'UI/UX�� ������� �� ����Ʈ �� �������� ������ ����', '����01', '2017-03-02', '2017-05-31', 4, 20, 65);
insert into class values('class02', '������ �м� �� ����SW�����Ͼ �缺 ����', '����02', '2017-07-01', '2017-10-31', 0, 20, 90);
insert into class values('class03', 'Interactive Web Design�� ���� Web Publisher �缺 ����', '����03', '2017-07-01', '2017-10-31', 0, 20, 90);

insert into student values('stu01', '1234', '������', '��', '�����', 'stu01@hanbit.com', '1980-01-01', 1, '010-1234-1234', 'class01');
insert into student values('stu02', '1234', '���ȣ', '��', '�����', 'stu02@hanbit.com', '1981-02-02', 1, '010-1234-1234', 'class01');
insert into student values('stu03', '1234', '�ȴٽ�', '��', '�����', 'stu03@hanbit.com', '1982-03-03', 1, '010-1234-1234', 'class01');
insert into student values('stu04', '1234', '���ؽ�', '��', '���ֽ�', 'stu04@hanbit.com', '1983-04-04', 1, '010-1234-1234', 'class01');

insert into student values('stu05', '1234', '��û��01', '��', '�����', 'stu05@hanbit.com', '1980-01-01', 0, '010-1234-1234', 'class02');
insert into student values('stu06', '1234', '��û��02', '��', '�����', 'stu06@hanbit.com', '1981-02-02', 0, '010-1234-1234', 'class02');
insert into student values('stu07', '1234', '��û��03', '��', '�����', 'stu07@hanbit.com', '1982-03-03', 0, '010-1234-1234', 'class03');
insert into student values('stu08', '1234', '��û��04', '��', '���ֽ�', 'stu08@hanbit.com', '1983-04-04', 0, '010-1234-1234', 'class02');
insert into student values('stu09', '1234', '��û��05', '��', '���ֽ�', 'stu09@hanbit.com', '1983-04-04', 0, '010-1234-1234', 'class03');

insert into employee values('emp01', '1234', '����01', '��', '�����', 'emp01@hanbit.com', '1980-02-01', '2015-03-02', '����', '102-1214-123456', '010-1234-1234', 2);
insert into employee values('emp02', '1234', '����01', '��', '�����', 'emp02@hanbit.com', '1980-03-03', '2015-03-02', '����', '103-1214-123456', '010-1234-1234', 3);
insert into employee values('emp03', '1234', '����02', '��', '�����', 'emp03@hanbit.com', '1981-03-03', '2015-03-02', '����', '104-1214-123456', '010-1234-1234', 3);
insert into employee values('emp04', '1234', '����03', '��', '�����', 'emp04@hanbit.com', '1982-03-03', '2015-03-02', '����', '105-1214-123456', '010-1234-1234', 3);
insert into employee values('emp05', '1234', '����01', '��', '�����', 'emp05@hanbit.com', '1982-03-03', '2015-03-02', '����', '106-1214-123456', '010-1234-1234', 4);
insert into employee values('emp06', '1234', '���01', '��', '�����', 'emp06@hanbit.com', '1982-03-03', '2015-03-02', '����', '107-1214-123456', '010-1234-1234', 5);
insert into employee values('emp00', '1234', '����ȣ', '��', '�����', 'emp00@hanbit.com', '1982-03-03', '2015-03-02', '����', '107-1214-123456', '010-1234-1234', 6);

insert into teacher values('emp02', '����01', 3, 'class01');
insert into teacher values('emp03', '����02', 3, 'class02');
insert into teacher values('emp04', '����03', 3, 'class03');

insert into administration values('emp01', '����01', 2);
insert into salse values('emp05', '����01', 4);
insert into jobsupport values('emp06', '���01', 5);
insert into ceo values('emp00', '��ǥ�̻�', 6);

insert into subject values('class01-1', 'Java & Oracle', 'class01', 0);
insert into subject values('class01-2', 'JavaScript & JQuery', 'class01', 0);
insert into subject values('class01-3', 'Spring Framwork', 'class01', 0);

insert into subject values('class02-1', 'R���α׷���', 'class02', 0);
insert into subject values('class02-2', '�����͸��̴� �̷а� �ǽ�', 'class02', 0);
insert into subject values('class02-3', 'HTML & JavasScript �������� ũ�Ѹ�', 'class02', 0);

insert into subject values('class03-1', 'Java', 'class03', 0);
insert into subject values('class03-2', 'HTML5 & CSS', 'class03', 0);
insert into subject values('class03-3', 'JavaScript & JQuery', 'class03', 0);


insert into question values('class01-1-01', '����1', '����1', '����2', '����3', '����4', '����5', 3, 'class01-1');
insert into question values('class01-1-02', '����2', '����1', '����2', '����3', '����4', '����5', 1, 'class01-1');
insert into question values('class01-1-03', '����3', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-04', '����4', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-05', '����5', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-06', '����6', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-07', '����7', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-08', '����8', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-09', '����9', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');
insert into question values('class01-1-10', '����10', '����1', '����2', '����3', '����4', '����5', 5, 'class01-1');

insert into question values('class01-2-01', '����1', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-02', '����2', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-03', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-04', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-05', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-06', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-07', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-08', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-09', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');
insert into question values('class01-2-10', '����3', '����1', '����2', '����3', '����4', '����5', 3, 'class01-2');

insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '��ǥ�̻�', '�Ѻ��������� - ȫ���� Open', '����1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '�Ѻ����� ������', '����2', '����2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '�Ѻ����� ������', '����3', '����3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '��ǥ�̻�', '����4', '����4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '�Ѻ����� ������', '����5', '����5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '�Ѻ����� ������', '����6', '����6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '�Ѻ����� ������', '����7', '����7');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '��ǥ�̻�', '�Ѻ��������� - ȫ���� Open', '����1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '�Ѻ����� ������', '����2', '����2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '�Ѻ����� ������', '����3', '����3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '��ǥ�̻�', '����4', '����4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '�Ѻ����� ������', '����5', '����5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '�Ѻ����� ������', '����6', '����6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '�Ѻ����� ������', '����7', '����7');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '��ǥ�̻�', '�Ѻ��������� - ȫ���� Open', '����1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '�Ѻ����� ������', '����2', '����2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '�Ѻ����� ������', '����3', '����3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '��ǥ�̻�', '����4', '����4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '�Ѻ����� ������', '����5', '����5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '�Ѻ����� ������', '����6', '����6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '�Ѻ����� ������', '����7', '����7');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '��ǥ�̻�', '�Ѻ��������� - ȫ���� Open', '����1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '�Ѻ����� ������', '����2', '����2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '�Ѻ����� ������', '����3', '����3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '��ǥ�̻�', '����4', '����4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '�Ѻ����� ������', '����5', '����5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '�Ѻ����� ������', '����6', '����6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '�Ѻ����� ������', '����7', '����7');


insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-26', '09:00:00', '���ǰ�����', '���ǰ���1', '���ǰ���1', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-27', '16:22:00', '���ǰ�����', '���ǰ���2', '���ǰ���2', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-28', '09:46:00', '���ǰ�����', '���ǰ���3', '���ǰ���3', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-29', '09:02:00', '���ǰ�����', '���ǰ���4', '���ǰ���4', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-30', '09:11:00', '���ǰ�����', '���ǰ���5', '���ǰ���5', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-02', '10:00:00', '���ǰ�����', '���ǰ���6', '���ǰ���6', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-05', '09:30:00', '���ǰ�����', '���ǰ���7', '���ǰ���7', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-26', '09:00:00', '���ǰ�����', '���ǰ���8', '���ǰ���8', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-27', '16:22:00', '���ǰ�����', '���ǰ���9', '���ǰ���9', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-28', '09:46:00', '���ǰ�����', '���ǰ���10', '���ǰ���10', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-29', '09:02:00', '���ǰ�����', '���ǰ���11', '���ǰ���11', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-30', '09:11:00', '���ǰ�����', '���ǰ���12', '���ǰ���12', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-02', '10:00:00', '���ǰ�����', '���ǰ���13', '���ǰ���13', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-05', '09:30:00', '���ǰ�����', '���ǰ���14', '���ǰ���14', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-26', '09:00:00', '���ǰ�����', '���ǰ���15', '���ǰ���15', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-27', '16:22:00', '���ǰ�����', '���ǰ���16', '���ǰ���16', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-28', '09:46:00', '���ǰ�����', '���ǰ���17', '���ǰ���17', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-29', '09:02:00', '���ǰ�����', '���ǰ���18', '���ǰ���18', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-30', '09:11:00', '���ǰ�����', '���ǰ���19', '���ǰ���19', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-02', '10:00:00', '���ǰ�����', '���ǰ���20', '���ǰ���20', 'class01');


insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-26', '09:00:00', 'stu01', '�����־��1', '�����־��', 1, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-27', '16:22:00', 'stu02', '�����־��2', '�����־��', 2, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-28', '09:46:00', 'stu01', '�����־��3', '�����־��', 3, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-29', '09:02:00', 'stu03', '�����־��4', '�����־��', 4, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-30', '09:11:00', 'stu04', '�����־��5', '�����־��', 5, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-02', '10:00:00', 'stu04', '�����־��6', '�����־��', 6, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-05', '09:30:00', 'stu02', '�����־��7', '�����־��', 7, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-26', '09:00:00', 'stu01', '�����־��8', '�����־��', 8, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-27', '16:22:00', 'stu02', '�����־��9', '�����־��', 9, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-28', '09:46:00', 'stu01', '�����־��10', '�����־��', 10, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-29', '09:02:00', 'stu03', '�����־��11', '�����־��', 11, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-30', '09:11:00', 'stu04', '�����־��12', '�����־��', 12, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-02', '10:00:00', 'stu04', '�����־��13', '�����־��', 13, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-05', '09:30:00', 'stu02', '�����־��14', '�����־��', 14, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-26', '09:00:00', 'stu01', '�����־��15', '�����־��', 15, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-27', '16:22:00', 'stu02', '�����־��16', '�����־��', 16, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-28', '09:46:00', 'stu01', '�����־��17', '�����־��', 17, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-29', '09:02:00', 'stu03', '�����־��18', '�����־��', 18, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-30', '09:11:00', 'stu04', '�����־��19', '�����־��', 19, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-02', '10:00:00', 'stu04', '�����־��20', '�����־��', 20, 'class01');


insert into attend_info(curdate, curmonth, class_code) values('2017-03-02', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-03', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-06', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-07', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-08', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-09', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-10', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-13', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-14', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-15', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-16', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-17', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-20', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-21', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-22', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-23', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-24', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-27', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-28', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-29', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-30', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-03-31', 3, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-03', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-04', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-05', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-06', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-07', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-10', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-11', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-12', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-13', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-14', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-17', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-18', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-19', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-20', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-21', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-24', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-25', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-26', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-27', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-04-28', 4, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-01', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-02', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-03', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-04', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-05', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-08', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-09', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-10', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-11', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-12', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-15', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-16', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-17', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-18', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-19', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-22', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-23', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-24', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-25', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-26', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-29', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-30', 5, 'class01');
insert into attend_info(curdate, curmonth, class_code) values('2017-05-31', 5, 'class01');

insert into attend values('2017-03-02', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-03', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-06', '09:00:00', 3, 'stu01', 'class01');
insert into attend values('2017-03-07', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-08', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-09', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-10', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-03-13', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-14', '09:00:00', 3, 'stu01', 'class01');
insert into attend values('2017-03-15', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-16', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-17', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-20', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-21', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-22', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-23', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-03-24', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-03-28', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-29', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-03-30', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-03-31', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-03', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-04', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-05', '09:00:00', 3, 'stu01', 'class01');
insert into attend values('2017-04-06', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-07', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-10', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-11', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-12', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-04-13', '09:00:00', 3, 'stu01', 'class01');
insert into attend values('2017-04-14', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-17', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-18', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-04-19', '09:00:00', 3, 'stu01', 'class01');
insert into attend values('2017-04-20', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-21', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-24', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-04-25', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-26', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-27', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-04-28', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-01', '09:00:00', 3, 'stu01', 'class01');
insert into attend values('2017-05-02', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-03', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-04', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-05', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-05-08', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-05-09', '09:00:00', 2, 'stu01', 'class01');
insert into attend values('2017-05-10', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-11', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-12', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-15', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-16', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-17', '09:00:00', 1, 'stu01', 'class01');
insert into attend values('2017-05-18', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-19', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-22', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-23', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-24', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-25', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-26', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-29', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-30', '09:00:00', 0, 'stu01', 'class01');
insert into attend values('2017-05-31', '09:00:00', 0, 'stu01', 'class01');

insert into attend values('2017-03-02', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-03', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-03-06', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-03-07', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-08', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-09', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-10', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-03-13', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-14', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-03-15', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-16', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-17', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-20', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-21', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-22', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-23', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-03-24', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-03-28', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-29', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-03-30', '09:00:00', 2, 'stu02', 'class01');
insert into attend values('2017-03-31', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-03', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-04', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-04-05', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-04-06', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-07', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-10', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-11', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-12', '09:00:00', 2, 'stu02', 'class01');
insert into attend values('2017-04-13', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-04-14', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-17', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-04-18', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-04-19', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-04-20', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-21', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-24', '09:00:00', 2, 'stu02', 'class01');
insert into attend values('2017-04-25', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-04-26', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-27', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-04-28', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-01', '09:00:00', 3, 'stu02', 'class01');
insert into attend values('2017-05-02', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-03', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-04', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-05', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-08', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-09', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-10', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-11', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-12', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-15', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-16', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-17', '09:00:00', 1, 'stu02', 'class01');
insert into attend values('2017-05-18', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-19', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-22', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-23', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-24', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-25', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-26', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-29', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-30', '09:00:00', 0, 'stu02', 'class01');
insert into attend values('2017-05-31', '09:00:00', 0, 'stu02', 'class01');

insert into attend values('2017-03-02', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-03', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-06', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-07', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-08', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-09', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-10', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-03-13', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-14', '09:00:00', 3, 'stu03', 'class01');
insert into attend values('2017-03-15', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-03-16', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-17', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-20', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-21', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-03-22', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-23', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-03-24', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-03-28', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-29', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-03-30', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-03-31', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-03', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-04', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-05', '09:00:00', 3, 'stu03', 'class01');
insert into attend values('2017-04-06', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-07', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-10', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-11', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-12', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-04-13', '09:00:00', 3, 'stu03', 'class01');
insert into attend values('2017-04-14', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-17', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-18', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-04-19', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-04-20', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-21', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-24', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-04-25', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-26', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-27', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-04-28', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-01', '09:00:00', 3, 'stu03', 'class01');
insert into attend values('2017-05-02', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-03', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-04', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-05', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-08', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-05-09', '09:00:00', 2, 'stu03', 'class01');
insert into attend values('2017-05-10', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-11', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-12', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-15', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-16', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-17', '09:00:00', 1, 'stu03', 'class01');
insert into attend values('2017-05-18', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-19', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-22', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-23', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-24', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-25', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-26', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-29', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-30', '09:00:00', 0, 'stu03', 'class01');
insert into attend values('2017-05-31', '09:00:00', 0, 'stu03', 'class01');

insert into attend values('2017-03-02', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-03', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-06', '09:00:00', 3, 'stu04', 'class01');
insert into attend values('2017-03-07', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-08', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-09', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-10', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-03-13', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-14', '09:00:00', 3, 'stu04', 'class01');
insert into attend values('2017-03-15', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-16', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-17', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-20', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-21', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-22', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-23', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-03-24', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-03-28', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-29', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-03-30', '09:00:00', 2, 'stu04', 'class01');
insert into attend values('2017-03-31', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-03', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-04', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-05', '09:00:00', 3, 'stu04', 'class01');
insert into attend values('2017-04-06', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-07', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-10', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-11', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-12', '09:00:00', 2, 'stu04', 'class01');
insert into attend values('2017-04-13', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-14', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-04-17', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-18', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-19', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-20', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-21', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-24', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-04-25', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-26', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-27', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-04-28', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-01', '09:00:00', 3, 'stu04', 'class01');
insert into attend values('2017-05-02', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-03', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-04', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-05', '09:00:00', 2, 'stu04', 'class01');
insert into attend values('2017-05-08', '09:00:00', 2, 'stu04', 'class01');
insert into attend values('2017-05-09', '09:00:00', 2, 'stu04', 'class01');
insert into attend values('2017-05-10', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-11', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-12', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-15', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-16', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-17', '09:00:00', 1, 'stu04', 'class01');
insert into attend values('2017-05-18', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-19', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-22', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-23', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-24', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-25', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-26', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-29', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-30', '09:00:00', 0, 'stu04', 'class01');
insert into attend values('2017-05-31', '09:00:00', 0, 'stu04', 'class01');

insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����1', '�ڼҼ� ÷���� ����', 1);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '�ڼҼ� ÷���� ����2', '�ڼҼ� ÷���� ����', 2);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����3', '�ڼҼ� ÷���� ����', 3);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '�ڼҼ� ÷���� ����4', '�ڼҼ� ÷���� ����', 4);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu04', '�ڼҼ� ÷���� ����5', '�ڼҼ� ÷���� ����', 5);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����6', '�ڼҼ� ÷���� ����', 6);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '�ڼҼ� ÷���� ����7', '�ڼҼ� ÷���� ����', 7);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '�ڼҼ� ÷���� ����8', '�ڼҼ� ÷���� ����', 8);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����9', '�ڼҼ� ÷���� ����', 9);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '�ڼҼ� ÷���� ����10', '�ڼҼ� ÷���� ����', 10);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����1', '�ڼҼ� ÷���� ����', 11);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '�ڼҼ� ÷���� ����2', '�ڼҼ� ÷���� ����', 12);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����3', '�ڼҼ� ÷���� ����', 13);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '�ڼҼ� ÷���� ����4', '�ڼҼ� ÷���� ����', 14);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu04', '�ڼҼ� ÷���� ����5', '�ڼҼ� ÷���� ����', 15);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����6', '�ڼҼ� ÷���� ����', 16);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '�ڼҼ� ÷���� ����7', '�ڼҼ� ÷���� ����', 17);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '�ڼҼ� ÷���� ����8', '�ڼҼ� ÷���� ����', 18);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '�ڼҼ� ÷���� ����9', '�ڼҼ� ÷���� ����', 19);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '�ڼҼ� ÷���� ����10', '�ڼҼ� ÷���� ����', 20);


insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '���������', '��������1', '��������1');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '���������', '��������2', '��������2');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '���������', '��������3', '��������3');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '���������', '��������4', '��������4');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '���������', '��������5', '��������5');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '���������', '��������6', '��������6');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '���������', '��������7', '��������7');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '���������', '��������8', '��������8');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '���������', '��������9', '��������9');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '���������', '��������10', '��������10');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '���������', '��������11', '��������11');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '���������', '��������12', '��������12');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '���������', '��������13', '��������13');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '���������', '��������14', '��������14');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '���������', '��������15', '��������15');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '���������', '��������16', '��������16');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '���������', '��������17', '��������17');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '���������', '��������18', '��������18');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '���������', '��������19', '��������19');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '���������', '��������20', '��������20');

insert into student_job values ('stu01', '������', 0);
insert into student_job values ('stu02', '���ȣ', 0);
insert into student_job values ('stu03', '�ȴٽ�', 0);
insert into student_job values ('stu04', '���ؽ�', 0);

