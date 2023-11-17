We learned that a DAG template is a type of *orchestration* template. What other types of *orchestration* templates are there?

A **steps template** allows you to run a series of steps in sequence.

A **suspend template** allows you to automatically suspend a workflow, e.g. while waiting on manual approval, or while
an external system does some work.

Orchestration templates **do NOT** run pods.
You can check by running `kubectl get pods`{{execute}}.
