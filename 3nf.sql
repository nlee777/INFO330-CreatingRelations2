-- Create the type table
CREATE TABLE IF NOT EXISTS type (
  type1 TEXT,
  type2 TEXT,
  typeID INTEGER PRIMARY KEY AUTOINCREMENT
);

-- Fill up the type1 and type2 columns
INSERT INTO type (type1, type2)
SELECT DISTINCT type1, type2
FROM main;

-- create against table
CREATE TABLE IF NOT EXISTS against (
    typeID INT,
    against_bug TEXT,
    against_dark TEXT,
    against_dragon TEXT,
    against_electric TEXT,
    against_fairy TEXT,
    against_fight TEXT,
    against_fire TEXT,
    against_flying TEXT,
    against_ghost TEXT,
    against_grass TEXT,
    against_ground TEXT,
    against_ice TEXT,
    against_normal TEXT, 
    against_poison TEXT,
    against_psychic TEXT,
    against_rock TEXT,
    against_steel TEXT,
    against_water TEXT,
    FOREIGN KEY (typeID) REFERENCES type(typeID)
);

-- fill in the type and against columns
INSERT INTO against(
    typeID,     
    against_bug,
    against_dark,
    against_dragon,
    against_electric,
    against_fairy,
    against_fight,
    against_fire,
    against_flying,
    against_ghost,
    against_grass,
    against_ground,
    against_ice,
    against_normal, 
    against_poison,
    against_psychic,
    against_rock,
    against_steel,
    against_water
)
SELECT 
    type.typeID,     
    main.against_bug,
    main.against_dark,
    main.against_dragon,
    main.against_electric,
    main.against_fairy,
    main.against_fight,
    main.against_fire,
    main.against_flying,
    main.against_ghost,
    main.against_grass,
    main.against_ground,
    main.against_ice,
    main.against_normal, 
    main.against_poison,
    main.against_psychic,
    main.against_rock,
    main.against_steel,
    main.against_water
FROM type
JOIN main
ON main.type1 = type.type1
AND main.type2 = type.type2
GROUP BY type.typeID;







