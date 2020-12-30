PROMPT SCRIPT: WORKBOOK DATA CREATE
SET FEEDBACK OFF
SET DEFINE OFF
PROMPT Initializing....
DROP TABLE TB_DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE TB_STUDENT CASCADE CONSTRAINTS;
DROP TABLE TB_CLASS CASCADE CONSTRAINTS;
DROP TABLE TB_CLASS_PROFESSOR CASCADE CONSTRAINTS;
DROP TABLE TB_PROFESSOR CASCADE CONSTRAINTS;
DROP TABLE TB_GRADE CASCADE CONSTRAINTS;

--학과 테이블 작성
PROMPT CREATING TB_DEPARTMENT...
create table tb_department(
department_no 	varchar2(10) not null,
department_name 	varchar2(20) not null,
category		varchar2(20),
open_yn		char(1),
capacity		number,
constraint 	pk_department	primary key(department_no)
);
COMMENT ON COLUMN TB_DEPARTMENT.DEPARTMENT_NO IS '학과 번호';
COMMENT ON COLUMN TB_DEPARTMENT.DEPARTMENT_NAME IS '학과 이름';
COMMENT ON COLUMN TB_DEPARTMENT.CATEGORY IS '계열';
COMMENT ON COLUMN TB_DEPARTMENT.OPEN_YN IS '개설 여부';
COMMENT ON COLUMN TB_DEPARTMENT.CAPACITY IS '정원';

--교수 테이블 작성
PROMPT CREATING TB_PROFESSOR...
create table tb_professor(
professor_no 	varchar2(10) not null,
professor_name 	varchar2(30) not null,
professor_ssn 	varchar2(14),
professor_address 	varchar2(100),
department_no	varchar2(10),
constraint pk_professor 	primary key(professor_no),
constraint fk_professor 	foreign key(department_no)
references tb_department(department_no)
);
COMMENT ON COLUMN TB_PROFESSOR.PROFESSOR_NO IS '교수 번호';
COMMENT ON COLUMN TB_PROFESSOR.PROFESSOR_NAME IS '교수 이름';
COMMENT ON COLUMN TB_PROFESSOR.PROFESSOR_SSN IS '교수 주민번호';
COMMENT ON COLUMN TB_PROFESSOR.PROFESSOR_ADDRESS IS '교수 주소';
COMMENT ON COLUMN TB_PROFESSOR.DEPARTMENT_NO IS '학과 번호';

--학생 테이블 작성 TB_STUDENT
PROMPT CREATING TB_STUDENT...
create table tb_student(
student_no   	varchar2(10) not null,
department_no 	varchar2(10) not null,
student_name 	varchar2(30) not null,
student_ssn 	varchar2(14),
student_address 	varchar2(100),
entrance_date 	date,
absence_yn 	char(1),
coach_professor_no varchar2(10),
constraint pk_student 	primary key(student_no),
constraint fk_student0 	foreign key(department_no)
references tb_department(department_no),
constraint fk_student1 	foreign key(coach_professor_no)
references tb_professor(professor_no)
);
--과목 테이블 작성
PROMPT CREATING TB_CLASS...
create table tb_class(
class_no 			varchar2(10) not null,
department_no 		varchar2(10) not null,
preattending_class_no 	varchar2(10),
class_name 		varchar2(30) not null,
class_type 		varchar2(10),
constraint pk_class 	primary key(class_no),
constraint fk_class0 	foreign key(department_no)
references tb_department(department_no),
constraint fk_class1 	foreign key(preattending_class_no)
references tb_department(department_no)
);

--alter table tb_class
-- add constraint fk_class1 foreign key(preattending_class_no)
-- references tb_department(department_no);

--과목 교수 테이블 작성
PROMPT CREATING TB_CLASS_PROFESSOR...
create table tb_class_professor(
class_no 		varchar2(10) not null,
professor_no 	varchar2(10) not null,
constraint pk_class_professor 	primary key(class_no, professor_no),
constraint fk_class_professor0 	foreign key(class_no)
references tb_class(class_no),
constraint fk_class_professor1 	foreign key(professor_no)
references tb_professor(professor_no)
);
--성적 테이블 작성
PROMPT CREATING TB_GRADE...
create table tb_grade(
term_no 		varchar2(10) not null,
class_no 		varchar2(10) not null,
student_no 	varchar2(10) not null,
point number(3,2),
constraint pk_grade 	primary key(term_no, class_no, student_no),
constraint fk_grade0 	foreign key(class_no)
references tb_class(class_no),
constraint fk_grade1 	foreign key(student_no)
references tb_student(student_no)
);
--성적 테이블에 기본키를 한번에 3개 입력
alter table tb_grade
add primary key(term_no, class_no, student_no);
