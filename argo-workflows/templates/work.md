What other types of *work* template are there?

A **container set** allows you to run multiple containers in a single pod. This is useful when you want the containers
to share a common workspace.

A **data template** allows you get data from storage (e.g. S3). This is useful when each item of data represents an item
of work that needs doing.

A **resource template** allows you to create a Kubernetes resource and wait for it to meet a condition (e.g. successful)
. This is useful if you want to interoperate with another Kubernetes system, Spark EMR.

A **script template** allows you to run a script in a container. This is very similar to a container template, but when
you've added a script to it.

Every type of templates that does work does it by running a pod. So you can use `kubectl` to view these pods:

`kubectl get pods`{{execute}}
