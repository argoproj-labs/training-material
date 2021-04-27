A DAG is an orchestration template. What other types of *orchestration* template are there?

A **steps template** allows you to run a series of steps in sequence.

A **suspend templates** allows you to automatically suspend a workflows, e.g. while waiting on manual approval, or while
an external system does some work.

None of the templates that orchestrate work run pods. You can check by `kubectl get pods`{{execute}}.