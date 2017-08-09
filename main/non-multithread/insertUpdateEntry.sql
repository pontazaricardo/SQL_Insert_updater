CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUpdateEntry`(entry_id varchar(100), value_field_01 varchar(100), 
value_field_02 varchar(100), value_field_03 double, value_field_04 double, value_field_05 varchar(100))
BEGIN

	declare number_of_matching_entries int;
	
	select count(*) into number_of_matching_entries 
	from table_to_update
	where table_id=entry_id;
	
	if number_of_matching_entries = 0 then
		/* need to insert */
		INSERT INTO table_to_update (`table_id`, `table_field_01`, `table_field_02`, `table_field_03`, `table_field_04`, `table_field_05`) 
		VALUES (entry_id, value_field_01, value_field_02, value_field_03, value_field_04, value_field_05);
	else
		/* need to update */
		UPDATE table_to_update 
		SET table_field_01=value_field_01, 
			table_field_02=value_field_02,
			table_field_03=value_field_03,
			table_field_04=value_field_04,
			table_field_05=value_field_05
		WHERE 	table_id=entry_id;
	end if;
	
END