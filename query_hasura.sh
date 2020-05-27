#!/bin/bash
while :
do
curl -s http://localhost:8080/v1/graphql \
    -o /dev/null \
    --write-out "%{url_effective} sent %{size_download} bytes in %{time_total} seconds\n" \
    -d '{
    "query": "{
      wifi_tracking(limit: 1500000) {
        wt_location_area
        wt_location_details
        wt_location_easting
        wt_location_elevation
        wt_location_id
        wt_location_label
        wt_location_northing
        wt_mobile_company_name
        wt_mobile_crew_name
        wt_mobile_department_name
        wt_mobile_details
        wt_mobile_equipment_category
        wt_mobile_id
        wt_mobile_label
        wt_mobile_position_name
        wt_mobile_type
        wt_mobile_type_identifier
        wt_rssi
      }
    }"
  }'
sleep 5
done
