SET search_path TO public;

-- GEOLOGIC FEATURES
CREATE TABLE geo_feat (
    geo_features_id SERIAL PRIMARY KEY,
    geology_id TEXT,
    lithology_id TEXT,
    lithology_1954_id TEXT
);

-- CLIMATE FEATURES
CREATE TABLE climate_feat (
    climate_id SERIAL PRIMARY KEY,
    mean_annual_temp FLOAT,
    mean_annual_precip FLOAT,
    koppen_climate VARCHAR,
    thornthwaite_climate VARCHAR,
    hydric_regime VARCHAR,
    thermal_regime VARCHAR
);

-- TOPOGRAPHIC FEATURES
CREATE TABLE topo_feat (
    topo_features_id SERIAL PRIMARY KEY,
    slope_code VARCHAR,
    altitude FLOAT,
    aspect VARCHAR,
    land_surface_temp FLOAT,
    dem_elevation FLOAT
);

-- SOIL TYPE
CREATE TABLE soil_type (
    soil_type_id SERIAL PRIMARY KEY,
    profile VARCHAR,
    CEP_GR VARCHAR,
    CEP_NAME VARCHAR,
    FAO VARCHAR
);

-- SITE INFO
CREATE TABLE site_info (
    site_info_id SERIAL PRIMARY KEY,
    profile VARCHAR,
    X_coord FLOAT,
    Y_coord FLOAT,
    district VARCHAR,
    geo_features_id INT REFERENCES geo_feat(geo_features_id),
    climate_id INT REFERENCES climate_feat(climate_id),
    topo_features_id INT REFERENCES topo_feat(topo_features_id)
);

-- SOIL PROFILES
CREATE TABLE soil_profiles (
    profile_record_id SERIAL PRIMARY KEY,
    profile VARCHAR,
    site_info_id INT REFERENCES site_info(site_info_id),
    sample_id INT,
    soil_type_id INT REFERENCES soil_type(soil_type_id)
);

-- SAMPLES
CREATE TABLE samples (
    sample_id SERIAL PRIMARY KEY,
    site_info_id INT REFERENCES site_info(site_info_id),
    profile VARCHAR,
    horizon_id VARCHAR,
    year INT,
    shelf VARCHAR,
    room VARCHAR
);

-- MORPHOLOGY HORIZON
CREATE TABLE morphology_horizon (
    horizon_id VARCHAR PRIMARY KEY,
    sample_id INT REFERENCES samples(sample_id),
    profile_record_id INT REFERENCES soil_profiles(profile_record_id),
    horizon_layer VARCHAR,
    upper_depth FLOAT,
    lower_depth FLOAT,
    moisture_degree VARCHAR,
    root_quantity VARCHAR,
    root_diameter VARCHAR,
    texture VARCHAR,
    structure_type VARCHAR,
    structure_class VARCHAR,
    structure_degree VARCHAR,
    pore_diameter VARCHAR,
    pore_quantity VARCHAR,
    pore_shape VARCHAR,
    dry_color_name VARCHAR,
    dry_hue VARCHAR,
    dry_value INT,
    dry_chroma FLOAT,
    moist_color_name VARCHAR,
    moist_hue VARCHAR,
    moist_value INT,
    moist_chroma FLOAT,
    compaction VARCHAR,
    durability VARCHAR
);

-- ANALYSES
CREATE TABLE analyses (
    lab_sample_id SERIAL PRIMARY KEY,
    sample_id INT REFERENCES samples(sample_id),
    EG FLOAT,
    thick_clay FLOAT,
    fine_clay FLOAT,
    silt FLOAT,
    clay FLOAT,
    Eq_Hum FLOAT,
    atm_1_3 FLOAT,
    atm_15 FLOAT,
    CACO3 FLOAT,
    gypsum FLOAT,
    free_iron FLOAT,
    organic_carbon FLOAT,
    total_N FLOAT,
    P205 FLOAT,
    organic_material FLOAT,
    pH_H2O FLOAT,
    pH_KCL FLOAT,
    Ca FLOAT,
    Mg FLOAT,
    Na FLOAT,
    K FLOAT,
    exchangable_bases_sum FLOAT,
    CEC FLOAT,
    vanadium FLOAT,
    conductivity FLOAT,
    soluble_sodium FLOAT,
    Min_lt_0002 FLOAT,
    Min_005_002 FLOAT,
    Min_02_005 FLOAT,
    Min_2_02 FLOAT,
    field_sample_code VARCHAR,
    Depth FLOAT,
    Al FLOAT,
    Si FLOAT,
    phosphorus FLOAT,
    sulfur FLOAT,
    Cl FLOAT,
    Ti FLOAT,
    Cr FLOAT,
    Mn FLOAT,
    Fe FLOAT,
    Co FLOAT,
    Ni FLOAT,
    Cu FLOAT,
    Zn FLOAT,
    arsenic FLOAT,
    Se FLOAT,
    Rb FLOAT,
    Sr FLOAT,
    Zr FLOAT,
    Nb FLOAT,
    Mo FLOAT,
    Cd FLOAT,
    Sn FLOAT,
    Sb FLOAT,
    Ba FLOAT,
    Ta FLOAT,
    W FLOAT,
    Pt FLOAT,
    Au FLOAT,
    Hg FLOAT,
    Tl FLOAT,
    Pb FLOAT,
    Bi FLOAT,
    Th FLOAT,
    U FLOAT
);

-- If minerology_info table is required
CREATE TABLE minerology_info (
    minerology_id SERIAL PRIMARY KEY,
    minerology_class INT,
    minerology_type INT,
    minerology_quantity INT
);

