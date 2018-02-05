import numpy as np
import os
 
CURRENT_DIR = os.path.abspath(os.path.dirname(__file__))
DATASET_DIR = os.path.abspath(os.path.join(CURRENT_DIR, '../../../datasets/horda-transport-dataset/images'))
TXT_DIR = os.path.abspath(os.path.join(CURRENT_DIR, './data'))
print DATASET_DIR
print TXT_DIR

background_dir = os.path.join(DATASET_DIR, 'background')
good_dir = os.path.join(DATASET_DIR, 'good')
bad_dir = os.path.join(DATASET_DIR, 'bad')

background_images = [image for image in os.listdir(background_dir) if not image.startswith('.')]
good_images = [image for image in os.listdir(good_dir) if not image.startswith('.')]
bad_images = [image for image in os.listdir(bad_dir) if not image.startswith('.')]
print 'background_images'
print background_images
print 'good images'
print good_images
print 'bad images'
print bad_images

np.random.shuffle(background_images)
np.random.shuffle(good_images)
np.random.shuffle(bad_images)

background_train = background_images[:int(len(background_images)*0.8)]
background_test = background_images[int(len(background_images)*0.8):]

good_train = good_images[:int(len(good_images)*0.8)]
good_test = good_images[int(len(good_images)*0.8):]
 
bad_train = bad_images[:int(len(bad_images)*0.8)]
bad_test = bad_images[int(len(bad_images)*0.8):]
 
with open('{}/train.txt'.format(TXT_DIR), 'w') as f:
    for image in background_train:
        f.write('{} 0\n'.format(image))
    for image in good_train:
        f.write('{} 1\n'.format(image))
    for image in bad_train:
        f.write('{} 2\n'.format(image))
    f.close()
 
with open('{}/val.txt'.format(TXT_DIR), 'w') as f:
    for image in background_test:
        f.write('{} 0\n'.format(image))
    for image in good_test:
        f.write('{} 1\n'.format(image))
    for image in bad_test:
        f.write('{} 2\n'.format(image))
    f.close()