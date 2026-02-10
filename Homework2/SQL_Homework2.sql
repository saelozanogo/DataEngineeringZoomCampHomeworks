CREATE OR REPLACE EXTERNAL TABLE `data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://data-zoomcamp-nyc-tl-data/rides_dataset/rides/yellow_tripdata_2024_0*.parquet']
);

CREATE OR REPLACE TABLE data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned AS
SELECT * FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata;

SELECT COUNT(*) FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata;

SELECT COUNT(*) FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned;

SELECT COUNT(DISTINCT pu_location_id) FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata;

SELECT COUNT(DISTINCT pu_location_id) FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned;

SELECT pu_location_id FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned;

SELECT pu_location_id, do_location_id FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned;

SELECT COUNT(*) FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned WHERE fare_amount = 0;

CREATE OR REPLACE TABLE data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_partitioned_clustered
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY Vendor_id AS
SELECT * FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned;


SELECT DISTINCT vendor_id FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_partitioned_clustered WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' and '2024-03-15';

SELECT DISTINCT vendor_id FROM data-zoomcamp-bigquery.nytaxi.external_yellow_tripdata_non_partitioned WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' and '2024-03-15';
