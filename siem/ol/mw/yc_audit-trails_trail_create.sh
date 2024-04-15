yc audit-trails trail create \
  --name mw-trail \
  --description "mw" \
  --service-account-id ajeo3f9qr5tlur3h6f1n \
  --destination-log-group-id e235llcqoau2dmt6jscv \
  --filter-from-organisation-id bpfrtqbajbhpm5j05tkl \
  --filter-some-cloud-ids $YC_CLOUD_ID
#  --filter-all-organisation-id string 
#       Specifies the ID of the organisation from which all default events will be collected. 
#       see: 
# yc storage bucket list
# yc organization-manager organization list
#  --filter-from-organisation-id <идентификатор_организации> \
#  --filter-some-cloud-ids <список_облаков_в_организации>
