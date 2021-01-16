# Buy_your_car
> 중고차 거래 매매 사이트입니다.

### 구현환경
- SQL developer, eclipse 
1. docker image: jaspeen/oracle-xe-11g. 
2. oracle 12c


## 1
- 회원 관련 기능
- 차량 관련 기능
- 거래 내역 관련 기능
- 관리자 기능 - 관리자 계정으로 접속하였을 때만 사용 가능
![customer](https://user-images.githubusercontent.com/44988609/104796781-a2d25300-57fc-11eb-995f-60dfa0376fd9.png)
![manager](https://user-images.githubusercontent.com/44988609/104796825-f5ac0a80-57fc-11eb-9f52-7fbcdb13c908.png)

</br>

## 2 Concurrency Control
여러 명의 사용자가 동시에 접속할 수 있고, 동시에 같은 차량에 대해서 구매 시도 가능합니다.(in ordering.jsp)

> Lock을 걸고, VEHICLE table에서 vnumber의 account id가 null인지 확인하여 구매된 차량인지 아닌 차량인지 확인


> VEHICLE table에서 그 차량의 account id를 현재 계정의 아이디로 update.
CARORDER table도 랜덤으로 생성된 주문번호, 구매하려는 차량 번호, 오늘 날짜, 현재 계정 아이디로 insert

> commit

을 하나의 과정으로 묶어서 atomic하게 수행합니다. 먼저 lock을 건 transaction이 완료될 때까지 유지되기 때문에 같은 데이터를 동시에 수정할 수 없게 합니다. 즉, Lock이 걸린 row에 대해서는 commit을 수행하기 전까지 다른 세션에서 update, insert를 수행할 수 없습니다.


</br>

## 3 차량 추천 서비스
차량 구매 이력이 없는 고객을 대상으로 가장 많이 구매된 모델 3가지 보여주며 인기모델을 추천해줍니다. 
![차량추천](https://user-images.githubusercontent.com/44988609/104796622-23904f80-57fb-11eb-999d-06b9b0c6aeb4.png)
 
