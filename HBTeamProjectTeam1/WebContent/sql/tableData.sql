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
	gender varchar(5) default '남',
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
	gender varchar(5) default '남',
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
	name varchar(50) default '한빛교육 행정팀',
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
	name varchar(50) default '강의공지맨',
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
	name varchar(50) default '취업지원팀',
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



insert into staff values(2, '행정팀');
insert into staff values(3, '강사팀');
insert into staff values(4, '영업팀');
insert into staff values(5, '취업지원팀');
insert into staff values(6, '대표이사');

insert into class values('class01', 'UI/UX를 기반으로 한 스마트 웹 앱콘텐츠 개발자 과정', '강사01', '2017-03-02', '2017-05-31', 4, 20, 65);
insert into class values('class02', '빅데이터 분석 및 응용SW엔지니어링 양성 과정', '강사02', '2017-07-01', '2017-10-31', 0, 20, 90);
insert into class values('class03', 'Interactive Web Design을 위한 Web Publisher 양성 과정', '강사03', '2017-07-01', '2017-10-31', 0, 20, 90);

insert into student values('stu01', '1234', '이윤미', '여', '서울시', 'stu01@hanbit.com', '1980-01-01', 1, '010-1234-1234', 'class01');
insert into student values('stu02', '1234', '김승호', '남', '서울시', 'stu02@hanbit.com', '1981-02-02', 1, '010-1234-1234', 'class01');
insert into student values('stu03', '1234', '안다슬', '여', '서울시', 'stu03@hanbit.com', '1982-03-03', 1, '010-1234-1234', 'class01');
insert into student values('stu04', '1234', '공해식', '남', '원주시', 'stu04@hanbit.com', '1983-04-04', 1, '010-1234-1234', 'class01');

insert into student values('stu05', '1234', '신청자01', '여', '서울시', 'stu05@hanbit.com', '1980-01-01', 0, '010-1234-1234', 'class02');
insert into student values('stu06', '1234', '신청자02', '남', '서울시', 'stu06@hanbit.com', '1981-02-02', 0, '010-1234-1234', 'class02');
insert into student values('stu07', '1234', '신청자03', '여', '서울시', 'stu07@hanbit.com', '1982-03-03', 0, '010-1234-1234', 'class03');
insert into student values('stu08', '1234', '신청자04', '남', '원주시', 'stu08@hanbit.com', '1983-04-04', 0, '010-1234-1234', 'class02');
insert into student values('stu09', '1234', '신청자05', '남', '원주시', 'stu09@hanbit.com', '1983-04-04', 0, '010-1234-1234', 'class03');

insert into employee values('emp01', '1234', '행정01', '여', '서울시', 'emp01@hanbit.com', '1980-02-01', '2015-03-02', '농협', '102-1214-123456', '010-1234-1234', 2);
insert into employee values('emp02', '1234', '강사01', '남', '서울시', 'emp02@hanbit.com', '1980-03-03', '2015-03-02', '농협', '103-1214-123456', '010-1234-1234', 3);
insert into employee values('emp03', '1234', '강사02', '여', '서울시', 'emp03@hanbit.com', '1981-03-03', '2015-03-02', '농협', '104-1214-123456', '010-1234-1234', 3);
insert into employee values('emp04', '1234', '강사03', '남', '서울시', 'emp04@hanbit.com', '1982-03-03', '2015-03-02', '농협', '105-1214-123456', '010-1234-1234', 3);
insert into employee values('emp05', '1234', '영업01', '남', '서울시', 'emp05@hanbit.com', '1982-03-03', '2015-03-02', '농협', '106-1214-123456', '010-1234-1234', 4);
insert into employee values('emp06', '1234', '취업01', '남', '서울시', 'emp06@hanbit.com', '1982-03-03', '2015-03-02', '농협', '107-1214-123456', '010-1234-1234', 5);
insert into employee values('emp00', '1234', '염기호', '남', '서울시', 'emp00@hanbit.com', '1982-03-03', '2015-03-02', '농협', '107-1214-123456', '010-1234-1234', 6);

insert into teacher values('emp02', '강사01', 3, 'class01');
insert into teacher values('emp03', '강사02', 3, 'class02');
insert into teacher values('emp04', '강사03', 3, 'class03');

insert into administration values('emp01', '행정01', 2);
insert into salse values('emp05', '영업01', 4);
insert into jobsupport values('emp06', '취업01', 5);
insert into ceo values('emp00', '대표이사', 6);

insert into subject values('class01-1', 'Java & Oracle', 'class01', 0);
insert into subject values('class01-2', 'JavaScript & JQuery', 'class01', 0);
insert into subject values('class01-3', 'Spring Framwork', 'class01', 0);

insert into subject values('class02-1', 'R프로그래밍', 'class02', 0);
insert into subject values('class02-2', '데이터마이닝 이론과 실습', 'class02', 0);
insert into subject values('class02-3', 'HTML & JavasScript 웹데이터 크롤링', 'class02', 0);

