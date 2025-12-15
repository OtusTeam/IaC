set -x
yc managed-gitlab instance stop $YC_GL
yc managed-kubernetes cluster stop $YC_SA
# autostop with cluster:
# yc managed-kubernetes node-group stop group-1
#yc application-load-balancer load-balancer list 
# Командой выше ты получишь id балансировщика(ов)
#yc application-load-balancer load-balancer stop <id балансировщика>
set +x