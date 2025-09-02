#!/bin/bash

bash \
make-graph.bash \
    | dot \
    -Tpng \
    > completed-ongoing.png
