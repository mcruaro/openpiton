#ifndef __SEMAPHORE_H
#define __SEMAPHORE_H

//#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
//#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }

#include "spinlock.h"

/* Please don't access any members of this structure directly */
typedef struct {
	volatile unsigned int   lock;
	unsigned int		    count; //maybe volatile
} semaphore;


static inline void sema_init(semaphore *sem, int val) {
    sem->lock = 0;
    sem->count = val;
}

void up(semaphore *sem){

    int fail;
    int t0 = 1;

    //Spin lock
    do {
        ATOMIC_FETCH_OP(fail, sem->lock, t0, swap, w.aq);
    } while(fail);

    sem->count++;
    
    t0 = 0;//Not necessary since the swap above put zero in t0
    ATOMIC_OP(sem->lock, t0, swap, w.rl);
}

void down(semaphore *sem)
{

    int fail;
    int t0;
	//Try to get the lock to access critical section
	while (1){
		
        t0 = 1;
		//Spin lock
        do {
            ATOMIC_FETCH_OP(fail, sem->lock, t0, swap, w.aq);
        } while(fail);

		//Once achieved, test value of count 
		if (sem->count > 0){
			//If count > 0 decrement the count
			sem->count--;
			//Release the lock
			t0 = 0;//Not necessary since the swap above put zero in t0
            ATOMIC_OP(sem->lock, t0, swap, w.rl);
			//Exit the while, releasing the thread
			break;
		} 
		//Case count == 0 releases the lock and try again
		t0 = 0;//Not necessary since the swap above put zero in t0
        ATOMIC_OP(sem->lock, t0, swap, w.rl);
	}


}

#if 0
void up(semaphore *sem){

	//Try to get the lock to access critical section
    arch_spin_lock(sem->lock);

	//When lock is granted, add to the count
	sem->count++;
	//ATOMIC_OP(sem->count, 1, add, w);
	
	//Release the lock
	arch_unlock(sem->lock);

	/*
	unsigned long flags;
	raw_spin_lock_irqsave(&sem->lock, flags);
	if (likely(list_empty(&sem->wait_list)))
		sem->count++;
	else
		__up(sem);
	raw_spin_unlock_irqrestore(&sem->lock, flags);*/
}

void down(semaphore *sem)
{
	//Try to get the lock to access critical section
	while (1){
		
		//Tries to get the lock of semaphore
		arch_spin_lock(sem->lock);

		//Once achieved, test value of count 
		if (sem->count > 0){
			//If count > 0 decrement the count
			sem->count--;
			//Release the lock
			arch_unlock(sem->lock);
			//Exit the while, releasing the thread
			break;
		} 
		//Case count == 0 releases the lock and try again
		arch_unlock(sem->lock);
	}


}

#endif

#endif //__SEMAPHORE_H