# My machine learning learning project

## Generating diagrams

### Prerequites

To generate a diagram, you need

- GNU Awk 5.0.1 (or higher version),
- graphviz version 13.1.0 (or higher version).

### Generating

#### Bash

To generate a PNG file with the diagram of the graph in the file `machine-learning.dot.txt` in Bash, run e.g.

```bash
gawk \
-f process-graph.gawk \
machine-learning.dot.txt \
    | neato -Tpng
```
