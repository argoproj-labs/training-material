Artifact is a fancy name for a file that is compressed and stored in object storage (S3, MinIO, GCS, etc.).

There are two kind of artifacts in Argo:

* An **input artifact** is a file downloaded from storage (i.e. S3) and mounted as a volume within the container.
* An **output artifact** is a file created in the container that is uploaded to storage.

Artifacts are typically uploaded into a bucket within some kind of storage such as AWS S3 or GCP GCS. We call that storage an
**artifact repository**. Within these lessons we'll be using MinIO for this purpose, but you can just imagine it is S3
or what ever you're used to.

## Output Artifacts

Each task within a workflow can produce output artifacts. To specify an output artifact, you must include `outputs` in
the manifest. Each output artifact declares:

* The **path** within the container where it can be found.
* A **name** so that it can be referred to.

```yaml
    - name: save-message
      container:
        image: docker/whalesay
        command: [ sh, -c ]
        args: [ "cowsay hello world > /tmp/hello_world.txt" ]
      outputs:
        artifacts:
          - name: hello-art
            path: /tmp/hello_world.txt
```

When the container completes, the file is copied out of it, compressed, and stored.

Files can also be directories, so when a directory is found all the files are compressed into an archive and stored.

## Input Artifacts

To declare an input artifact, you must include `inputs` in the manifest. Each input artifact must declare:

* Its **name**
* The **path** where it should be created

```yaml
    - name: print-message
      inputs:
        artifacts:
          - name: message
            path: /tmp/message
      container:
        image: docker/whalesay
        command: [ sh, -c ]
        args: [ "cat /tmp/message" ]
```

If the artifact was a compressed directory, it will be uncompressed and unpacked into the path.

## Inputs and Outputs

You can't use inputs and outputs in isolation, you need to combine them together using either a steps or a DAG template, as in the below example:

```yaml
    - name: main
      dag:
        tasks:
          - name: generate-artifact
            template: save-message
          - name: consume-artifact
            template: print-message
            dependencies:
              - generate-artifact
            arguments:
              artifacts:
                - name: message
                  from: "{{tasks.generate-artifact.outputs.artifacts.hello-art}}"
```

In the above example, `arguments` is used to declare the value for the artifact input. This uses a **template tag**. In
this example, `{{tasks.generate-artifact.outputs.artifacts.hello-art}}` becomes the path of the artifact in the
repository.

The task `consume-artifact` must run after `generate-artifact`, so we use `dependencies` to declare that relationship.

Let's see the complete DAG workflow:

`cat artifacts-workflow.yaml`{{execute}}

Let's run an example:

`argo submit --watch artifacts-workflow.yaml`{{execute}}

You should see:

```bash
STEP                    TEMPLATE       PODNAME                     DURATION  MESSAGE
 ✔ artifacts-qvcpn      main
 ├─✔ generate-artifact  save-message   artifacts-qvcpn-3260493969  7s
 └─✔ consume-artifact   print-message  artifacts-qvcpn-2991781604  8s
```
