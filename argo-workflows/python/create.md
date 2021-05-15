To install [Couler](https://github.com/couler-proj/couler) Python SDK, you need Python 3 and [pip](https://github.com/pypa/pip):

`pip3 install git+https://github.com/couler-proj/couler@v0.1.1rc8-stable`{{execute}}

The following example combines the use of a Python function result, along with conditionals,
to take a dynamic path in the workflow. In this example, depending on the result
of the first step defined in `flip_coin()` which executes the function `random_code()`,
the template will either run the `heads()` step or the `tails()` step.

Steps can be defined via either `couler.run_script()` for Python functions or
`couler.run_container()` for containers. In addition, the conditional logic to
decide whether to flip the coin in this example is defined via the combined use
of `couler.when()` and `couler.equal()`.

```python
import couler.argo as couler
from couler.argo_submitter import ArgoSubmitter


def random_code():
    import random
    res = "heads" if random.randint(0, 1) == 0 else "tails"
    print(res)

def flip_coin():
    return couler.run_script(image="python:alpine3.6", source=random_code)

def heads():
    return couler.run_container(
        image="alpine:3.6", command=["sh", "-c", 'echo "it was heads"']
    )

def tails():
    return couler.run_container(
        image="alpine:3.6", command=["sh", "-c", 'echo "it was tails"']
    )

result = flip_coin()
couler.when(couler.equal(result, "heads"), lambda: heads())
couler.when(couler.equal(result, "tails"), lambda: tails())

submitter = ArgoSubmitter(namespace="argo")
couler.run(submitter=submitter)
```

You can run this as follows:

`python3 coin_flip_example.py`{{execute}}

Then you can watch the execution flow of it:

`argo watch @latest`{{execute}}

You should see something like:

```
STEP                 TEMPLATE   PODNAME                   DURATION  MESSAGE
 ✔ example-2tk55     example                                                                               
 ├───✔ flip-coin-17  flip-coin  example-2tk55-1879897647  11s                                              
 └─┬─✔ heads-18      heads      example-2tk55-1470248445  4s                                               
   └─○ tails-19      tails                                          when 'heads == tails' evaluated false 
```

The next example demonstrates a different way to define the workflow as a directed-acyclic graph (DAG) by specifying the
dependencies of each task via `couler.set_dependencies()` or `couler.dag()`. Please see the code comments for the
specific shape of DAG that we've defined in `linear()` and `diamond()`.

```python
import couler.argo as couler
from couler.argo_submitter import ArgoSubmitter


def job(name):
    couler.run_container(
        image="docker/whalesay:latest",
        command=["cowsay"],
        args=[name],
        step_name=name,
    )

#     A
#    / \
#   B   C
#  /
# D
def linear():
    couler.set_dependencies(lambda: job(name="A"), dependencies=None)
    couler.set_dependencies(lambda: job(name="B"), dependencies=["A"])
    couler.set_dependencies(lambda: job(name="C"), dependencies=["A"])
    couler.set_dependencies(lambda: job(name="D"), dependencies=["B"])

#   A
#  / \
# B   C
#  \ /
#   D
def diamond():
    couler.dag(
        [
            [lambda: job(name="A")],
            [lambda: job(name="A"), lambda: job(name="B")],  # A -> B
            [lambda: job(name="A"), lambda: job(name="C")],  # A -> C
            [lambda: job(name="B"), lambda: job(name="D")],  # B -> D
            [lambda: job(name="C"), lambda: job(name="D")],  # C -> D
        ]
    )

linear()
submitter = ArgoSubmitter(namespace="argo")
couler.run(submitter=submitter)
```

You can run this as follows:

`python3 dag_example.py`{{execute}}

And then watch the execution flow until completion similar to the previous example:

`argo watch @latest`{{execute}}

## Exercise

* Edit dag_example.py and test the diamond pattern workflow and submit the workflow again
* Watch the execution flow using:
  `argo watch @latest`{{execute}}
