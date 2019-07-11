-- 数据库初始化脚本

-- 创建数据库
CREATE DATABASE IF NOT EXISTS vrrg;

-- 使用数据库
USE vrrg;

-- 关闭外键校验
SET FOREIGN_KEY_CHECKS = 0;

-- 创建选择题表
DROP TABLE IF EXISTS KS_CHOICE_QUESTION;
CREATE TABLE KS_CHOICE_QUESTION
(
    CQ_ID             INT(11)                NOT NULL AUTO_INCREMENT COMMENT 'ID',
    ANSWER            VARCHAR(20)            NOT NULL COMMENT '正确答案',
    CONTENT           VARCHAR(400)           NOT NULL COMMENT '题目',
    CONTRIBUTOR       INT(11) COMMENT '题目提供者',
    DESCRIPTION       VARCHAR(400) COMMENT '题目解析',
    CHOICE_A          VARCHAR(255) COMMENT '选项A',
    CHOICE_B          VARCHAR(255) COMMENT '选项B',
    CHOICE_C          VARCHAR(255) COMMENT '选项C',
    CHOICE_D          VARCHAR(255) COMMENT '选项D',
    CHOICE_E          VARCHAR(255) COMMENT '选项E',
    CHOICE_F          VARCHAR(255) COMMENT '选项F',
    CHOICE_G          VARCHAR(255) COMMENT '选项G',
    CHOICE_H          VARCHAR(255) COMMENT '选项H',
    KNOWLEDGE_POINT   VARCHAR(255) COMMENT '知识点',
    TYPE              VARCHAR(255) COMMENT '类型(单选RADIO，多选MULTI_SELECT)',
    SOURCE            VARCHAR(255) COMMENT '来源(导入IMPORT，手工录入MANUALLY）',
    TOPIC_TYPE        VARCHAR(255) COMMENT '题目类型(快码TOPIC_TYPE)',
    TOPIC_LABEL       VARCHAR(255) COMMENT '题目标签(快码TOPIC_LABEL)',
    START_ACTIVE_TIME DATETIME COMMENT '有效时间',
    END_ACTIVE_TIME   DATETIME COMMENT '失效时间',
    VERSION_NUM       INT(11)  DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)  DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)  DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (CQ_ID)
)
    ENGINE = INNODB
    AUTO_INCREMENT = 11
    DEFAULT CHARSET = UTF8
    COMMENT '选择题表';

-- 创建判断题表
DROP TABLE IF EXISTS KS_JUDGE_QUESTION;
CREATE TABLE KS_JUDGE_QUESTION
(
    JQ_ID             INT(11)                NOT NULL AUTO_INCREMENT COMMENT 'ID',
    ANSWER            VARCHAR(20)            NOT NULL COMMENT '正确答案',
    CONTENT           VARCHAR(20)            NOT NULL COMMENT '题目',
    CONTRIBUTOR       INT(11) COMMENT '题目提供者',
    DESCRIPTION       VARCHAR(400) COMMENT '题目解析',
    KNOWLEDGE_POINT   VARCHAR(255) COMMENT '知识点',
    SOURCE            VARCHAR(255) COMMENT '来源(导入IMPORT，手工录入MANUALLY）',
    TOPIC_TYPE        VARCHAR(255) COMMENT '题目类型(快码TOPIC_TYPE)',
    TOPIC_LABEL       VARCHAR(255) COMMENT '题目标签(快码TOPIC_LABEL)',
    START_ACTIVE_TIME DATETIME COMMENT '有效时间',
    END_ACTIVE_TIME   DATETIME COMMENT '失效时间',
    VERSION_NUM       INT(11)  DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)  DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)  DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (JQ_ID)
)
    ENGINE = INNODB
    AUTO_INCREMENT = 21
    DEFAULT CHARSET = UTF8
    COMMENT '判断题表';

