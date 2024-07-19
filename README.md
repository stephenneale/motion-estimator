# Motion Estimator System

Configured to run on an ARM 32-bit system.

## Commands

### Build

- Build without optimisations: `gcc -O0 -o main main.c`
- Build assembly code: `gcc -O0 -S -o main.s main.c`

### Run

- `./main`

### Benchmarks

Perf:

1. Compile code with gcc, ex: `gcc -0O -o main main.c`
2. `perf record ./main`
3. `perf report`

### Reports

Baseline perf report (no code optimization, or gcc optimization)

![perf-baseline](./assets/perf-baseline.png)

GCC optimization flag allowed

![perf-gcc-opti-only.png](./assets/perf-gcc-opti-only.png)