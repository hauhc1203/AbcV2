FROM openjdk:11

ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY  E-Learning-Website-0.0.1-SNAPSHOT.jar doan.jar

RUN mkdir conf

COPY prod.env conf/prod.env

ENTRYPOINT ["java", "-jar","doan.jar"]