-- 创建主观题表
DROP TABLE IF EXISTS KS_SUBJECTIVE_QUESTION;
CREATE TABLE KS_SUBJECTIVE_QUESTION
(
    SQ_ID             INT(11)                NOT NULL AUTO_INCREMENT COMMENT 'ID',
    ANSWER            TEXT COMMENT '参考答案',
    CONTENT           VARCHAR(400) COMMENT '题目内容',
    CONTRIBUTOR       INT(11) COMMENT '题目提供者',
    DESCRIPTION       VARCHAR(750) COMMENT '题目解析',
    KNOWLEDGE_POINT   VARCHAR(255) COMMENT '知识点',
    SOURCE            VARCHAR(255) COMMENT '来源(导入IMPORT,手工录入MANUALLY)',
    TOPIC_TYPE        VARCHAR(255) COMMENT '题目类型(快码TOPIC_TYPE)',
    TOPIC_LABEL       VARCHAR(255) COMMENT '题目标签(快码TOPIC_LABEL)',
    START_ACTIVE_TIME DATETIME COMMENT '有效时间',
    END_ACTIVE_TIME   DATETIME COMMENT '失效时间',
    VERSION_NUM       INT(11)  DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)  DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)  DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (SQ_ID)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 31
    DEFAULT CHARSET = utf8
    COMMENT '主观题及答案表';

-- 创建题目知识库关联表
DROP TABLE IF EXISTS KS_KNOWLEDGE;
CREATE TABLE KS_KNOWLEDGE
(
    TSK_ID                 INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    CHOICE_QUESTION_ID     INT(11) COMMENT '选择题ID',
    JUDGE_QUESTION_ID      INT(11) COMMENT '判断题ID',
    SUBJECTIVE_QUESTION_ID INT(11) COMMENT '主观题ID',
    NAME                   VARCHAR(255) COMMENT '知识库名称',
    URL                    VARCHAR(255) COMMENT '知识库地址',
    TYPE                   VARCHAR(255) COMMENT '快码(KNOWLEDGE_TYPE),内部和外部对应的URL地址不一样',
    PRIMARY KEY (TSK_ID),
    KEY IDX_CHOICE_QUESTION_ID (CHOICE_QUESTION_ID),
    KEY IDX_JUDGE_QUESTION_ID (JUDGE_QUESTION_ID),
    KEY IDX_SUBJECTIVE_QUESTION_ID (SUBJECTIVE_QUESTION_ID)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 12
    DEFAULT CHARSET = utf8
    COMMENT '题目知识库关联表';

-- 创建试卷头表
DROP TABLE IF EXISTS KS_EXAM;
CREATE TABLE KS_EXAM
(
    E_ID              INT(11)                NOT NULL AUTO_INCREMENT COMMENT 'ID',
    NAME              VARCHAR(200)           NOT NULL COMMENT '试卷名',
    DETAIL            VARCHAR(400) COMMENT '试卷描述',
    TYPE              VARCHAR(255)           NOT NULL COMMENT '组卷类型(随机RANDOM,手动MANUAL)',
    STATUS            VARCHAR(2) COMMENT '发布状态(快码:TASK_IS,已发布:Y,未发布:N)',
    VERSION_NUM       INT(11)  DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)  DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)  DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (E_ID)
)
    ENGINE = INNODB
    AUTO_INCREMENT = 31
    DEFAULT CHARSET = UTF8
    COMMENT '试卷头表';

