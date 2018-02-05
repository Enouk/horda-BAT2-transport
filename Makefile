NAME = horda-transport-caffe-model

DATASET_NAME = horda-transport-dataset
DATASET_DIR = ../../../datasets/$(DATASET_NAME)
DATA_DIR = ./data
DATA_IMAGE_DIR = ./data/images
RELEASE_DIR = ./release

clean:
	-rm -rf $(DATA_IMAGE_DIR);
	-rm $(DATA_DIR)/*.txt
	-rm $(DATA_DIR)/mean.binaryproto
	-rm -rf db/*

all: clean copy_dataset create_train_val create_imagenet create_mean

copy_dataset:
	-rm -rf $(DATA_IMAGE_DIR);
	mkdir $(DATA_IMAGE_DIR);
	cp -r $(DATASET_DIR)/images/*/* $(DATA_IMAGE_DIR);

create_train_val:
	-rm $(DATA_DIR)/*.txt
	python create_train_val.py

create_imagenet:
	rm -rf db/*
	cd ../../;./examples/$(NAME)/create_imagenet.sh

create_mean:
	cd ../../;./examples/$(NAME)/make_imagenet_mean.sh

train:
	cd ../../;./build/tools/caffe train --solver=examples/$(NAME)/models/alexnet/solver.prototxt --weights models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel -gpu 0

classify:
	cd ../../;./build/examples/cpp_classification/classification.bin \
	  examples/$(NAME)/models/alexnet/deploy.prototxt \
	  examples/$(NAME)/models/alexnet/caffe_alexnet_train_iter_300.caffemodel \
	  examples/$(NAME)/data/mean.binaryproto \
	  examples/$(NAME)/models/alexnet/labels.txt \
	  examples/$(NAME)/data/images/bad-image0013.jpg

rel:
	rm -rf $(RELEASE_DIR);
	mkdir $(RELEASE_DIR);
	cp ./models/alexnet/deploy.prototxt $(RELEASE_DIR)/deploy.prototxt;
	cp ./models/alexnet/caffe_alexnet_train_iter_300.caffemodel $(RELEASE_DIR)/weights.caffemodel;
	cp ./data/mean.binaryproto $(RELEASE_DIR)/mean.binaryproto;
	cp ./models/alexnet/labels.txt $(RELEASE_DIR)/labels.txt;
	