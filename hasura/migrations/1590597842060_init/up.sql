CREATE TABLE wifi_tracking
(
  wt_timestamp TIMESTAMPTZ,
  wt_mobile MACADDR,
  wt_location MACADDR,
  wt_rssi INT,
  -- contextualization columns
  wt_mobile_type TEXT,
  wt_mobile_type_identifier TEXT,
  wt_mobile_id INTEGER,
  wt_mobile_label TEXT,
  wt_mobile_details TEXT,
  wt_mobile_company_name TEXT,
  wt_mobile_department_name TEXT,
  wt_mobile_position_name TEXT,
  wt_mobile_crew_name TEXT,
  wt_mobile_equipment_category TEXT,
  wt_location_id INTEGER,
  wt_location_label TEXT,
  wt_location_details TEXT,
  wt_location_area TEXT,
  wt_location_easting NUMERIC(38, 12),
  wt_location_northing NUMERIC(38, 12),
  wt_location_elevation NUMERIC(38, 12),
  CONSTRAINT wt_pk PRIMARY KEY (wt_timestamp, wt_mobile, wt_location)
);

-- apply timescaledb hypertable to wifi_tracking
SELECT create_hypertable('wifi_tracking', 'wt_timestamp');

-- enable compression
ALTER TABLE wifi_tracking SET (
  timescaledb.compress,
  timescaledb.compress_segmentby = 'wt_mobile, wt_location'
);

-- create a year's worth of wifi_tracking data
-- table size (5.1GB) can be found with `SELECT * FROM hypertable_relation_size_pretty('wifi_tracking');`
INSERT INTO wifi_tracking (wt_timestamp, wt_mobile, wt_location, wt_mobile_label, wt_location_label)
SELECT ts, '00:00:00:00:00:01', '00:00:DE:AD:BE:EF', ts::TEXT, ts::TEXT
FROM generate_series('2019-01-01'::TIMESTAMP, '2020-01-01'::TIMESTAMP, '1 seconds'::INTERVAL) ts;