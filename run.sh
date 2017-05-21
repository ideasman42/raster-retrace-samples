#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

rm -f output/*.svg
mkdir output -p

if [ -z "$RASTER_RETRACE" ]; then
	RASTER_RETRACE="raster-retrace"
fi

EXTRA_ARGS=""
# For easy commenting
EXTRA_ARGS="$EXTRA_ARGS --optimize-exhaustive"
EXTRA_ARGS="$EXTRA_ARGS --passes TANGENT,PIXEL"

set -x

$RASTER_RETRACE \
	--scale 2.0 \
	--error 1.5 \
	--input images/blob_simple.ppm \
	--output output/blob_simple.svg \
	--corner 0 \
	--pass-scale 1.0 \
	$EXTRA_ARGS

$RASTER_RETRACE \
	--scale 0.33 \
	--error 2.2 \
	--input images/tauro_2.ppm \
	--output output/tauro_2.svg \
	--corner 100 \
	$EXTRA_ARGS

$RASTER_RETRACE \
	--scale 0.66 \
	--error 5.0 \
	--input images/tauro_2_only_bull.ppm \
	--output output/tauro_2_only_bull.svg \
	--corner 100 \
	--pass-scale 1.5 \
	$EXTRA_ARGS


$RASTER_RETRACE \
	--scale 0.2 \
	--error 10.0 \
	--input images/jacqueline_face_i.ppm \
	--output output/jacqueline_face_i.svg \
	--corner 100 \
	--pass-scale 4 \
	$EXTRA_ARGS

$RASTER_RETRACE \
	--scale 0.2 \
	--error 14.0 \
	--input images/old_guitarist.ppm \
	--output output/old_guitarist.svg \
	--corner 100 \
	--mode CENTER \
	--pass-scale 5 \
	$EXTRA_ARGS

for f in $(find output -iname "*.svg"); do
	rsvg-convert "$f" > "${f%.svg}.png"
done
