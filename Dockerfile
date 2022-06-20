FROM alpine:latest

COPY --from=mwader/static-ffmpeg:5.0 /ffmpeg /usr/local/bin/
COPY --from=mwader/static-ffmpeg:5.0 /ffprobe /usr/local/bin/

CMD set -xeu && : $STREAM_IN  && : $STREAM_OUT && while :; do ffmpeg -re -stats -loglevel info -fflags +genpts -i ${STREAM_IN} -codec:v copy -vsync 0 -copyts -start_at_zero -codec:a copy -bsf:a aac_adtstoasc -f flv ${STREAM_OUT};sleep 5; echo RESTARTING...; done
