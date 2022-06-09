DROP TRIGGER if exist lock_house;

DROP EVENT if exist auto_update_paid;

DROP PROCEDURE if exist update_paid;

SET GLOBAL event_scheduler = ON;

CREATE TRIGGER lock_house after insert
ON orders for each row update houses

SET available = 0
WHERE id = new.hid; 

DELIMITER $

CREATE trigger unlock_house after update
ON orders for each row begin if new.status <> old.status AND new.status = 2 THEN update houses

SET available = 1
WHERE id = new.hid; end if; end $

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE update_paid() BEGIN UPDATE Orders

SET paid = 0
WHERE type = 1; END$$ 

DELIMITER;

CREATE EVENT auto_update_paid
ON SCHEDULE EVERY 1 MONTH STARTS (
SELECT  start_time
FROM Orders)
ON COMPLETION PRESERVE DO CALL update_paid();
