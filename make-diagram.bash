#!/bin/bash

bash \
make-graph.bash \
    | dot \
    -Tpng \
    > completed-reads-organization.png
