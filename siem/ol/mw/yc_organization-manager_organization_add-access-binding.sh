#yc config profile activate default
yc organization-manager organization add-access-binding \
  --role compute.viewer \
  --id bpfrtqbajbhpm5j05tkl \
  --service-account-id ajeo3f9qr5tlur3h6f1n

yc organization-manager organization add-access-binding \
  --role logging.viewer \
  --id bpfrtqbajbhpm5j05tkl \
  --service-account-id ajeo3f9qr5tlur3h6f1n

yc organization-manager organization add-access-binding \
  --role logging.reader \
  --id bpfrtqbajbhpm5j05tkl \
  --service-account-id ajeo3f9qr5tlur3h6f1n

yc organization-manager organization add-access-binding \
  --role audit-trails.viewer \
  --id bpfrtqbajbhpm5j05tkl \
  --service-account-id ajeo3f9qr5tlur3h6f1n

# $YC_MW_SA_ID
