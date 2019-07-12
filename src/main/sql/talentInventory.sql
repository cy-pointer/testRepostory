-- 数据库初始化脚本
-- 人才盘点相关表

-- 创建数据库
CREATE DATABASE IF NOT EXISTS vrrg;

-- 使用数据库
USE vrrg;

-- 关闭外键校验
set foreign_key_checks = 0;

-- 创建业绩指标库表
DROP TABLE IF EXISTS PD_INDEX_LIBRARY;
CREATE TABLE PD_INDEX_LIBRARY
(
    PIL_ID            INT(11)                NOT NULL AUTO_INCREMENT COMMENT 'ID',
    NAME              VARCHAR(255)           NOT NULL COMMENT '业绩指标名称',
    SQL_VAL           TEXT COMMENT '业绩指标取值SQL',
    START_ACTIVE_TIME DATETIME COMMENT '生效时间',
    END_ACTIVE_TIME   DATETIME COMMENT '失效时间',
    VERSION_NUM       INT(11)  DEFAULT 0 COMMENT '版本号',
    CREATION_DATE     DATETIME DEFAULT NOW() NOT NULL COMMENT '创建时间',
    CREATED_BY        INT(11)  DEFAULT -1    NOT NULL COMMENT '创建人',
    LAST_UPDATED_BY   INT(11)  DEFAULT -1    NOT NULL COMMENT '最后修改人',
    LAST_UPDATE_DATE  DATETIME DEFAULT NOW() NOT NULL COMMENT '最后修改时间',
    LAST_UPDATE_LOGIN INT(11) COMMENT '最后登录人',
    PRIMARY KEY (PIL_ID),
    UNIQUE IDX_NAME (NAME)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 11
    DEFAULT CHARSET = utf8
    COMMENT '业绩指标库表';
