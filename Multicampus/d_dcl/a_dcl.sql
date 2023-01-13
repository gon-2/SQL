# root 사용자로 진행
# DCL (Data Control language)

# 권한관리
#  *** 관리자 계정 : 데이터베이스 관리를 담당하는 슈퍼 사용자
#				 데이터베이스의 모든 권한과 책임을 가지고 있다. (root)

#  *** 사용자 계정 : 데이터베이스에서 본인이 맡은 작업을 수행하는 계정
#				 사용자 계정은 업무에 필요한 최소한의 권한만 부여

# 1. 계정생성
# BM
create user bm identified by '123qwe!@#QWE';
show grants for bm;

create user bm2 identified by '123qwe!@#QWE';

# 2. 권한부여
# .grant 권한 [,권한...] on db이름.테이블명 to 사용자 [with grant option]
# with grant option : 부여받은 권한을 다른 사용자에게 부여할 권한을 주는 옵션

grant select, insert on mc_sql.* to 'bm' with grant option;

# 3. 권한 회수
# revoke 권한 from 사용자
revoke select, insert on mc_sql.* from bm;
revoke select, insert on mc_sql.employee from bm;

revoke 'web_dev' from bm;

grant 'web_dev' to 'bm';
set default role 'web_dev' to 'bm';
show grants for 'bm';