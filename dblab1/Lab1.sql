CREATE TABLE Roles
(
 role char(50) NOT NULL,
 CONSTRAINT PK_30 PRIMARY KEY ( role )
);

CREATE TABLE Permissions
(
 "permission" char(50) NOT NULL,
 CONSTRAINT PK_20 PRIMARY KEY ( "permission" )
);

CREATE TABLE ACL
(
 role       char(50) NOT NULL,
 "permission" char(50) NOT NULL,
 CONSTRAINT PK_209 PRIMARY KEY ( role, "permission" ),
 CONSTRAINT FK_206 FOREIGN KEY ( role ) REFERENCES Roles ( role ),
 CONSTRAINT FK_210 FOREIGN KEY ( "permission" ) REFERENCES Permissions ( "permission" )
);

CREATE TABLE Advertisement
(
 adId                  uuid NOT NULL,
 title                 text NOT NULL,
 company               text NOT NULL,
 type                  text NOT NULL,
 minimumWorkExperience numeric NULL,
 duration              text NULL,
 CONSTRAINT PK_77 PRIMARY KEY ( adId )
);

CREATE TABLE Categories
(
 categoryName char(50) NOT NULL,
 CONSTRAINT PK_86 PRIMARY KEY ( categoryName )
);

CREATE TABLE "Educational Background"
(
 edBackId     uuid NOT NULL,
 institue     text NOT NULL,
 enteringYear interval year NOT NULL,
 exitingYear  interval year NULL,
 field        text NOT NULL,
 CONSTRAINT PK_65 PRIMARY KEY ( edBackId )
);

CREATE TABLE "Work Experience"
(
 workExpId    uuid NOT NULL,
 company      char(50) NOT NULL,
 enteringYear interval year NOT NULL,
 exitingYear  interval year NULL,
 possition    text NOT NULL,
 CONSTRAINT PK_55 PRIMARY KEY ( workExpId )
);

CREATE TABLE "User"
(
 "Id"           uuid NOT NULL,
 Name         char(50) NOT NULL,
 edBackId     uuid NULL,
 role         char(50) NOT NULL,
 Email        json NOT NULL,
 Birthday     date NOT NULL,
 "Last Name"    char(50) NOT NULL,
 "Phone number" json NOT NULL,
 workExpId    uuid NULL,
 CONSTRAINT PK_31 PRIMARY KEY ( "Id" ),
 CONSTRAINT FK_15 FOREIGN KEY ( role ) REFERENCES Roles ( role ),
 CONSTRAINT FK_60 FOREIGN KEY ( workExpId ) REFERENCES "Work Experience" ( workExpId ),
 CONSTRAINT FK_70 FOREIGN KEY ( edBackId ) REFERENCES "Educational Background" ( edBackId )
);

CREATE TABLE Company
(
 Name            char(50) NOT NULL,
 establishedYear interval year NOT NULL,
 "​​expertiseArea" text NOT NULL,
 "Id"              uuid NOT NULL,
 CONSTRAINT PK_242 PRIMARY KEY ( "Id" ),
 CONSTRAINT FK_239 FOREIGN KEY ( "Id" ) REFERENCES "User" ( "Id" )
);


CREATE TABLE Marking
(
 "date"        date NOT NULL,
 description text NULL,
 "Id"          uuid NOT NULL,
 adId        uuid NOT NULL,
 CONSTRAINT PK_156 PRIMARY KEY ( "Id", adId ),
 CONSTRAINT FK_160 FOREIGN KEY ( "Id" ) REFERENCES "User" ( "Id" ),
 CONSTRAINT FK_235 FOREIGN KEY ( adId ) REFERENCES Advertisement ( adId )
);

CREATE TABLE Receipt
(
 receiptId uuid NOT NULL,
 amount    money NOT NULL,
 status    text NOT NULL,
 CONSTRAINT PK_102 PRIMARY KEY ( receiptId )
);

