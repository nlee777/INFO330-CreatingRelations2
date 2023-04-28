-- creates table used to split abilities into individual abilities
CREATE TABLE IF NOT EXISTS split_abilities AS
SELECT abilities, 
       trim(value) AS split_value
FROM imported_pokemon_data, 
     json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE split_value <> '';

-- join the rows
CREATE TABLE temp_table AS
SELECT split_abilities.split_value, imported_pokemon_data.* FROM imported_pokemon_data
JOIN split_abilities
ON split_abilities.abilities = imported_pokemon_data.abilities;

-- drop the og table's abilities column
ALTER TABLE temp_table
DROP COLUMN abilities;

-- get rid of duplicate rows
CREATE TABLE final_1nf_table AS
SELECT DISTINCT * FROM temp_table;

-- get rid of brackets and quotes
UPDATE final_1nf_table
SET split_value = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(split_value, '[', ''), ']', ''), '''', ''), '"', ''));

-- drop all the temp tables
DROP TABLE split_abilities;
DROP TABLE temp_table;