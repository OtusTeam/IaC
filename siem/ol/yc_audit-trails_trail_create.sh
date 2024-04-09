yc audit-trails trail create \
  --name otus-audit-trail \
  --description "otus audit trail" \
  --service-account-id aje5vjc1nssela771tiq \
  --destination-bucket otus-audit-log \
  --destination-bucket-object-prefix someprefix \
  --filter-from-organisation-id bpfrtqbajbhpm5j05tkl \
  --filter-some-cloud-ids $YC_CLOUD_ID
#  --filter-all-organisation-id string 
#       Specifies the ID of the organisation from which all default events will be collected. 
#       see: 
# yc storage bucket list
# yc organization-manager organization list
#  --filter-from-organisation-id <идентификатор_организации> \
#  --filter-some-cloud-ids <список_облаков_в_организации>
