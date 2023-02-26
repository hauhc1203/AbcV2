use e_learning_web;
   create table role(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	name_role varchar(255)
 );
create table app_user(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	address varchar(255) ,
	avatar_url varchar(255) ,
	create_at datetime ,
	date_of_birth varchar(255) ,
	email varchar(255) ,
	full_name varchar(255) ,
	mail_confirm bit(1) ,
	password varchar(255) ,
	phone_number varchar(255) ,
	status int ,
	update_at datetime ,
	user_name varchar(255) ,
	role_id bigint,
	CONSTRAINT fk_1 FOREIGN KEY(role_id) REFERENCES role(id)
 );



create table course(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	create_at datetime ,
	enrolled int ,
	img_src longtext ,
	more_info longtext ,
	name varchar(255) ,
	num_lesson int ,
	num_rating int ,
	price double ,
	short_description longtext ,
	status int ,
	tag varchar(255) ,
	time_expired int ,
	update_at datetime
 );
 
create table bill(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	create_at datetime ,
	description varchar(255), 
	total_bill double ,
	course_id bigint ,
	user_id bigint,
    CONSTRAINT fk_2 FOREIGN KEY(course_id) REFERENCES course(id),
    CONSTRAINT fk_3 FOREIGN KEY(user_id) REFERENCES app_user(id)
 );

create table course_process(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	create_at datetime ,
	expire_date datetime ,
	list_lesson_done varchar(255) ,
	percent float ,
	status int ,
	update_at datetime ,
	course_id bigint ,
	user_id bigint,
	CONSTRAINT fk_4 FOREIGN KEY(course_id) REFERENCES course(id),
    CONSTRAINT fk_5 FOREIGN KEY(user_id) REFERENCES app_user(id)
 );
 
   create table lesson(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	content_lesson varchar(255) ,
	create_at datetime ,
	link_video longtext ,
	name varchar(255) ,
	update_at datetime ,
	course_id bigint,
    CONSTRAINT fk_6 FOREIGN KEY(course_id) REFERENCES course(id)
 );
 
create table exam(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	create_at datetime ,
	during bigint ,
	min_point float ,
	name varchar(255) ,
	total_question bigint ,
	type int ,
	update_at datetime ,
	course_id bigint ,
	lesson_id bigint,
	CONSTRAINT fk_7 FOREIGN KEY(course_id) REFERENCES course(id),
    CONSTRAINT fk_8 FOREIGN KEY(lesson_id) REFERENCES lesson(id)
 );
 
 create table exam_history(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	create_at datetime ,
	is_pass bit(1) ,
	total_score float ,
	total_time bigint ,
	exam_id bigint ,
	user_id bigint,
	CONSTRAINT fk_9 FOREIGN KEY(exam_id) REFERENCES exam(id),
    CONSTRAINT fk_10 FOREIGN KEY(user_id) REFERENCES app_user(id)
 );
 

 
  
  create table question(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	ans1 varchar(255) ,
	ans2 varchar(255) ,
	ans3 varchar(255) ,
	ans4 varchar(255) ,
	content_question varchar(255) ,
	correct_answer varchar(255) ,
	create_at datetime ,
	point float ,
	update_at datetime ,
	exam_id bigint,
    CONSTRAINT fk_11 FOREIGN KEY(exam_id) REFERENCES exam(id)
 );
 
   create table rate_course(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	content_cmt longtext ,
	date datetime ,
	score int ,
	app_user_id bigint ,
	course_id bigint ,
	create_at datetime ,
	update_at datetime,
    CONSTRAINT fk_12 FOREIGN KEY(app_user_id) REFERENCES app_user(id),
    CONSTRAINT fk_13 FOREIGN KEY(course_id) REFERENCES course(id)
 );
 
 
 
insert into role values (1,'ROLE_USER'),(2,'ROLE_ADMIN');

INSERT INTO `e_learning_web`.`app_user` (`address`, `email`, `full_name`, `mail_confirm`, `password`, `phone_number`, `status`, `user_name`, `role_id`) 
VALUES ('hd', 'hau.hc1203@gmail.com', 'Hoang Cong Hau', 1, 'aaaaaaaa', '3', '12', 'hauhc1203', 2);
INSERT INTO `e_learning_web`.`app_user` (`address`, `email`, `full_name`, `mail_confirm`, `password`, `phone_number`, `status`, `user_name`, `role_id`) 
VALUES ('hd', '98katana98@gmail.com', 'Hoang Cong Hau', 1, 'aaaaaaaa', '3', '12', '98katana98', 1);

 delimiter //
 DROP TRIGGER IF EXISTS after_insert_question //
 CREATE TRIGGER after_insert_question AFTER INSERT
 ON question
 FOR EACH ROW
 BEGIN
 	UPDATE exam
     SET total_question=total_question+ 1
    WHERE id=new.exam_id;
END//

 delimiter //
 DROP TRIGGER IF EXISTS after_delete_question //
 CREATE TRIGGER after_delete_question AFTER delete
 ON question
 FOR EACH ROW
 BEGIN
 	UPDATE exam
     SET total_question=total_question-1
    WHERE id=old.exam_id;
END//

  delimiter //
 DROP TRIGGER IF EXISTS after_insert_lesson //
 CREATE TRIGGER after_insert_lesson AFTER INSERT
 ON lesson
 FOR EACH ROW
 BEGIN
 	UPDATE course
     SET num_lesson=num_lesson+ 1
    WHERE id=new.course_id;
END//

 delimiter //
 DROP TRIGGER IF EXISTS after_delete_lesson //
 CREATE TRIGGER after_delete_lesson AFTER delete
 ON lesson
 FOR EACH ROW
 BEGIN
 	UPDATE course
     SET num_lesson=num_lesson- 1
    WHERE id=old.course_id;
END//