CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUpdateEntry_safe`(entry_id varchar(100), value_field_01 varchar(100), 
value_field_02 varchar(100), value_field_03 double, value_field_04 double, value_field_05 varchar(100))
BEGIN
	DECLARE number_of_matching_entries int;
	
	DECLARE exit handler for sqlexception
		BEGIN
			-- ERROR
		ROLLBACK;
	END;
	
	DECLARE exit handler for sqlwarning
		BEGIN
			-- WARNING
		ROLLBACK;
	END;
	
	/* Make all the declarations before starting the transaction*/
	START TRANSACTION;
	
	SELECT count(*) INTO number_of_matching_entries 
	FROM table_to_update
	WHERE table_id=entry_id;
	
	IF number_of_matching_entries = 0 THEN
		/* need to insert */
		INSERT INTO table_to_update (`table_id`, `table_field_01`, `table_field_02`, `table_field_03`, `table_field_04`, `table_field_05`) 
		VALUES (entry_id, value_field_01, value_field_02, value_field_03, value_field_04, value_field_05);
	ELSE
		/* need to update */
		UPDATE table_to_update 
		SET table_field_01=value_field_01, 
			table_field_02=value_field_02,
			table_field_03=value_field_03,
			table_field_04=value_field_04,
			table_field_05=value_field_05
		WHERE	table_id=entry_id;
	
	END IF;
	
	COMMIT;
	
END