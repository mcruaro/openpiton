
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Simple dataflow application implementing fork and join
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"

#define N 5

semaphore mutex;
semaphore empty;
semaphore full;

int rand = 0;

int produce_item(){
    return (rand++);
}

void insert_item(int item, int index){
    printf("Prod inserting %d\n", index);
}

void consume_item(int index){
    printf("Cons removing %d\n", index);
}   

void producer(){
    int item;
    while(1){
        item = produce_item();
        down(&empty);
        down(&mutex);
        insert_item(item, full.count);
        up(&mutex);
        up(&full);
    }

}

void consumer(){
    //barrier_wait(&barrier_it, 2);

    int item;
    while(1){
        item = produce_item();
        down(&full);
        down(&mutex);
        consume_item(full.count);
        up(&mutex);
        up(&empty);
        //Just to make consumer slower than producer
        for (volatile int i = 0; i < 1000; i++);
    }
    
}

int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    sema_init(&mutex, 1);
    sema_init(&empty, N);
    sema_init(&full, 0);
    //barrier_init(&barrier_it, 2); 2 is number of threads


    switch(core_id){
        case 0:
            producer();
            break;
        case 1:
            consumer();
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }


    return 0;

}
