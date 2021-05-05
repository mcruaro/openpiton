#ifndef __BARRIER_H
#define __BARRIER_H

#include <stdio.h>
#include "util.h"

typedef struct {
	volatile int bar; //maybe volatile
    volatile int passed;
    int P;
} m_barrier;

static inline void barrier_init(m_barrier *barr, int thread_number){
    barr->P = thread_number;
    barr->bar = 0; // Counter of threads, faced barrier.
    barr->passed = 0; // Number of barriers, passed by all threads.
}


static inline void barrier_wait(m_barrier *barr, int core_id){

    int bar_ret, passed_old;
    //int passed_old = barr->passed; // Should be evaluated before incrementing *bar*!
    ATOMIC_FETCH_OP(passed_old, barr->passed, 0, add, w);
    
    //printf("p_old: %d\n", passed_old);
    //do { Maybe can fix an error of oreventing threads
    //Increment bar
    ATOMIC_FETCH_OP(bar_ret, barr->bar, 1, add, w);
    //} while(bar_ret < barr->P);
    //printf("bar_ret: %d bar: %d\n", bar_ret, barr->bar);
    
    //Test if all threads reached the barrier
    if(bar_ret == (barr->P - 1)) {

        //The last thread to reach the barrier will update the controll params.
        //passed++
        ATOMIC_OP(barr->passed, 1, add, w);
        //bar = 0
        ATOMIC_OP(barr->bar, 0, swap, w);

        //printf("core %d released barrier\n", core_id);
         
    } else {
        // Not the last thread. Wait others.
        printf("core %d blocked barrier\n", core_id);
         do {
            ATOMIC_OP(barr->passed, 0, add, w);
         } while(barr->passed == passed_old);
         //printf("core %d skiped barrier\n", core_id);
    }
   
   /*
    int passed_old = passed; // Should be evaluated before incrementing *bar*!

    if(__sync_fetch_and_add(&bar,1) == (P - 1)) {
        
        // The last thread, faced barrier.
        bar = 0;
        // *bar* should be reseted strictly before updating of barriers counter.
        __sync_synchronize(); 
        passed++; // Mark barrier as passed.
    
    } else {

        // Not the last thread. Wait others.
        while(passed == passed_old) {};
        // Need to synchronize cache with other threads, passed barrier.
        __sync_synchronize();
    }
    */
}


#endif //__BARRIER_H