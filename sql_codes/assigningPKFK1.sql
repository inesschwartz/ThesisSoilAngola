-- GEOLOGIC FEATURES
ALTER TABLE geo_feat
    ADD PRIMARY KEY (geo_features_id);

-- CLIMATE FEATURES
ALTER TABLE climate_feat
    ADD PRIMARY KEY (climate_id);

-- TOPO FEATURES
ALTER TABLE topo_feat
    ADD PRIMARY KEY (topo_id);

-- SOIL TYPE
ALTER TABLE soil_type
    ADD PRIMARY KEY (soil_type_id);

-- SITE INFO
ALTER TABLE site_info
    ADD PRIMARY KEY (site_info_id),
    ADD FOREIGN KEY (geo_features_id) REFERENCES geo_feat(geo_features_id),
    ADD FOREIGN KEY (climate_id) REFERENCES climate_feat(climate_id),
    ADD FOREIGN KEY (topo_id) REFERENCES topo_feat(topo_id),
    ADD FOREIGN KEY (soil_type_id) REFERENCES soil_type(soil_type_id);

-- SAMPLES (missing site_info_id(s))
ALTER TABLE samples
    ADD PRIMARY KEY (sample_id),
    ADD FOREIGN KEY (site_info_id) REFERENCES site_info(site_info_id);

-- MORPHO (missing sample_ids)
ALTER TABLE morpho
    ADD PRIMARY KEY (morpho_id),
    ADD FOREIGN KEY (sample_id) REFERENCES samples(sample_id);

-- LAB ANALYSES (missing sample_ids)
ALTER TABLE analyses
    ADD PRIMARY KEY (lab_sample_id),
    ADD FOREIGN KEY (sample_id) REFERENCES samples(sample_id),
    ADD FOREIGN KEY (morpho_id) REFERENCES morpho(morpho_id);

-- GEOLOGY MAPPING
ALTER TABLE geology_mapping
    ADD PRIMARY KEY (geology_code);

ALTER TABLE lithology_mapping
    ADD PRIMARY KEY (lithology_code);

ALTER TABLE lithology1954_mapping
    ADD PRIMARY KEY (lithology_1954_code);

-- GEOLOGY MAPPING LINK TO GEO_FEAT VIA geology_code
ALTER TABLE geo_feat
ADD CONSTRAINT fk_geo_feat_geology_code
FOREIGN KEY (geology_code)
REFERENCES geology_mapping (geology_code);

SELECT DISTINCT geology_code
FROM geo_feat
WHERE geology_code IS NOT NULL
  AND geology_code NOT IN (
      SELECT geology_code FROM geology_mapping
  );




-------DEALING W NULL DATA ------
-- SAMPLES
ALTER TABLE samples
    ADD PRIMARY KEY (sample_id),
    ADD FOREIGN KEY (site_info_id) REFERENCES site_info(site_info_id);

UPDATE samples
SET site_info_id = NULL
WHERE site_info_id = '';


-- MORPHO
UPDATE morpho
SET sample_id = NULL
WHERE sample_id = '';

ALTER TABLE morpho
    ADD PRIMARY KEY (morpho_id),
    ADD FOREIGN KEY (sample_id) REFERENCES samples(sample_id);

-- ANALYSES
ALTER TABLE analyses
    ADD PRIMARY KEY (lab_sample_id),
    ADD FOREIGN KEY (sample_id) REFERENCES samples(sample_id),
    ADD FOREIGN KEY (morpho_id) REFERENCES morpho(morpho_id);


---adding FK to analyses and morpho based on profile----
-- Ensure the `profile` column in morpho and analyses matches the data type in site_info
-- Add FK constraints
ALTER TABLE morpho
ADD CONSTRAINT morpho_profile_fkey
FOREIGN KEY (profile) REFERENCES site_info(profile);

---drop problematic fk constraints

-- first need to double check that there are no duplicate profiles in site_info
SELECT profile, COUNT(*) 
FROM site_info 
GROUP BY profile 
HAVING COUNT(*) > 1;
---> add unique constraint to site_info profile
ALTER TABLE site_info
ADD CONSTRAINT site_info_profile_unique UNIQUE (profile);

----Add the foreign key constraint to morpho:
ALTER TABLE morpho
ADD CONSTRAINT morpho_profile_fkey
FOREIGN KEY (profile) REFERENCES site_info(profile);

----Add the foreign key constraint to analyses:
ALTER TABLE analyses
ADD CONSTRAINT analyses_profile_fkey
FOREIGN KEY (profile) REFERENCES site_info(profile);


-- 8 profiles in analyses NOT in site_info, deleted those profiles
SELECT DISTINCT profile
FROM analyses
WHERE profile IS NOT NULL
  AND profile NOT IN (
    SELECT profile FROM site_info
);
DELETE FROM analyses
WHERE profile NOT IN (
  SELECT profile FROM site_info
);

---check that database has all the fk constraints
SELECT 
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    tc.constraint_name
FROM 
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
WHERE 
    tc.constraint_type = 'FOREIGN KEY';

-- test queries
SELECT s.sample_id, s.year, si.profile
FROM samples s
JOIN site_info si ON s.site_info_id = si.site_info_id
LIMIT 10;

SELECT m.morpho_id, m.profile, si.site_info_id
FROM morpho m
JOIN site_info si ON m.profile = si.profile
LIMIT 10;

SELECT a.analysis_id, a.profile, si.site_info_id
FROM analyses a
JOIN site_info si ON a.profile = si.profile
LIMIT 10;

-- check for orphan records
SELECT * 
FROM samples s
LEFT JOIN site_info si ON s.site_info_id = si.site_info_id
WHERE si.site_info_id IS NULL;
----- 4270 sample_ids from samples w no site_info :( 

SELECT * 
FROM morpho m
LEFT JOIN site_info si ON m.profile = si.profile
WHERE si.profile IS NULL;
----- 0 morpho_id's w/o site info











