yc audit-trails trail create \
  --name maxpatrol-trail \
  --description "maxpatrol-trail" \
  --service-account-id ajevofu72sng1un31f6i \
  --destination-yds-stream maxpatrol-stream \
  --destination-yds-database-id etn15ekv9k10qttc410o \
  --filter-from-organisation-id bpfrtqbajbhpm5j05tkl \
  --filter-some-cloud-ids $YC_CLOUD_ID
#  --filter-all-organisation-id string 
#       Specifies the ID of the organisation from which all default events will be collected. 
#       see: 
# yc storage bucket list
# yc organization-manager organization list
#  --filter-from-organisation-id <идентификатор_организации> \
#  --filter-some-cloud-ids <список_облаков_в_организации>
