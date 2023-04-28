-- Create the abilities_2nf table
CREATE TABLE IF NOT EXISTS abilities_2nf (
  abilities TEXT,
  abilityID INTEGER PRIMARY KEY AUTOINCREMENT
);

-- fill up abilities_2nf table
INSERT INTO abilities_2nf(abilities)
SELECT DISTINCT split_value
FROM final_1nf_table;

-- get rid of duplicates in abilities_2nf and rename it
CREATE TABLE second_nf_abilities AS
SELECT DISTINCT * FROM abilities_2nf;
DROP TABLE abilities_2nf;

-- create linking table
CREATE TABLE IF NOT EXISTS main_abilities (
    abilityID INTEGER,
    pokedex_number TEXT,
    FOREIGN KEY (abilityID) REFERENCES second_nf_abilities(abilityID),
    FOREIGN KEY (pokedex_number) REFERENCES final_1nf_table(pokedex_number)
);

-- fill in linking table
INSERT INTO main_abilities (abilityID, pokedex_number)
SELECT second_nf_abilities.abilityID, final_1nf_table.pokedex_number
FROM final_1nf_table
JOIN second_nf_abilities ON final_1nf_table.split_value = second_nf_abilities.abilities;

-- dropin the split_value column from 1nf table and rename it
ALTER TABLE final_1nf_table DROP column split_value;
ALTER TABLE final_1nf_table RENAME TO main;