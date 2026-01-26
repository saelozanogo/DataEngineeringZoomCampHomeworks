#!/usr/bin/env python
# coding: utf-8
import pandas as pd
from sqlalchemy import create_engine

# Read a sample of the data
prefix = 'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet'
df_trips = pd.read_parquet(prefix)


df_zones = pd.read_csv('https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv')
df_zones.head()

engine = create_engine('postgresql://root:root@db:5432/data_trips')


df_trips.to_sql(
        name="green_tripdata",
        con=engine,
        if_exists="replace"
    )


df_zones.to_sql(
        name="taxi_zone_lookup",
        con=engine,
        if_exists="replace"
    )