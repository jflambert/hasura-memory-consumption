#!/bin/bash
while :
do
curl --location --request POST 'http://localhost:8080/v1/graphql' \
    --header 'Content-Type: application/json' \
    -s \
    -o /dev/null \
    --write-out "%{url_effective} sent %{size_download} bytes in %{time_total} seconds\n" \
    --data-raw '{"query":"query MyQuery {\n      wifi_tracking(limit: 1500000) {\n        wt_location_area\n        wt_location_details\n        wt_location_easting\n        wt_location_elevation\n        wt_location_id\n        wt_location_label\n        wt_location_northing\n        wt_mobile_company_name\n        wt_mobile_crew_name\n        wt_mobile_department_name\n        wt_mobile_details\n        wt_mobile_equipment_category\n        wt_mobile_id\n        wt_mobile_label\n        wt_mobile_position_name\n        wt_mobile_type\n        wt_mobile_type_identifier\n        wt_rssi\n      }\n    }","variables":{}}'
sleep 5
done