-- 创建试卷明细表
DROP TABLE IF EXISTS KS_EXAM_DETAIL;
CREATE TABLE KS_EXAM_DETAIL
(
    ED_ID                  INT(11)                   NOT NULL AUTO_INCREMENT COMMENT 'ID',
    QUESTION_TYPE          VARCHAR(255) COMMENT '问题类型(单选RADIO，多选MULTI_SELECT,判断JUDGE,主观SUBJECTIVE)',
    CHOICE_QUESTION_ID     INT(11) COMMENT '选择题ID',
    JUDGE_QUESTION_ID      INT(11) COMMENT '判断题ID',
    SUBJECTIVE_QUESTION_ID INT(11) COMMENT '主观题ID',
    EXAM_ID                INT(11)                   NOT NULL COMMENT '头表ID',
    SCORE                  FLOAT(6, 2) DEFAULT 0.00 COMMENT '分数',
    VERSION_NUM            INT(11)     DEFAULT 0 COMMENT '版本号',
    CREATION_DATE          DATETIME    DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY             INT(11)     DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY        INT(11)     DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE       DATETIME    DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN      INT(11) COMMENT '最后登录人',
    PRIMARY KEY (ED_ID),
    FOREIGN KEY (CHOICE_QUESTION_ID) REFERENCES KS_CHOICE_QUESTION (CQ_ID),
    FOREIGN KEY (JUDGE_QUESTION_ID) REFERENCES KS_JUDGE_QUESTION (JQ_ID),
    FOREIGN KEY (SUBJECTIVE_QUESTION_ID) REFERENCES KS_SUBJECTIVE_QUESTION (SQ_ID),
    FOREIGN KEY (EXAM_ID) REFERENCES KS_EXAM (E_ID),
    KEY IDX_CHOICE_QUESTION_ID (CHOICE_QUESTION_ID),
    KEY IDX_JUDGE_QUESTION_ID (JUDGE_QUESTION_ID),
    KEY IDX_SUBJECTIVE_QUESTION_ID (SUBJECTIVE_QUESTION_ID),
    KEY IDX_EXAM_ID (EXAM_ID)
)
    ENGINE = INNODB
    AUTO_INCREMENT = 41
    DEFAULT CHARSET = UTF8
    COMMENT '试卷明细表';

-- 创建人员试卷关联表
DROP TABLE IF EXISTS KS_USER_EXAM;
CREATE TABLE KS_USER_EXAM
(
    UE_ID             INT(11)                   NOT NULL AUTO_INCREMENT COMMENT 'ID',
    USER_ID           INT(11)                   NOT NULL COMMENT '用户ID',
    EXAMINERS         INT(11) COMMENT '阅卷人ID,只针对主观题',
    EXAM_ID           INT(11)                   NOT NULL COMMENT '试卷头表ID',
    SCORE             FLOAT(6, 2) DEFAULT 0.00 COMMENT '总得分',
    STATUS            VARCHAR(255) COMMENT '状态(未考试NEW,考试中HASING,已考试HAS)',
    TYPE              VARCHAR(255) COMMENT '考试类型(快码:KS_TYPE,正式考试:FORMAL,模拟考试:SIMULATION)',
    VERSION_NUM       INT(11)     DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME    DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)     DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)     DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME    DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (UE_ID),
    FOREIGN KEY (EXAM_ID) REFERENCES KS_EXAM (E_ID),
    KEY IDX_USER_ID (USER_ID),
    KEY IDX_EXAM_ID (EXAM_ID)
)
    ENGINE = INNODB
    AUTO_INCREMENT = 51
    DEFAULT CHARSET = UTF8
    COMMENT '人员试卷关联表';

-- 创建人员答题表
DROP TABLE IF EXISTS KS_USER_ANSWER;
CREATE TABLE KS_USER_ANSWER
(
    UA_ID             INT(11)                NOT NULL AUTO_INCREMENT COMMENT 'ID',
    USER_EXAM_ID      INT(11)                NOT NULL COMMENT '人员试卷关联ID',
    USER_ID           INT(11)                NOT NULL COMMENT '用户ID',
    EXAM_DETAIL_ID    INT(11)                NOT NULL COMMENT '试卷明细ID',
    ANSWER            VARCHAR(20) COMMENT '答案',
    Y_OR_N            VARCHAR(2) COMMENT '答案是否正确"Y","N"',
    SUBJECTIVE_ANSWER TEXT COMMENT '主观题答案',
    SUBJECTIVE_SCORE  FLOAT(6, 2) COMMENT '主观题得分',
    VERSION_NUM       INT(11)  DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)  DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)  DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (UA_ID),
    FOREIGN KEY (USER_EXAM_ID) REFERENCES KS_USER_EXAM (UE_ID),
    FOREIGN KEY (EXAM_DETAIL_ID) REFERENCES KS_EXAM_DETAIL (ED_ID),
    KEY IDX_USER_ID (USER_ID),
    KEY IDX_USER_EXAM_ID (USER_EXAM_ID),
    KEY IDX_EXAM_DETAIL_ID (EXAM_DETAIL_ID)
)
    ENGINE = INNODB
    AUTO_INCREMENT = 61
    DEFAULT CHARSET = UTF8
    COMMENT '人员答题表';
