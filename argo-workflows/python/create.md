To install [Couler](https://github.com/couler-proj/couler) Python SDK, you need Python 3 and [pip](https://github.com/pypa/pip):

`pip3 install git+https://github.com/couler-proj/couler@v0.1.1rc8`{{execute}}

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

`python3 example.py`{{execute}}

Then you can wait for it:

`argo wait @latest`{{execute}}

You should see something like:

```
STEP                 TEMPLATE   PODNAME                   DURATION  MESSAGE
 ✔ example-2tk55     example                                                                               
 ├───✔ flip-coin-17  flip-coin  example-2tk55-1879897647  11s                                              
 └─┬─✔ heads-18      heads      example-2tk55-1470248445  4s                                               
   └─○ tails-19      tails                                          when 'heads == tails' evaluated false 
```