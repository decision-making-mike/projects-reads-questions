# TODOs

## Completed reads osage Graphviz graph creation

Create it and verify if it looks good enough to be put beside the one already in the repository. For example,

graph {
    layout=osage
    pack=0
    subgraph cluster_computers {
        label="computers"
        subgraph cluster_computers_rest {
            label="computers-rest"
            subgraph cluster_computers_rest_rest {
                label="computers-rest-rest"
                pack=10
            }
            subgraph cluster_computers_rest_text_processing {
                label="text-processing"
                pack=10
            }
        }
    }
}

## Missing READMEs addition

Add missing READMEs to all projects. This way the projects shall be easier to navigate for a casual visitor.
