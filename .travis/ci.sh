#!/bin/bash

mkdir -p build && cd build && 
cmake .. -DCMAKE_BUILD_TYPE=${BUILD_TYPE}
make -j8
