DIR=$PWD/mount
while [[ $# -gt 0 ]]; do
  case "$1" in
    --mount)
      DIR=$DIR/$2
      shift 2 ;;
    --*)
      echo "Unknown flag $1"
      exit 1 ;;
  esac
done

mkdir -p $DIR
cp ../../full_data.tar ./mount/full_data.tar
docker rm yolo-dataset
docker run --gpus all --entrypoint "/bin/bash" -it --name yolo-dataset \
       -p 5000:5000 -p 6006:6006\
       --mount type=bind,src=${DIR},dst=/opt/ml/model \
       gcperkins/yolo-dataset:latest
# --entrypoint "/bin/bash" -it