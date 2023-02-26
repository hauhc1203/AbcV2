-- create database e_learning_web;
use e_learning_web;
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