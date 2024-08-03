# Experimental measures on the different redeployment strategies in nomad

## How to use

You need, running on your machine: nomad, consul and podman.
First, init the lab creating the volumes:

```
make init
```

Then you can create a job

```
make bump-<type>-<strategy>
```

where type is `stateless` or `stateful` and strategy is one of `canary`,
`rolling`, `blue-green` or `immediate`. The allowed combinations are

 |          |stateless|stateful|
 | -------: | :-----: | :----: |
 |canary    |    ✓    |        |
 |rolling   |    ✓    |   ✓    |
 |blue-green|    ✓    |        |
 |immediate |    ✓    |   ✓    |

To trigger a redeploy, invoke the same make target.

To stop the job

```
make stop-<type>-<strategy>
```

## Stateless

 - Canary: as expected, it rolls out 1 canary and waits for the healthchecks.
   Default is manual promotion.
 - Rolling: it first shuts down one alloc and spins up a newer one, passing to
   the next one after the healthchecks pass.
 - Blue/Green: rolls out all the new replicas and waits for healthchecks. Also
   in this case, the default is manual promotion.
 - Immediate: all replicas tore down at once, followed by the new ones.

## Stateful

 - Rolling: same behavior as the stateless
 - Immediate: same behavior as the stateless
