#!/bin/bash
# Download the datasets used in the ML notebooks to correct relative_paths (../input/...)

set -e

if [ -d input ]
then
    exit 0
fi

mkdir -p input

DATASETS="dansbecker/melbourne-housing-snapshot iabhishekofficial/mobile-price-classification pavanraj159/predicting-a-pulsar-star"

for slug in $DATASETS
do
    name=`echo $slug | cut -d '/' -f 2`
    dest="input/$name"
    mkdir -p $dest
    kaggle d download -p $dest --unzip $slug
done

COMPDATASETS="home-data-for-ml-course"

for comp in $COMPDATASETS
do 
    dest="input/$comp"
    mkdir -p $dest
    kaggle competitions download $comp -p $dest
    cd $dest
    unzip ${comp}.zip
    chmod 700 *.csv
    cp *.csv ..
    cd ../..
done

COMPDATASET="titanic"

for comp in $COMPDATASET
do 
    dest="input/$comp"
    mkdir -p $dest
    kaggle competitions download $comp -p $dest
    cd $dest
    unzip ${comp}.zip
    chmod 700 *.csv
    cd ..
done
