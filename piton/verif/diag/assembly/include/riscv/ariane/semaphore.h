#ifndef __SEMAPHORE_H
#define __SEMAPHORE_H

//#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
//#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }

/* Please don't access any members of this structure directly */
typedef struct {
	volatile unsigned int   lock;
	unsigned int		    count; //maybe volatile
} semaphore;


static inline void sema_init(semaphore *sem, int val) {
    sem->lock = 0;
    sem->count = val;
}


/* RISC-V Spin lock and unlock implementations*/
static inline void riscv_spin_lock(semaphore *sem){
    int unlocked;
    //Spin lock
    do {
        ATOMIC_FETCH_OP(unlocked, sem->lock, 1, swap, w.aq);
    } while(unlocked);
}

static inline void riscv_unlock(semaphore *sem){
    ATOMIC_OP(sem->lock, 0, swap, w.rl);
}



/*UP and DOWN semaphore implementation*/

static inline void up(semaphore *sem){

    riscv_spin_lock(sem);

    sem->count++;
    
    riscv_unlock(sem);
}

static inline void down(semaphore *sem)
{

    //Down spin lock - while value == 0
	while (1){
		
		riscv_spin_lock(sem);

		//Once achieved, test value of count 
		if (sem->count > 0){
			//If count > 0 decrement the count
			sem->count--;
			//Release the lock
            riscv_unlock(sem);
			//Exit the while, releasing the thread
			break;
		} 
		//Case count == 0 releases the lock and try again
        riscv_unlock(sem);
	}

}

#if 0
static inline int arch_spin_trylock(semaphore *sem)
{
	int tmp = 1, busy;

	//If the lock is zero (busy == 0), its is free. 
	//Else, busy is 1, set 1 to busy and return false (busy == 1), since its lock

	__asm__ __volatile__ (
		"	amoswap.w %0, %2, %1\n"
		//RISCV_ACQUIRE_BARRIER //Commented because there are one hart per core
		: "=r" (busy), "+A" (sem->lock)
		: "r" (tmp)
		: "memory");

	return !busy;
}


static inline void arch_unlock(semaphore *sem)
{

	//Just decrement the lock by doing lock = lock - 1 (remember that lock is 1)
	__asm__ __volatile__(
		//RISCV_RELEASE_BARRIER //Commented because there are one hart per core
		"	amoadd.w x0, %1, %0\n"
		: "+A" (sem->lock)
		: "r" (-1)
		: "memory");
}

static inline void up(semaphore *sem){

	//Try to get the lock to access critical section
    while(arch_spin_trylock(sem));

	//When lock is granted, add to the count
	sem->count++;
	//ATOMIC_OP(sem->count, 1, add, w);
	
	//Release the lock
	arch_unlock(sem);

}

static inline void down(semaphore *sem)
{
	//Try to get the lock to access critical section
	while (1){
		
		//Tries to get the lock of semaphore
		while(arch_spin_trylock(sem));

		//Once achieved, test value of count 
		if (sem->count > 0){
			//If count > 0 decrement the count
			sem->count--;
			//Release the lock
			arch_unlock(sem);
			//Exit the while, releasing the thread
			break;
		} 
		//Case count == 0 releases the lock and try again
		arch_unlock(sem);
	}


}

#endif

#endif //__SEMAPHORE_H