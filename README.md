# Fun with STM!

This repo is a small demonstration of using blocking on `TVar`s between a REPL and evaluation function. The main intent is to support a step-by-step interpreter in another project.

An example can be seen in the output below,

```
*Main> main
Starting repl...
>> next 3
Adding 3 steps!
   Took a step 2
   Took a step 1
   Took a step 0
>> next 2
Adding 2 steps!
   Took a step 1
   Took a step 0
>>
```

The REPL wait's for user input, and upon specifying a number of steps (i.e. evaluation steps) to run, it sets a `TVar` and blocks the repl until the steps reach _0_. In another thread, our evaluation is waiting on the number of steps to be *not* _0_, and once set it will start its evaluation.


The structure is heavily inspired by the [ReaderT design pattern](https://www.fpcomplete.com/blog/2017/06/readert-design-pattern).
