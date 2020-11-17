
-- select * from keywords
if not exists (select name from sys.tables where name = 'keywords')
begin
    create table keywords (kw nvarchar(100));
    create clustered index PKI_Keywords on keywords (kw asc) ;
end
go

truncate table keywords ;

Insert into keywords (kw) values ('ABSOLUTE');
GO
Insert into keywords (kw) values ('HOST');
GO
Insert into keywords (kw) values ('RELATIVE');
GO
Insert into keywords (kw) values ('ACTION');
GO
Insert into keywords (kw) values ('HOUR');
GO
Insert into keywords (kw) values ('RELEASE');
GO
Insert into keywords (kw) values ('ADMIN');
GO
Insert into keywords (kw) values ('IGNORE');
GO
Insert into keywords (kw) values ('RESULT');
GO
Insert into keywords (kw) values ('AFTER');
GO
Insert into keywords (kw) values ('IMMEDIATE');
GO
Insert into keywords (kw) values ('RETURNS');
GO
Insert into keywords (kw) values ('AGGREGATE');
GO
Insert into keywords (kw) values ('INDICATOR');
GO
Insert into keywords (kw) values ('ROLE');
GO
Insert into keywords (kw) values ('ALIAS');
GO
Insert into keywords (kw) values ('INITIALIZE');
GO
Insert into keywords (kw) values ('ROLLUP');
GO
Insert into keywords (kw) values ('ALLOCATE');
GO
Insert into keywords (kw) values ('INITIALLY');
GO
Insert into keywords (kw) values ('ROUTINE');
GO
Insert into keywords (kw) values ('ARE');
GO
Insert into keywords (kw) values ('INOUT');
GO
Insert into keywords (kw) values ('ROW');
GO
Insert into keywords (kw) values ('ARRAY');
GO
Insert into keywords (kw) values ('INPUT');
GO
Insert into keywords (kw) values ('ROWS');
GO
Insert into keywords (kw) values ('ASENSITIVE');
GO
Insert into keywords (kw) values ('INT');
GO
Insert into keywords (kw) values ('SAVEPOINT');
GO
Insert into keywords (kw) values ('ASSERTION');
GO
Insert into keywords (kw) values ('INTEGER');
GO
Insert into keywords (kw) values ('SCROLL');
GO
Insert into keywords (kw) values ('ASYMMETRIC');
GO
Insert into keywords (kw) values ('INTERSECTION');
GO
Insert into keywords (kw) values ('SCOPE');
GO
Insert into keywords (kw) values ('AT');
GO
Insert into keywords (kw) values ('INTERVAL');
GO
Insert into keywords (kw) values ('SEARCH');
GO
Insert into keywords (kw) values ('ATOMIC');
GO
Insert into keywords (kw) values ('ISOLATION');
GO
Insert into keywords (kw) values ('SECOND');
GO
Insert into keywords (kw) values ('BEFORE');
GO
Insert into keywords (kw) values ('ITERATE');
GO
Insert into keywords (kw) values ('SECTION');
GO
Insert into keywords (kw) values ('BINARY');
GO
Insert into keywords (kw) values ('LANGUAGE');
GO
Insert into keywords (kw) values ('SENSITIVE');
GO
Insert into keywords (kw) values ('BIT');
GO
Insert into keywords (kw) values ('LARGE');
GO
Insert into keywords (kw) values ('SEQUENCE');
GO
Insert into keywords (kw) values ('BLOB');
GO
Insert into keywords (kw) values ('LAST');
GO
Insert into keywords (kw) values ('SESSION');
GO
Insert into keywords (kw) values ('BOOLEAN');
GO
Insert into keywords (kw) values ('LATERAL');
GO
Insert into keywords (kw) values ('SETS');
GO
Insert into keywords (kw) values ('BOTH');
GO
Insert into keywords (kw) values ('LEADING');
GO
Insert into keywords (kw) values ('SIMILAR');
GO
Insert into keywords (kw) values ('BREADTH');
GO
Insert into keywords (kw) values ('LESS');
GO
Insert into keywords (kw) values ('SIZE');
GO
Insert into keywords (kw) values ('CALL');
GO
Insert into keywords (kw) values ('LEVEL');
GO
Insert into keywords (kw) values ('SMALLINT');
GO
Insert into keywords (kw) values ('CALLED');
GO
Insert into keywords (kw) values ('LIKE_REGEX');
GO
Insert into keywords (kw) values ('SPACE');
GO
Insert into keywords (kw) values ('CARDINALITY');
GO
Insert into keywords (kw) values ('LIMIT');
GO
Insert into keywords (kw) values ('SPECIFIC');
GO
Insert into keywords (kw) values ('CASCADED');
GO
Insert into keywords (kw) values ('LN');
GO
Insert into keywords (kw) values ('SPECIFICTYPE');
GO
Insert into keywords (kw) values ('CAST');
GO
Insert into keywords (kw) values ('LOCAL');
GO
Insert into keywords (kw) values ('SQL');
GO
Insert into keywords (kw) values ('CATALOG');
GO
Insert into keywords (kw) values ('LOCALTIME');
GO
Insert into keywords (kw) values ('SQLEXCEPTION');
GO
Insert into keywords (kw) values ('CHAR');
GO
Insert into keywords (kw) values ('LOCALTIMESTAMP');
GO
Insert into keywords (kw) values ('SQLSTATE');
GO
Insert into keywords (kw) values ('CHARACTER');
GO
Insert into keywords (kw) values ('LOCATOR');
GO
Insert into keywords (kw) values ('SQLWARNING');
GO
Insert into keywords (kw) values ('CLASS');
GO
Insert into keywords (kw) values ('MAP');
GO
Insert into keywords (kw) values ('START');
GO
Insert into keywords (kw) values ('CLOB');
GO
Insert into keywords (kw) values ('MATCH');
GO
Insert into keywords (kw) values ('STATE');
GO
Insert into keywords (kw) values ('COLLATION');
GO
Insert into keywords (kw) values ('MEMBER');
GO
Insert into keywords (kw) values ('STATEMENT');
GO
Insert into keywords (kw) values ('COLLECT');
GO
Insert into keywords (kw) values ('METHOD');
GO
Insert into keywords (kw) values ('STATIC');
GO
Insert into keywords (kw) values ('COMPLETION');
GO
Insert into keywords (kw) values ('MINUTE');
GO
Insert into keywords (kw) values ('STDDEV_POP');
GO
Insert into keywords (kw) values ('CONDITION');
GO
Insert into keywords (kw) values ('MOD');
GO
Insert into keywords (kw) values ('STDDEV_SAMP');
GO
Insert into keywords (kw) values ('CONNECT');
GO
Insert into keywords (kw) values ('MODIFIES');
GO
Insert into keywords (kw) values ('STRUCTURE');
GO
Insert into keywords (kw) values ('CONNECTION');
GO
Insert into keywords (kw) values ('MODIFY');
GO
Insert into keywords (kw) values ('SUBMULTISET');
GO
Insert into keywords (kw) values ('CONSTRAINTS');
GO
Insert into keywords (kw) values ('MODULE');
GO
Insert into keywords (kw) values ('SUBSTRING_REGEX');
GO
Insert into keywords (kw) values ('CONSTRUCTOR');
GO
Insert into keywords (kw) values ('MONTH');
GO
Insert into keywords (kw) values ('SYMMETRIC');
GO
Insert into keywords (kw) values ('CORR');
GO
Insert into keywords (kw) values ('MULTISET');
GO
Insert into keywords (kw) values ('SYSTEM');
GO
Insert into keywords (kw) values ('CORRESPONDING');
GO
Insert into keywords (kw) values ('NAMES');
GO
Insert into keywords (kw) values ('TEMPORARY');
GO
Insert into keywords (kw) values ('COVAR_POP');
GO
Insert into keywords (kw) values ('NATURAL');
GO
Insert into keywords (kw) values ('TERMINATE');
GO
Insert into keywords (kw) values ('COVAR_SAMP');
GO
Insert into keywords (kw) values ('NCHAR');
GO
Insert into keywords (kw) values ('THAN');
GO
Insert into keywords (kw) values ('CUBE');
GO
Insert into keywords (kw) values ('NCLOB');
GO
Insert into keywords (kw) values ('TIME');
GO
Insert into keywords (kw) values ('CUME_DIST');
GO
Insert into keywords (kw) values ('NEW');
GO
Insert into keywords (kw) values ('TIMESTAMP');
GO
Insert into keywords (kw) values ('CURRENT_CATALOG');
GO
Insert into keywords (kw) values ('NEXT');
GO
Insert into keywords (kw) values ('TIMEZONE_HOUR');
GO
Insert into keywords (kw) values ('CURRENT_DEFAULT_TRANSFORM_GROUP');
GO
Insert into keywords (kw) values ('NO');
GO
Insert into keywords (kw) values ('TIMEZONE_MINUTE');
GO
Insert into keywords (kw) values ('CURRENT_PATH');
GO
Insert into keywords (kw) values ('NONE');
GO
Insert into keywords (kw) values ('TRAILING');
GO
Insert into keywords (kw) values ('CURRENT_ROLE');
GO
Insert into keywords (kw) values ('NORMALIZE');
GO
Insert into keywords (kw) values ('TRANSLATE_REGEX');
GO
Insert into keywords (kw) values ('CURRENT_SCHEMA');
GO
Insert into keywords (kw) values ('NUMERIC');
GO
Insert into keywords (kw) values ('TRANSLATION');
GO
Insert into keywords (kw) values ('CURRENT_TRANSFORM_GROUP_FOR_TYPE');
GO
Insert into keywords (kw) values ('OBJECT');
GO
Insert into keywords (kw) values ('TREAT');
GO
Insert into keywords (kw) values ('CYCLE');
GO
Insert into keywords (kw) values ('OCCURRENCES_REGEX');
GO
Insert into keywords (kw) values ('TRUE');
GO
Insert into keywords (kw) values ('DATA');
GO
Insert into keywords (kw) values ('OLD');
GO
Insert into keywords (kw) values ('UESCAPE');
GO
Insert into keywords (kw) values ('DATE');
GO
Insert into keywords (kw) values ('ONLY');
GO
Insert into keywords (kw) values ('UNDER');
GO
Insert into keywords (kw) values ('DAY');
GO
Insert into keywords (kw) values ('OPERATION');
GO
Insert into keywords (kw) values ('UNKNOWN');
GO
Insert into keywords (kw) values ('DEC');
GO
Insert into keywords (kw) values ('ORDINALITY');
GO
Insert into keywords (kw) values ('UNNEST');
GO
Insert into keywords (kw) values ('DECIMAL');
GO
Insert into keywords (kw) values ('OUT');
GO
Insert into keywords (kw) values ('USAGE');
GO
Insert into keywords (kw) values ('DEFERRABLE');
GO
Insert into keywords (kw) values ('OVERLAY');
GO
Insert into keywords (kw) values ('USING');
GO
Insert into keywords (kw) values ('DEFERRED');
GO
Insert into keywords (kw) values ('OUTPUT');
GO
Insert into keywords (kw) values ('VALUE');
GO
Insert into keywords (kw) values ('DEPTH');
GO
Insert into keywords (kw) values ('PAD');
GO
Insert into keywords (kw) values ('VAR_POP');
GO
Insert into keywords (kw) values ('DEREF');
GO
Insert into keywords (kw) values ('PARAMETER');
GO
Insert into keywords (kw) values ('VAR_SAMP');
GO
Insert into keywords (kw) values ('DESCRIBE');
GO
Insert into keywords (kw) values ('PARAMETERS');
GO
Insert into keywords (kw) values ('VARCHAR');
GO
Insert into keywords (kw) values ('DESCRIPTOR');
GO
Insert into keywords (kw) values ('PARTIAL');
GO
Insert into keywords (kw) values ('VARIABLE');
GO
Insert into keywords (kw) values ('DESTROY');
GO
Insert into keywords (kw) values ('PARTITION');
GO
Insert into keywords (kw) values ('WHENEVER');
GO
Insert into keywords (kw) values ('DESTRUCTOR');
GO
Insert into keywords (kw) values ('PATH');
GO
Insert into keywords (kw) values ('WIDTH_BUCKET');
GO
Insert into keywords (kw) values ('DETERMINISTIC');
GO
Insert into keywords (kw) values ('POSTFIX');
GO
Insert into keywords (kw) values ('WITHOUT');
GO
Insert into keywords (kw) values ('DICTIONARY');
GO
Insert into keywords (kw) values ('PREFIX');
GO
Insert into keywords (kw) values ('WINDOW');
GO
Insert into keywords (kw) values ('DIAGNOSTICS');
GO
Insert into keywords (kw) values ('PREORDER');
GO
Insert into keywords (kw) values ('WITHIN');
GO
Insert into keywords (kw) values ('DISCONNECT');
GO
Insert into keywords (kw) values ('PREPARE');
GO
Insert into keywords (kw) values ('WORK');
GO
Insert into keywords (kw) values ('DOMAIN');
GO
Insert into keywords (kw) values ('PERCENT_RANK');
GO
Insert into keywords (kw) values ('WRITE');
GO
Insert into keywords (kw) values ('DYNAMIC');
GO
Insert into keywords (kw) values ('PERCENTILE_CONT');
GO
Insert into keywords (kw) values ('XMLAGG');
GO
Insert into keywords (kw) values ('EACH');
GO
Insert into keywords (kw) values ('PERCENTILE_DISC');
GO
Insert into keywords (kw) values ('XMLATTRIBUTES');
GO
Insert into keywords (kw) values ('ELEMENT');
GO
Insert into keywords (kw) values ('POSITION_REGEX');
GO
Insert into keywords (kw) values ('XMLBINARY');
GO
Insert into keywords (kw) values ('END-EXEC');
GO
Insert into keywords (kw) values ('PRESERVE');
GO
Insert into keywords (kw) values ('XMLCAST');
GO
Insert into keywords (kw) values ('EQUALS');
GO
Insert into keywords (kw) values ('PRIOR');
GO
Insert into keywords (kw) values ('XMLCOMMENT');
GO
Insert into keywords (kw) values ('EVERY');
GO
Insert into keywords (kw) values ('PRIVILEGES');
GO
Insert into keywords (kw) values ('XMLCONCAT');
GO
Insert into keywords (kw) values ('EXCEPTION');
GO
Insert into keywords (kw) values ('RANGE');
GO
Insert into keywords (kw) values ('XMLDOCUMENT');
GO
Insert into keywords (kw) values ('FALSE');
GO
Insert into keywords (kw) values ('READS');
GO
Insert into keywords (kw) values ('XMLELEMENT');
GO
Insert into keywords (kw) values ('FILTER');
GO
Insert into keywords (kw) values ('REAL');
GO
Insert into keywords (kw) values ('XMLEXISTS');
GO
Insert into keywords (kw) values ('FIRST');
GO
Insert into keywords (kw) values ('RECURSIVE');
GO
Insert into keywords (kw) values ('XMLFOREST');
GO
Insert into keywords (kw) values ('FLOAT');
GO
Insert into keywords (kw) values ('REF');
GO
Insert into keywords (kw) values ('XMLITERATE');
GO
Insert into keywords (kw) values ('FOUND');
GO
Insert into keywords (kw) values ('REFERENCING');
GO
Insert into keywords (kw) values ('XMLNAMESPACES');
GO
Insert into keywords (kw) values ('FREE');
GO
Insert into keywords (kw) values ('REGR_AVGX');
GO
Insert into keywords (kw) values ('XMLPARSE');
GO
Insert into keywords (kw) values ('FULLTEXTTABLE');
GO
Insert into keywords (kw) values ('REGR_AVGY');
GO
Insert into keywords (kw) values ('XMLPI');
GO
Insert into keywords (kw) values ('FUSION');
GO
Insert into keywords (kw) values ('REGR_COUNT');
GO
Insert into keywords (kw) values ('XMLQUERY');
GO
Insert into keywords (kw) values ('GENERAL');
GO
Insert into keywords (kw) values ('REGR_INTERCEPT');
GO
Insert into keywords (kw) values ('XMLSERIALIZE');
GO
Insert into keywords (kw) values ('GET');
GO
Insert into keywords (kw) values ('REGR_R2');
GO
Insert into keywords (kw) values ('XMLTABLE');
GO
Insert into keywords (kw) values ('GLOBAL');
GO
Insert into keywords (kw) values ('REGR_SLOPE');
GO
Insert into keywords (kw) values ('XMLTEXT');
GO
Insert into keywords (kw) values ('GO');
GO
Insert into keywords (kw) values ('REGR_SXX');
GO
Insert into keywords (kw) values ('XMLVALIDATE');
GO
Insert into keywords (kw) values ('GROUPING');
GO
Insert into keywords (kw) values ('REGR_SXY');
GO
Insert into keywords (kw) values ('YEAR');
GO
Insert into keywords (kw) values ('HOLD');
GO
Insert into keywords (kw) values ('REGR_SYY');
GO
Insert into keywords (kw) values ('ZONE');
GO
Insert into keywords (kw) values ('ABSOLUTE');
GO
Insert into keywords (kw) values ('EXEC');
GO
Insert into keywords (kw) values ('OVERLAPS');
GO
Insert into keywords (kw) values ('ACTION');
GO
Insert into keywords (kw) values ('EXECUTE');
GO
Insert into keywords (kw) values ('PAD');
GO
Insert into keywords (kw) values ('ADA');
GO
Insert into keywords (kw) values ('EXISTS');
GO
Insert into keywords (kw) values ('PARTIAL');
GO
Insert into keywords (kw) values ('ADD');
GO
Insert into keywords (kw) values ('EXTERNAL');
GO
Insert into keywords (kw) values ('PASCAL');
GO
Insert into keywords (kw) values ('ALL');
GO
Insert into keywords (kw) values ('EXTRACT');
GO
Insert into keywords (kw) values ('POSITION');
GO
Insert into keywords (kw) values ('ALLOCATE');
GO
Insert into keywords (kw) values ('FALSE');
GO
Insert into keywords (kw) values ('PRECISION');
GO
Insert into keywords (kw) values ('ALTER');
GO
Insert into keywords (kw) values ('FETCH');
GO
Insert into keywords (kw) values ('PREPARE');
GO
Insert into keywords (kw) values ('AND');
GO
Insert into keywords (kw) values ('FIRST');
GO
Insert into keywords (kw) values ('PRESERVE');
GO
Insert into keywords (kw) values ('ANY');
GO
Insert into keywords (kw) values ('FLOAT');
GO
Insert into keywords (kw) values ('PRIMARY');
GO
Insert into keywords (kw) values ('ARE');
GO
Insert into keywords (kw) values ('FOR');
GO
Insert into keywords (kw) values ('PRIOR');
GO
Insert into keywords (kw) values ('AS');
GO
Insert into keywords (kw) values ('FOREIGN');
GO
Insert into keywords (kw) values ('PRIVILEGES');
GO
Insert into keywords (kw) values ('ASC');
GO
Insert into keywords (kw) values ('FORTRAN');
GO
Insert into keywords (kw) values ('PROCEDURE');
GO
Insert into keywords (kw) values ('ASSERTION');
GO
Insert into keywords (kw) values ('FOUND');
GO
Insert into keywords (kw) values ('PUBLIC');
GO
Insert into keywords (kw) values ('AT');
GO
Insert into keywords (kw) values ('FROM');
GO
Insert into keywords (kw) values ('READ');
GO
Insert into keywords (kw) values ('AUTHORIZATION');
GO
Insert into keywords (kw) values ('FULL');
GO
Insert into keywords (kw) values ('REAL');
GO
Insert into keywords (kw) values ('AVG');
GO
Insert into keywords (kw) values ('GET');
GO
Insert into keywords (kw) values ('REFERENCES');
GO
Insert into keywords (kw) values ('BEGIN');
GO
Insert into keywords (kw) values ('GLOBAL');
GO
Insert into keywords (kw) values ('RELATIVE');
GO
Insert into keywords (kw) values ('BETWEEN');
GO
Insert into keywords (kw) values ('GO');
GO
Insert into keywords (kw) values ('RESTRICT');
GO
Insert into keywords (kw) values ('BIT');
GO
Insert into keywords (kw) values ('GOTO');
GO
Insert into keywords (kw) values ('REVOKE');
GO
Insert into keywords (kw) values ('BIT_LENGTH');
GO
Insert into keywords (kw) values ('GRANT');
GO
Insert into keywords (kw) values ('RIGHT');
GO
Insert into keywords (kw) values ('BOTH');
GO
Insert into keywords (kw) values ('GROUP');
GO
Insert into keywords (kw) values ('ROLLBACK');
GO
Insert into keywords (kw) values ('BY');
GO
Insert into keywords (kw) values ('HAVING');
GO
Insert into keywords (kw) values ('ROWS');
GO
Insert into keywords (kw) values ('CASCADE');
GO
Insert into keywords (kw) values ('HOUR');
GO
Insert into keywords (kw) values ('SCHEMA');
GO
Insert into keywords (kw) values ('CASCADED');
GO
Insert into keywords (kw) values ('IDENTITY');
GO
Insert into keywords (kw) values ('SCROLL');
GO
Insert into keywords (kw) values ('CASE');
GO
Insert into keywords (kw) values ('IMMEDIATE');
GO
Insert into keywords (kw) values ('SECOND');
GO
Insert into keywords (kw) values ('CAST');
GO
Insert into keywords (kw) values ('IN');
GO
Insert into keywords (kw) values ('SECTION');
GO
Insert into keywords (kw) values ('CATALOG');
GO
Insert into keywords (kw) values ('INCLUDE');
GO
Insert into keywords (kw) values ('SELECT');
GO
Insert into keywords (kw) values ('CHAR');
GO
Insert into keywords (kw) values ('INDEX');
GO
Insert into keywords (kw) values ('SESSION');
GO
Insert into keywords (kw) values ('CHAR_LENGTH');
GO
Insert into keywords (kw) values ('INDICATOR');
GO
Insert into keywords (kw) values ('SESSION_USER');
GO
Insert into keywords (kw) values ('CHARACTER');
GO
Insert into keywords (kw) values ('INITIALLY');
GO
Insert into keywords (kw) values ('SET');
GO
Insert into keywords (kw) values ('CHARACTER_LENGTH');
GO
Insert into keywords (kw) values ('INNER');
GO
Insert into keywords (kw) values ('SIZE');
GO
Insert into keywords (kw) values ('CHECK');
GO
Insert into keywords (kw) values ('INPUT');
GO
Insert into keywords (kw) values ('SMALLINT');
GO
Insert into keywords (kw) values ('CLOSE');
GO
Insert into keywords (kw) values ('INSENSITIVE');
GO
Insert into keywords (kw) values ('SOME');
GO
Insert into keywords (kw) values ('COALESCE');
GO
Insert into keywords (kw) values ('INSERT');
GO
Insert into keywords (kw) values ('SPACE');
GO
Insert into keywords (kw) values ('COLLATE');
GO
Insert into keywords (kw) values ('INT');
GO
Insert into keywords (kw) values ('SQL');
GO
Insert into keywords (kw) values ('COLLATION');
GO
Insert into keywords (kw) values ('INTEGER');
GO
Insert into keywords (kw) values ('SQLCA');
GO
Insert into keywords (kw) values ('COLUMN');
GO
Insert into keywords (kw) values ('INTERSECT');
GO
Insert into keywords (kw) values ('SQLCODE');
GO
Insert into keywords (kw) values ('COMMIT');
GO
Insert into keywords (kw) values ('INTERVAL');
GO
Insert into keywords (kw) values ('SQLERROR');
GO
Insert into keywords (kw) values ('CONNECT');
GO
Insert into keywords (kw) values ('INTO');
GO
Insert into keywords (kw) values ('SQLSTATE');
GO
Insert into keywords (kw) values ('CONNECTION');
GO
Insert into keywords (kw) values ('IS');
GO
Insert into keywords (kw) values ('SQLWARNING');
GO
Insert into keywords (kw) values ('CONSTRAINT');
GO
Insert into keywords (kw) values ('ISOLATION');
GO
Insert into keywords (kw) values ('SUBSTRING');
GO
Insert into keywords (kw) values ('CONSTRAINTS');
GO
Insert into keywords (kw) values ('JOIN');
GO
Insert into keywords (kw) values ('SUM');
GO
Insert into keywords (kw) values ('CONTINUE');
GO
Insert into keywords (kw) values ('KEY');
GO
Insert into keywords (kw) values ('SYSTEM_USER');
GO
Insert into keywords (kw) values ('CONVERT');
GO
Insert into keywords (kw) values ('LANGUAGE');
GO
Insert into keywords (kw) values ('TABLE');
GO
Insert into keywords (kw) values ('CORRESPONDING');
GO
Insert into keywords (kw) values ('LAST');
GO
Insert into keywords (kw) values ('TEMPORARY');
GO
Insert into keywords (kw) values ('COUNT');
GO
Insert into keywords (kw) values ('LEADING');
GO
Insert into keywords (kw) values ('THEN');
GO
Insert into keywords (kw) values ('CREATE');
GO
Insert into keywords (kw) values ('LEFT');
GO
Insert into keywords (kw) values ('TIME');
GO
Insert into keywords (kw) values ('CROSS');
GO
Insert into keywords (kw) values ('LEVEL');
GO
Insert into keywords (kw) values ('TIMESTAMP');
GO
Insert into keywords (kw) values ('CURRENT');
GO
Insert into keywords (kw) values ('LIKE');
GO
Insert into keywords (kw) values ('TIMEZONE_HOUR');
GO
Insert into keywords (kw) values ('CURRENT_DATE');
GO
Insert into keywords (kw) values ('LOCAL');
GO
Insert into keywords (kw) values ('TIMEZONE_MINUTE');
GO
Insert into keywords (kw) values ('CURRENT_TIME');
GO
Insert into keywords (kw) values ('LOWER');
GO
Insert into keywords (kw) values ('TO');
GO
Insert into keywords (kw) values ('CURRENT_TIMESTAMP');
GO
Insert into keywords (kw) values ('MATCH');
GO
Insert into keywords (kw) values ('TRAILING');
GO
Insert into keywords (kw) values ('CURRENT_USER');
GO
Insert into keywords (kw) values ('MAX');
GO
Insert into keywords (kw) values ('TRANSACTION');
GO
Insert into keywords (kw) values ('CURSOR');
GO
Insert into keywords (kw) values ('MIN');
GO
Insert into keywords (kw) values ('TRANSLATE');
GO
Insert into keywords (kw) values ('DATE');
GO
Insert into keywords (kw) values ('MINUTE');
GO
Insert into keywords (kw) values ('TRANSLATION');
GO
Insert into keywords (kw) values ('DAY');
GO
Insert into keywords (kw) values ('MODULE');
GO
Insert into keywords (kw) values ('TRIM');
GO
Insert into keywords (kw) values ('DEALLOCATE');
GO
Insert into keywords (kw) values ('MONTH');
GO
Insert into keywords (kw) values ('TRUE');
GO
Insert into keywords (kw) values ('DEC');
GO
Insert into keywords (kw) values ('NAMES');
GO
Insert into keywords (kw) values ('UNION');
GO
Insert into keywords (kw) values ('DECIMAL');
GO
Insert into keywords (kw) values ('NATIONAL');
GO
Insert into keywords (kw) values ('UNIQUE');
GO
Insert into keywords (kw) values ('DECLARE');
GO
Insert into keywords (kw) values ('NATURAL');
GO
Insert into keywords (kw) values ('UNKNOWN');
GO
Insert into keywords (kw) values ('DEFAULT');
GO
Insert into keywords (kw) values ('NCHAR');
GO
Insert into keywords (kw) values ('UPDATE');
GO
Insert into keywords (kw) values ('DEFERRABLE');
GO
Insert into keywords (kw) values ('NEXT');
GO
Insert into keywords (kw) values ('UPPER');
GO
Insert into keywords (kw) values ('DEFERRED');
GO
Insert into keywords (kw) values ('NO');
GO
Insert into keywords (kw) values ('USAGE');
GO
Insert into keywords (kw) values ('DELETE');
GO
Insert into keywords (kw) values ('NONE');
GO
Insert into keywords (kw) values ('USER');
GO
Insert into keywords (kw) values ('DESC');
GO
Insert into keywords (kw) values ('NOT');
GO
Insert into keywords (kw) values ('USING');
GO
Insert into keywords (kw) values ('DESCRIBE');
GO
Insert into keywords (kw) values ('NULL');
GO
Insert into keywords (kw) values ('VALUE');
GO
Insert into keywords (kw) values ('DESCRIPTOR');
GO
Insert into keywords (kw) values ('NULLIF');
GO
Insert into keywords (kw) values ('VALUES');
GO
Insert into keywords (kw) values ('DIAGNOSTICS');
GO
Insert into keywords (kw) values ('NUMERIC');
GO
Insert into keywords (kw) values ('VARCHAR');
GO
Insert into keywords (kw) values ('DISCONNECT');
GO
Insert into keywords (kw) values ('OCTET_LENGTH');
GO
Insert into keywords (kw) values ('VARYING');
GO
Insert into keywords (kw) values ('DISTINCT');
GO
Insert into keywords (kw) values ('OF');
GO
Insert into keywords (kw) values ('VIEW');
GO
Insert into keywords (kw) values ('DOMAIN');
GO
Insert into keywords (kw) values ('ON');
GO
Insert into keywords (kw) values ('WHEN');
GO
Insert into keywords (kw) values ('DOUBLE');
GO
Insert into keywords (kw) values ('ONLY');
GO
Insert into keywords (kw) values ('WHENEVER');
GO
Insert into keywords (kw) values ('DROP');
GO
Insert into keywords (kw) values ('OPEN');
GO
Insert into keywords (kw) values ('WHERE');
GO
Insert into keywords (kw) values ('ELSE');
GO
Insert into keywords (kw) values ('OPTION');
GO
Insert into keywords (kw) values ('WITH');
GO
Insert into keywords (kw) values ('END');
GO
Insert into keywords (kw) values ('OR');
GO
Insert into keywords (kw) values ('WORK');
GO
Insert into keywords (kw) values ('END-EXEC');
GO
Insert into keywords (kw) values ('ORDER');
GO
Insert into keywords (kw) values ('WRITE');
GO
Insert into keywords (kw) values ('ESCAPE');
GO
Insert into keywords (kw) values ('OUTER');
GO
Insert into keywords (kw) values ('YEAR');
GO
Insert into keywords (kw) values ('EXCEPT');
GO
Insert into keywords (kw) values ('OUTPUT');
GO
Insert into keywords (kw) values ('ZONE');
GO
Insert into keywords (kw) values ('EXCEPTION');
GO
Insert into keywords (kw) values ('ADD');
GO
Insert into keywords (kw) values ('EXTERNAL');
GO
Insert into keywords (kw) values ('PROCEDURE');
GO
Insert into keywords (kw) values ('ALL');
GO
Insert into keywords (kw) values ('FETCH');
GO
Insert into keywords (kw) values ('PUBLIC');
GO
Insert into keywords (kw) values ('ALTER');
GO
Insert into keywords (kw) values ('FILE');
GO
Insert into keywords (kw) values ('RAISERROR');
GO
Insert into keywords (kw) values ('AND');
GO
Insert into keywords (kw) values ('FILLFACTOR');
GO
Insert into keywords (kw) values ('READ');
GO
Insert into keywords (kw) values ('ANY');
GO
Insert into keywords (kw) values ('FOR');
GO
Insert into keywords (kw) values ('READTEXT');
GO
Insert into keywords (kw) values ('AS');
GO
Insert into keywords (kw) values ('FOREIGN');
GO
Insert into keywords (kw) values ('RECONFIGURE');
GO
Insert into keywords (kw) values ('ASC');
GO
Insert into keywords (kw) values ('FREETEXT');
GO
Insert into keywords (kw) values ('REFERENCES');
GO
Insert into keywords (kw) values ('AUTHORIZATION');
GO
Insert into keywords (kw) values ('FREETEXTTABLE');
GO
Insert into keywords (kw) values ('REPLICATION');
GO
Insert into keywords (kw) values ('BACKUP');
GO
Insert into keywords (kw) values ('FROM');
GO
Insert into keywords (kw) values ('RESTORE');
GO
Insert into keywords (kw) values ('BEGIN');
GO
Insert into keywords (kw) values ('FULL');
GO
Insert into keywords (kw) values ('RESTRICT');
GO
Insert into keywords (kw) values ('BETWEEN');
GO
Insert into keywords (kw) values ('FUNCTION');
GO
Insert into keywords (kw) values ('RETURN');
GO
Insert into keywords (kw) values ('BREAK');
GO
Insert into keywords (kw) values ('GOTO');
GO
Insert into keywords (kw) values ('REVERT');
GO
Insert into keywords (kw) values ('BROWSE');
GO
Insert into keywords (kw) values ('GRANT');
GO
Insert into keywords (kw) values ('REVOKE');
GO
Insert into keywords (kw) values ('BULK');
GO
Insert into keywords (kw) values ('GROUP');
GO
Insert into keywords (kw) values ('RIGHT');
GO
Insert into keywords (kw) values ('BY');
GO
Insert into keywords (kw) values ('HAVING');
GO
Insert into keywords (kw) values ('ROLLBACK');
GO
Insert into keywords (kw) values ('CASCADE');
GO
Insert into keywords (kw) values ('HOLDLOCK');
GO
Insert into keywords (kw) values ('ROWCOUNT');
GO
Insert into keywords (kw) values ('CASE');
GO
Insert into keywords (kw) values ('IDENTITY');
GO
Insert into keywords (kw) values ('ROWGUIDCOL');
GO
Insert into keywords (kw) values ('CHECK');
GO
Insert into keywords (kw) values ('IDENTITY_INSERT');
GO
Insert into keywords (kw) values ('RULE');
GO
Insert into keywords (kw) values ('CHECKPOINT');
GO
Insert into keywords (kw) values ('IDENTITYCOL');
GO
Insert into keywords (kw) values ('SAVE');
GO
Insert into keywords (kw) values ('CLOSE');
GO
Insert into keywords (kw) values ('IF');
GO
Insert into keywords (kw) values ('SCHEMA');
GO
Insert into keywords (kw) values ('CLUSTERED');
GO
Insert into keywords (kw) values ('IN');
GO
Insert into keywords (kw) values ('SECURITYAUDIT');
GO
Insert into keywords (kw) values ('COALESCE');
GO
Insert into keywords (kw) values ('INDEX');
GO
Insert into keywords (kw) values ('SELECT');
GO
Insert into keywords (kw) values ('COLLATE');
GO
Insert into keywords (kw) values ('INNER');
GO
Insert into keywords (kw) values ('SEMANTICKEYPHRASETABLE');
GO
Insert into keywords (kw) values ('COLUMN');
GO
Insert into keywords (kw) values ('INSERT');
GO
Insert into keywords (kw) values ('SEMANTICSIMILARITYDETAILSTABLE');
GO
Insert into keywords (kw) values ('COMMIT');
GO
Insert into keywords (kw) values ('INTERSECT');
GO
Insert into keywords (kw) values ('SEMANTICSIMILARITYTABLE');
GO
Insert into keywords (kw) values ('COMPUTE');
GO
Insert into keywords (kw) values ('INTO');
GO
Insert into keywords (kw) values ('SESSION_USER');
GO
Insert into keywords (kw) values ('CONSTRAINT');
GO
Insert into keywords (kw) values ('IS');
GO
Insert into keywords (kw) values ('SET');
GO
Insert into keywords (kw) values ('CONTAINS');
GO
Insert into keywords (kw) values ('JOIN');
GO
Insert into keywords (kw) values ('SETUSER');
GO
Insert into keywords (kw) values ('CONTAINSTABLE');
GO
Insert into keywords (kw) values ('KEY');
GO
Insert into keywords (kw) values ('SHUTDOWN');
GO
Insert into keywords (kw) values ('CONTINUE');
GO
Insert into keywords (kw) values ('KILL');
GO
Insert into keywords (kw) values ('SOME');
GO
Insert into keywords (kw) values ('CONVERT');
GO
Insert into keywords (kw) values ('LEFT');
GO
Insert into keywords (kw) values ('STATISTICS');
GO
Insert into keywords (kw) values ('CREATE');
GO
Insert into keywords (kw) values ('LIKE');
GO
Insert into keywords (kw) values ('SYSTEM_USER');
GO
Insert into keywords (kw) values ('CROSS');
GO
Insert into keywords (kw) values ('LINENO');
GO
Insert into keywords (kw) values ('TABLE');
GO
Insert into keywords (kw) values ('CURRENT');
GO
Insert into keywords (kw) values ('LOAD');
GO
Insert into keywords (kw) values ('TABLESAMPLE');
GO
Insert into keywords (kw) values ('CURRENT_DATE');
GO
Insert into keywords (kw) values ('MERGE');
GO
Insert into keywords (kw) values ('TEXTSIZE');
GO
Insert into keywords (kw) values ('CURRENT_TIME');
GO
Insert into keywords (kw) values ('NATIONAL');
GO
Insert into keywords (kw) values ('THEN');
GO
Insert into keywords (kw) values ('CURRENT_TIMESTAMP');
GO
Insert into keywords (kw) values ('NOCHECK');
GO
Insert into keywords (kw) values ('TO');
GO
Insert into keywords (kw) values ('CURRENT_USER');
GO
Insert into keywords (kw) values ('NONCLUSTERED');
GO
Insert into keywords (kw) values ('TOP');
GO
Insert into keywords (kw) values ('CURSOR');
GO
Insert into keywords (kw) values ('NOT');
GO
Insert into keywords (kw) values ('TRAN');
GO
Insert into keywords (kw) values ('DATABASE');
GO
Insert into keywords (kw) values ('NULL');
GO
Insert into keywords (kw) values ('TRANSACTION');
GO
Insert into keywords (kw) values ('DBCC');
GO
Insert into keywords (kw) values ('NULLIF');
GO
Insert into keywords (kw) values ('TRIGGER');
GO
Insert into keywords (kw) values ('DEALLOCATE');
GO
Insert into keywords (kw) values ('OF');
GO
Insert into keywords (kw) values ('TRUNCATE');
GO
Insert into keywords (kw) values ('DECLARE');
GO
Insert into keywords (kw) values ('OFF');
GO
Insert into keywords (kw) values ('TRY_CONVERT');
GO
Insert into keywords (kw) values ('DEFAULT');
GO
Insert into keywords (kw) values ('OFFSETS');
GO
Insert into keywords (kw) values ('TSEQUAL');
GO
Insert into keywords (kw) values ('DELETE');
GO
Insert into keywords (kw) values ('ON');
GO
Insert into keywords (kw) values ('UNION');
GO
Insert into keywords (kw) values ('DENY');
GO
Insert into keywords (kw) values ('OPEN');
GO
Insert into keywords (kw) values ('UNIQUE');
GO
Insert into keywords (kw) values ('DESC');
GO
Insert into keywords (kw) values ('OPENDATASOURCE');
GO
Insert into keywords (kw) values ('UNPIVOT');
GO
Insert into keywords (kw) values ('DISK');
GO
Insert into keywords (kw) values ('OPENQUERY');
GO
Insert into keywords (kw) values ('UPDATE');
GO
Insert into keywords (kw) values ('DISTINCT');
GO
Insert into keywords (kw) values ('OPENROWSET');
GO
Insert into keywords (kw) values ('UPDATETEXT');
GO
Insert into keywords (kw) values ('DISTRIBUTED');
GO
Insert into keywords (kw) values ('OPENXML');
GO
Insert into keywords (kw) values ('USE');
GO
Insert into keywords (kw) values ('DOUBLE');
GO
Insert into keywords (kw) values ('OPTION');
GO
Insert into keywords (kw) values ('USER');
GO
Insert into keywords (kw) values ('DROP');
GO
Insert into keywords (kw) values ('OR');
GO
Insert into keywords (kw) values ('VALUES');
GO
Insert into keywords (kw) values ('DUMP');
GO
Insert into keywords (kw) values ('ORDER');
GO
Insert into keywords (kw) values ('VARYING');
GO
Insert into keywords (kw) values ('ELSE');
GO
Insert into keywords (kw) values ('OUTER');
GO
Insert into keywords (kw) values ('VIEW');
GO
Insert into keywords (kw) values ('END');
GO
Insert into keywords (kw) values ('OVER');
GO
Insert into keywords (kw) values ('WAITFOR');
GO
Insert into keywords (kw) values ('ERRLVL');
GO
Insert into keywords (kw) values ('PERCENT');
GO
Insert into keywords (kw) values ('WHEN');
GO
Insert into keywords (kw) values ('ESCAPE');
GO
Insert into keywords (kw) values ('PIVOT');
GO
Insert into keywords (kw) values ('WHERE');
GO
Insert into keywords (kw) values ('EXCEPT');
GO
Insert into keywords (kw) values ('PLAN');
GO
Insert into keywords (kw) values ('WHILE');
GO
Insert into keywords (kw) values ('EXEC');
GO
Insert into keywords (kw) values ('PRECISION');
GO
Insert into keywords (kw) values ('WITH');
GO
Insert into keywords (kw) values ('EXECUTE');
GO
Insert into keywords (kw) values ('PRIMARY');
GO
Insert into keywords (kw) values ('WITHIN GROUP');
GO
Insert into keywords (kw) values ('EXISTS');
GO
Insert into keywords (kw) values ('PRINT');
GO
Insert into keywords (kw) values ('WRITETEXT');
GO
Insert into keywords (kw) values ('EXIT');
GO
Insert into keywords (kw) values ('PROC');
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