CREATE TABLE Request
(
 status      text NOT NULL,
 description text NULL,
 "date"        date NOT NULL,
 "Id"          uuid NOT NULL,
 adId        uuid NOT NULL,
 CONSTRAINT PK_146 PRIMARY KEY ( "Id", adId ),
 CONSTRAINT FK_143 FOREIGN KEY ( "Id" ) REFERENCES "User" ( "Id" ),
 CONSTRAINT FK_147 FOREIGN KEY ( adId ) REFERENCES Advertisement ( adId )
);

CREATE TABLE ReviewRequests
(
 "Id"           uuid NOT NULL,
 categoryName char(50) NOT NULL,
 CONSTRAINT PK_176 PRIMARY KEY ( "Id", categoryName ),
 CONSTRAINT FK_173 FOREIGN KEY ( "Id" ) REFERENCES "User" ( "Id" ),
 CONSTRAINT FK_213 FOREIGN KEY ( categoryName ) REFERENCES Categories ( categoryName )
);

CREATE TABLE Visitor
(
 visitorId      uuid NOT NULL,
 "Id"             uuid NULL,
 status         text NULL,
 membershipDate date NULL,
 CONSTRAINT PK_47 PRIMARY KEY ( visitorId ),
 CONSTRAINT FK_135 FOREIGN KEY ( "Id" ) REFERENCES "User" ( "Id" )
);

CREATE TABLE "Search/Click"
(
 visitorId uuid NOT NULL,
 adId      uuid NOT NULL,
 "time"      time NOT NULL,
 filters   json NOT NULL,
 CONSTRAINT PK_169 PRIMARY KEY ( visitorId, adId, "time" ),
 CONSTRAINT FK_166 FOREIGN KEY ( visitorId ) REFERENCES Visitor ( visitorId ),
 CONSTRAINT FK_170 FOREIGN KEY ( adId ) REFERENCES Advertisement ( adId )
);

CREATE TABLE SubmitAd
(
 categoryName char(50) NOT NULL,
 receiptId    uuid NOT NULL,
 "Id"           uuid NOT NULL,
 adId         uuid NOT NULL,
 CONSTRAINT PK_202 PRIMARY KEY ( adId ),
 CONSTRAINT FK_105 FOREIGN KEY ( receiptId ) REFERENCES Receipt ( receiptId ),
 CONSTRAINT FK_127 FOREIGN KEY ( categoryName ) REFERENCES Categories ( categoryName ),
 CONSTRAINT FK_203 FOREIGN KEY ( adId ) REFERENCES Advertisement ( adId ),
 CONSTRAINT FK_232 FOREIGN KEY ( "Id" ) REFERENCES "User" ( "Id" )
);

CREATE INDEX fkIdx_208 ON ACL
(
 role
);

CREATE INDEX fkIdx_212 ON ACL
(
 "permission"
);

CREATE INDEX fkIdx_241 ON Company
(
 "Id"
);

CREATE INDEX fkIdx_162 ON Marking
(
 "Id"
);

CREATE INDEX fkIdx_237 ON Marking
(
 adId
);

CREATE INDEX fkIdx_145 ON Request
(
 "Id"
);

CREATE INDEX fkIdx_149 ON Request
(
 adId
);

CREATE INDEX fkIdx_175 ON ReviewRequests
(
 "Id"
);

CREATE INDEX fkIdx_215 ON ReviewRequests
(
 categoryName
);


CREATE INDEX fkIdx_168 ON "Search/Click"
(
 visitorId
);

CREATE INDEX fkIdx_172 ON "Search/Click"
(
 adId
);

CREATE INDEX fkIdx_107 ON SubmitAd
(
 receiptId
);

CREATE INDEX fkIdx_129 ON SubmitAd
(
 categoryName
);

CREATE INDEX fkIdx_205 ON SubmitAd
(
 adId
);

CREATE INDEX fkIdx_234 ON SubmitAd
(
 "Id"
);

CREATE INDEX fkIdx_17 ON "User"
(
 role
);

CREATE INDEX fkIdx_62 ON "User"
(
 workExpId
);

CREATE INDEX fkIdx_72 ON "User"
(
 edBackId
);

CREATE INDEX fkIdx_137 ON Visitor
(
 "Id"
);