insert into subject values('class03-1', 'Java', 'class03', 0);
insert into subject values('class03-2', 'HTML5 & CSS', 'class03', 0);
insert into subject values('class03-3', 'JavaScript & JQuery', 'class03', 0);


insert into question values('class01-1-01', '문제1', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-1');
insert into question values('class01-1-02', '문제2', '보기1', '보기2', '보기3', '보기4', '보기5', 1, 'class01-1');
insert into question values('class01-1-03', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-04', '문제4', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-05', '문제5', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-06', '문제6', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-07', '문제7', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-08', '문제8', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-09', '문제9', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');
insert into question values('class01-1-10', '문제10', '보기1', '보기2', '보기3', '보기4', '보기5', 5, 'class01-1');

insert into question values('class01-2-01', '문제1', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-02', '문제2', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-03', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-04', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-05', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-06', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-07', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-08', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-09', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');
insert into question values('class01-2-10', '문제3', '보기1', '보기2', '보기3', '보기4', '보기5', 3, 'class01-2');

insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '대표이사', '한빛교육센터 - 홍대점 Open', '공지1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '한빛교육 행정팀', '공지2', '공지2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '한빛교육 행정팀', '공지3', '공지3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '대표이사', '공지4', '공지4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '한빛교육 행정팀', '공지5', '공지5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '한빛교육 행정팀', '공지6', '공지6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '한빛교육 행정팀', '공지7', '공지7');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '대표이사', '한빛교육센터 - 홍대점 Open', '공지1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '한빛교육 행정팀', '공지2', '공지2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '한빛교육 행정팀', '공지3', '공지3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '대표이사', '공지4', '공지4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '한빛교육 행정팀', '공지5', '공지5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '한빛교육 행정팀', '공지6', '공지6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '한빛교육 행정팀', '공지7', '공지7');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '대표이사', '한빛교육센터 - 홍대점 Open', '공지1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '한빛교육 행정팀', '공지2', '공지2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '한빛교육 행정팀', '공지3', '공지3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '대표이사', '공지4', '공지4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '한빛교육 행정팀', '공지5', '공지5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '한빛교육 행정팀', '공지6', '공지6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '한빛교육 행정팀', '공지7', '공지7');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '대표이사', '한빛교육센터 - 홍대점 Open', '공지1');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '한빛교육 행정팀', '공지2', '공지2');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '한빛교육 행정팀', '공지3', '공지3');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '대표이사', '공지4', '공지4');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '한빛교육 행정팀', '공지5', '공지5');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '한빛교육 행정팀', '공지6', '공지6');
insert into notice_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '한빛교육 행정팀', '공지7', '공지7');


insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-26', '09:00:00', '강의공지맨', '강의공지1', '강의공지1', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-27', '16:22:00', '강의공지맨', '강의공지2', '강의공지2', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-28', '09:46:00', '강의공지맨', '강의공지3', '강의공지3', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-29', '09:02:00', '강의공지맨', '강의공지4', '강의공지4', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-30', '09:11:00', '강의공지맨', '강의공지5', '강의공지5', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-02', '10:00:00', '강의공지맨', '강의공지6', '강의공지6', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-05', '09:30:00', '강의공지맨', '강의공지7', '강의공지7', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-26', '09:00:00', '강의공지맨', '강의공지8', '강의공지8', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-27', '16:22:00', '강의공지맨', '강의공지9', '강의공지9', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-28', '09:46:00', '강의공지맨', '강의공지10', '강의공지10', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-29', '09:02:00', '강의공지맨', '강의공지11', '강의공지11', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-30', '09:11:00', '강의공지맨', '강의공지12', '강의공지12', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-02', '10:00:00', '강의공지맨', '강의공지13', '강의공지13', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-05', '09:30:00', '강의공지맨', '강의공지14', '강의공지14', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-26', '09:00:00', '강의공지맨', '강의공지15', '강의공지15', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-27', '16:22:00', '강의공지맨', '강의공지16', '강의공지16', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-28', '09:46:00', '강의공지맨', '강의공지17', '강의공지17', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-29', '09:02:00', '강의공지맨', '강의공지18', '강의공지18', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-04-30', '09:11:00', '강의공지맨', '강의공지19', '강의공지19', 'class01');
insert into classnotice_bbs(curdate, curtime, name, title, memo, class_code) values ('2017-05-02', '10:00:00', '강의공지맨', '강의공지20', '강의공지20', 'class01');


insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-26', '09:00:00', 'stu01', '질문있어요1', '질문있어요', 1, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-27', '16:22:00', 'stu02', '질문있어요2', '질문있어요', 2, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-28', '09:46:00', 'stu01', '질문있어요3', '질문있어요', 3, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-29', '09:02:00', 'stu03', '질문있어요4', '질문있어요', 4, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-30', '09:11:00', 'stu04', '질문있어요5', '질문있어요', 5, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-02', '10:00:00', 'stu04', '질문있어요6', '질문있어요', 6, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-05', '09:30:00', 'stu02', '질문있어요7', '질문있어요', 7, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-26', '09:00:00', 'stu01', '질문있어요8', '질문있어요', 8, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-27', '16:22:00', 'stu02', '질문있어요9', '질문있어요', 9, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-28', '09:46:00', 'stu01', '질문있어요10', '질문있어요', 10, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-29', '09:02:00', 'stu03', '질문있어요11', '질문있어요', 11, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-30', '09:11:00', 'stu04', '질문있어요12', '질문있어요', 12, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-02', '10:00:00', 'stu04', '질문있어요13', '질문있어요', 13, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-05', '09:30:00', 'stu02', '질문있어요14', '질문있어요', 14, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-26', '09:00:00', 'stu01', '질문있어요15', '질문있어요', 15, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-27', '16:22:00', 'stu02', '질문있어요16', '질문있어요', 16, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-28', '09:46:00', 'stu01', '질문있어요17', '질문있어요', 17, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-29', '09:02:00', 'stu03', '질문있어요18', '질문있어요', 18, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-04-30', '09:11:00', 'stu04', '질문있어요19', '질문있어요', 19, 'class01');
insert into classqabbs(curdate, curtime, name, title, memo, grp, class_code) values ('2017-05-02', '10:00:00', 'stu04', '질문있어요20', '질문있어요', 20, 'class01');


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

insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ1', '자소서 첨삭좀 ㅈㅂ', 1);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '자소서 첨삭좀 ㅈㅂ2', '자소서 첨삭좀 ㅈㅂ', 2);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ3', '자소서 첨삭좀 ㅈㅂ', 3);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '자소서 첨삭좀 ㅈㅂ4', '자소서 첨삭좀 ㅈㅂ', 4);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu04', '자소서 첨삭좀 ㅈㅂ5', '자소서 첨삭좀 ㅈㅂ', 5);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ6', '자소서 첨삭좀 ㅈㅂ', 6);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '자소서 첨삭좀 ㅈㅂ7', '자소서 첨삭좀 ㅈㅂ', 7);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '자소서 첨삭좀 ㅈㅂ8', '자소서 첨삭좀 ㅈㅂ', 8);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ9', '자소서 첨삭좀 ㅈㅂ', 9);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '자소서 첨삭좀 ㅈㅂ10', '자소서 첨삭좀 ㅈㅂ', 10);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ1', '자소서 첨삭좀 ㅈㅂ', 11);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '자소서 첨삭좀 ㅈㅂ2', '자소서 첨삭좀 ㅈㅂ', 12);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ3', '자소서 첨삭좀 ㅈㅂ', 13);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '자소서 첨삭좀 ㅈㅂ4', '자소서 첨삭좀 ㅈㅂ', 14);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu04', '자소서 첨삭좀 ㅈㅂ5', '자소서 첨삭좀 ㅈㅂ', 15);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ6', '자소서 첨삭좀 ㅈㅂ', 16);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '자소서 첨삭좀 ㅈㅂ7', '자소서 첨삭좀 ㅈㅂ', 17);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu02', '자소서 첨삭좀 ㅈㅂ8', '자소서 첨삭좀 ㅈㅂ', 18);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu01', '자소서 첨삭좀 ㅈㅂ9', '자소서 첨삭좀 ㅈㅂ', 19);
insert into consultingbbs(curdate, curtime, name, title, memo, grp) values('2017-05-05', '09:30:00', 'stu03', '자소서 첨삭좀 ㅈㅂ10', '자소서 첨삭좀 ㅈㅂ', 20);


insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '취업지원팀', '구직정보1', '구직정보1');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '취업지원팀', '구직정보2', '구직정보2');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '취업지원팀', '구직정보3', '구직정보3');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '취업지원팀', '구직정보4', '구직정보4');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '취업지원팀', '구직정보5', '구직정보5');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '취업지원팀', '구직정보6', '구직정보6');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '취업지원팀', '구직정보7', '구직정보7');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '취업지원팀', '구직정보8', '구직정보8');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '취업지원팀', '구직정보9', '구직정보9');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '취업지원팀', '구직정보10', '구직정보10');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '취업지원팀', '구직정보11', '구직정보11');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-26', '09:00:00', '취업지원팀', '구직정보12', '구직정보12');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-27', '16:22:00', '취업지원팀', '구직정보13', '구직정보13');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '취업지원팀', '구직정보14', '구직정보14');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '취업지원팀', '구직정보15', '구직정보15');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-30', '09:11:00', '취업지원팀', '구직정보16', '구직정보16');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-02', '10:00:00', '취업지원팀', '구직정보17', '구직정보17');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-05-05', '09:30:00', '취업지원팀', '구직정보18', '구직정보18');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-28', '09:46:00', '취업지원팀', '구직정보19', '구직정보19');
insert into recruitInfo_bbs(curdate, curtime, name, title, memo) values ('2017-04-29', '09:02:00', '취업지원팀', '구직정보20', '구직정보20');

insert into student_job values ('stu01', '이윤미', 0);
insert into student_job values ('stu02', '김승호', 0);
insert into student_job values ('stu03', '안다슬', 0);
insert into student_job values ('stu04', '공해식', 0);

