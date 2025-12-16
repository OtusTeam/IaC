set -x
yc managed-gitlab instance start $YC_GL
yc managed-kubernetes cluster start $YC_SA
# autostop with cluster:
# yc managed-kubernetes node-group start group-1
#yc application-load-balancer load-balancer list 
# Командой выше ты получишь id балансировщика(ов)
#yc application-load-balancer load-balancer start <id балансировщика>
set +x