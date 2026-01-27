FROM alpine:3.20
RUN apk add --no-cache inotify-tools coreutils
CMD ["sh","-c","echo 'Starting tmpfs monitor (inotify+mode)...' >&2 && \
     stdbuf -oL inotifywait -m -r -e attrib,create,modify,open,close_write --format '%w%f' /tmp \
     | while IFS= read -r file; do \
         ts=$(date '+%Y-%m-%d %H:%M:%S'); \
         if [ ! -e \"$file\" ]; then \
           printf '%s ATTR_EVENT: %s missing\n' \"$ts\" \"$file\"; \
           continue; \
         fi; \
         perms=$(stat -c '%A' \"$file\" 2>/dev/null || echo '?????????'); \
         oct=$(stat -c '%a' \"$file\" 2>/dev/null || echo '????'); \
         # check exec bits and suid/sgid using portable tests
         exec_any=0; [ -x \"$file\" ] && exec_any=1; \
         suid=0; [ -u \"$file\" ] && suid=1; \
         sgid=0; [ -g \"$file\" ] && sgid=1; \
         flags=\"\"; [ $exec_any -ne 0 ] && flags=\"exec\"; [ $suid -ne 0 ] && flags=\"${flags:+$flags,}suid\"; [ $sgid -ne 0 ] && flags=\"${flags:+$flags,}sgid\"; \
         [ -z \"$flags\" ] && flags=\"-\"; \
         printf '%s ATTR_EVENT: %s mode=%s(%s) flags=%s\n' \"$ts\" \"$file\" \"$perms\" \"$oct\" \"$flags\"; \
       done"]
