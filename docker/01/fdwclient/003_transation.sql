BEGIN;

SELECT * FROM users ORDER BY update_date DESC;

SELECT * FROM foreign_tenant ORDER BY update_date DESC;

INSERT INTO users VALUES('Emi', 'aab', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO foreign_tenant VALUES(2, 'restrant102', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM users ORDER BY update_date DESC;

SELECT * FROM foreign_tenant ORDER BY update_date DESC;

-- INSERT INTO foreign_tenant VALUES(2, 'restrant103', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- UPDATE foreign_tenant set tenant_name = 'grocery102' , update_date = CURRENT_TIMESTAMP where tenant_id =2;
-- UPDATE foreign_tenant set tenant_name = 'drug102' , update_date = CURRENT_TIMESTAMP where tenant_id =2;
-- UPDATE foreign_tenant set tenant_name = 'restrant102' , update_date = CURRENT_TIMESTAMP where tenant_id =2;

-- DELETE FROM foreign_tenant WHERE tenant_id = 2 ;
-- DELETE FROM users WHERE user_id = 'Emi' ;

-- ROLLBACK;
-- COMMIT;

