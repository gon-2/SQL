# char타입의 데이터를 입력
# char 고정큭 타입,255 바이트

insert into tb_type(t_char) values('Hello Char');
select * from tb_type;

#varchar 타입의 데이터를 입력
#varchar 가변길이 데이터, 653 byte

insert into tb_type(t_varchar) values('Hello varchar');
select * from tb_type;

#text

insert into tb_type(t_longtext) values('hello longtext');
select * from tb_type;

rollback;