
from sqlalchemy import create_engine, text

# Update with your credentials
engine = create_engine("postgresql+psycopg2://inesschwartz:your_password_here@localhost:5432/inesschwartz")

alter_statements = """
-- ALTER TABLE statements to add PRIMARY and FOREIGN KEYS

ALTER TABLE samples
  ADD CONSTRAINT samples_pkey PRIMARY KEY (sample_id),
  ADD CONSTRAINT samples_site_info_id_fkey FOREIGN KEY (site_info_id) REFERENCES site_info(site_info_id),
  ADD CONSTRAINT samples_horizon_id_fkey FOREIGN KEY (horizon_id) REFERENCES horizon_descriptions(horizon_id);

ALTER TABLE soil_profiles
  ADD CONSTRAINT soil_profiles_pkey PRIMARY KEY (profile_id),
  ADD CONSTRAINT soil_profiles_site_info_id_fkey FOREIGN KEY (site_info_id) REFERENCES site_info(site_info_id),
  ADD CONSTRAINT soil_profiles_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id),
  ADD CONSTRAINT soil_profiles_soil_type_id_fkey FOREIGN KEY (soil_type_id) REFERENCES soil_type(soil_type_id);

ALTER TABLE districts
  ADD CONSTRAINT districts_pkey PRIMARY KEY (distrito_id);

ALTER TABLE land_cover
  ADD CONSTRAINT land_cover_pkey PRIMARY KEY (land_id);

ALTER TABLE climate_features
  ADD CONSTRAINT climate_features_pkey PRIMARY KEY (climate_id);

ALTER TABLE topographic_features
  ADD CONSTRAINT topographic_features_pkey PRIMARY KEY (topo_features_id);

ALTER TABLE lab_info
  ADD CONSTRAINT lab_info_pkey PRIMARY KEY (lab_sample_id),
  ADD CONSTRAINT lab_info_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id),
  ADD CONSTRAINT lab_info_minerology_id_fkey FOREIGN KEY (minerology_id) REFERENCES minerology_info(minerology_id),
  ADD CONSTRAINT lab_info_p_fkey FOREIGN KEY (p) REFERENCES total_elements(total_elements_id),
  ADD CONSTRAINT lab_info_p2o5_fkey FOREIGN KEY (p2o5) REFERENCES total_elements(total_elements_id);

ALTER TABLE horizon_descriptions
  ADD CONSTRAINT horizon_descriptions_pkey PRIMARY KEY (horizon_id),
  ADD CONSTRAINT horizon_descriptions_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES soil_profiles(profile_id),
  ADD CONSTRAINT horizon_descriptions_color_id_fkey FOREIGN KEY (color_id) REFERENCES color(color_id);

ALTER TABLE biology_info
  ADD CONSTRAINT biology_info_pkey PRIMARY KEY (lab_sample_id);

ALTER TABLE geologic_features
  ADD CONSTRAINT geologic_features_pkey PRIMARY KEY (geology_info_id);

ALTER TABLE soil_type
  ADD CONSTRAINT soil_type_pkey PRIMARY KEY (soil_type_id);

ALTER TABLE site_info
  ADD CONSTRAINT site_info_pkey PRIMARY KEY (site_info_id),
  ADD CONSTRAINT site_info_land_cover_id_fkey FOREIGN KEY (land_cover_id) REFERENCES land_cover(land_id),
  ADD CONSTRAINT site_info_climate_id_fkey FOREIGN KEY (climate_id) REFERENCES climate_features(climate_id),
  ADD CONSTRAINT site_info_geology_id_fkey FOREIGN KEY (geology_id) REFERENCES geologic_features(geology_info_id),
  ADD CONSTRAINT site_info_topo_features_id_fkey FOREIGN KEY (topo_features_id) REFERENCES topographic_features(topo_features_id);

ALTER TABLE color
  ADD CONSTRAINT color_pkey PRIMARY KEY (color_id);

ALTER TABLE minerology_info
  ADD CONSTRAINT minerology_info_pkey PRIMARY KEY (minerology_id);

ALTER TABLE total_elements
  ADD CONSTRAINT total_elements_pkey PRIMARY KEY (total_elements_id),
  ADD CONSTRAINT total_elements_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id);
"""

with engine.connect() as conn:
    for statement in alter_statements.strip().split(';'):
        if statement.strip():
            conn.execute(text(statement + ';'))
