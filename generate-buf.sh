#Variables - DO NOT CHANGE
NAME_DIR_PROTO=/temp/proto-models
DIR_REMOTE=/temp/buf-gen

cd $DIR_REMOTE

# buf lint
buf lint

# buf generate
buf generate

chmod 777 -R $DIR_REMOTE/gen